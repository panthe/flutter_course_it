import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:redux/redux.dart';
import '../app/app_state.dart';
import 'auth_actions.dart';
import '../error/error_actions.dart';
import '../message/message_actions.dart';

List<Middleware<AppState>> createAuthMiddleware()  {
  final logIn = createLogInMiddleware();
  final logOut = createLogOutMiddleware();
  final signUp = createSignUpMiddleware();
  return [
    TypedMiddleware<AppState, LogInWithGoogle>(logIn),
    TypedMiddleware<AppState, LogInEmailAndPassword>(logIn),
    TypedMiddleware<AppState, CheckLogIn>(logIn),
    TypedMiddleware<AppState, ForgotPassword>(logIn),
    TypedMiddleware<AppState, SignUpEmailAndPassword>(signUp),
    TypedMiddleware<AppState, LogOut>(logOut),
  ];
}

Middleware<AppState> createLogInMiddleware() {
  return (Store store, dynamic action, NextDispatcher next) async {
    AuthResult authResult;
    FirebaseUser user;

    final FirebaseAuth _auth = FirebaseAuth.instance;

    if (action is LogInWithGoogle) {
      store.dispatch(Loading(isLoading: true));

      try {
        final GoogleSignIn _googleSignIn = GoogleSignIn();
        GoogleSignInAccount googleUser = await _googleSignIn.signIn();

        if(googleUser!=null) {
          GoogleSignInAuthentication googleAuth = await googleUser.authentication;
          final AuthCredential credential = GoogleAuthProvider.getCredential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );

          authResult = await _auth.signInWithCredential(credential);

          user = authResult.user;

          store.dispatch(LogInSuccessful(isLoading: false,
              isAuthenticated: true,
              user: user));
        }else{
          store.dispatch(Loading(isLoading: false));
        }
      } catch (error) {
        store.dispatch(ShowError(errorCode: error.hashCode, errorDescription: 'message_generic_error_auth'));
        store.dispatch(Loading(isLoading: false));
      }

    }

    if (action is LogInEmailAndPassword) {
      store.dispatch(Loading(isLoading: true));

      try {
        authResult = await _auth.signInWithEmailAndPassword(email: action.email, password: action.password);
        user = authResult.user;

        if (user.isEmailVerified) {
          store.dispatch(LogInSuccessful(isLoading: false,
              isAuthenticated: true,
              user: user));

        }else {
          user.sendEmailVerification();
          store.dispatch(ShowError(errorCode: 1, errorDescription: 'message_mail_to_validate_logInWithEmailPassword'));
          store.dispatch(Loading(isLoading: false));
        }
      } catch (error) {
        store.dispatch(ShowError(errorCode: error.hashCode, errorDescription: 'message_generic_error_auth'));
        store.dispatch(Loading(isLoading: false));
      }
    }

    if (action is CheckLogIn) {
      store.dispatch(Loading(isLoading: true));

      try {
        user = await _auth.currentUser();

        if (user == null){
          store.dispatch(Loading(isLoading: false));

          //Keys.navKey.currentState.pushReplacementNamed('/Login');
        } else {
          if (user.providerId != "firebase" || user.isEmailVerified) {

            store.dispatch(LogInSuccessful(isLoading: false,
                isAuthenticated: true,
                user: user));
          }else{
            store.dispatch(Loading(isLoading: false));

            user.sendEmailVerification();

            //Keys.navKey.currentState.pushReplacementNamed('/Login');
            store.dispatch(ShowMessage(messageCode: 1, messageDescription: 'message_mail_to_validate_on_checkLogIn'));
          }
        }
      } catch (error) {
        store.dispatch(ShowError(errorCode: error.hashCode, errorDescription: 'message_generic_error_auth'));
        store.dispatch(LogOut());
      }
      store.dispatch(Loading(isLoading: false));
    }

    if (action is ForgotPassword) {
      store.dispatch(Loading(isLoading: true));
      try {
        _auth.sendPasswordResetEmail(email: action.email);
        store.dispatch(ShowMessage(messageCode: 1, messageDescription: 'message_mail_to_validate_on_forgotPassword'));
        store.dispatch(Loading(isLoading: false));
      }catch (error) {
        store.dispatch(ShowError(errorCode: error.hashCode, errorDescription: 'message_generic_error_auth'));
        store.dispatch(Loading(isLoading: false));
      }
    }

    next(action);
  };
}

Middleware<AppState> createSignUpMiddleware() {
  return (Store store, dynamic action, NextDispatcher next) async {
    AuthResult authResult;
    FirebaseUser user;
    final FirebaseAuth _auth = FirebaseAuth.instance;

    if (action is SignUpEmailAndPassword) {
      store.dispatch(Loading(isLoading: true));

      try {
        authResult = await _auth.createUserWithEmailAndPassword(email: action.email, password: action.password);
        user = authResult.user;

        user.sendEmailVerification();
        
        store.dispatch(SignUpSuccessful(isLoading:false, isAuthenticated: false, user: null));
        //Keys.navKey.currentState.pushReplacementNamed('/Login');
        store.dispatch(ShowMessage(messageCode: 1, messageDescription: 'message_mail_to_validate_signUpWithEmailPassword'));

        /*
        UserProfile userProfile = new UserProfile(
            id: user.uid,
            nickName: action.nickName,
            isMale: action.isMale,
            dateOfBirth: action.dateOfBirth,
            email: action.email,
            updatedAt:Timestamp.now(),
            updaterUID: user.uid,
            createdAt:Timestamp.now(),
            creatorUID:user.uid
        );

        store.dispatch(SaveUserProfile(userProfile: userProfile, isNew: true));
         */
        store.dispatch(Loading(isLoading: false));
      } catch (error) {
        store.dispatch(ShowError(errorCode: error.hashCode, errorDescription: 'message_generic_error_auth'));
        store.dispatch(Loading(isLoading: false));
      }
    }

    next(action);
  };
}

Middleware<AppState> createLogOutMiddleware() {
  return (Store store, dynamic action, NextDispatcher next) async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    if (action is LogOut) {
      store.dispatch(Loading(isLoading: true));

      try {
        await FirebaseAuth.instance.signOut();
        await _googleSignIn.signOut();

        store.dispatch(LogOutSuccessful(isLoading: false, isAuthenticated: false, user: null));
        /*
        if (Keys.navKey.currentState.canPop()) {
          Keys.navKey.currentState.pop();
        }
        Keys.navKey.currentState.pushReplacementNamed('/Login');

         */
      } catch (error) {
        debugPrint('createSignUpMiddleware - Error' + error.toString());
        store.dispatch(ShowError(errorCode: error.hashCode, errorDescription: 'message_generic_error_auth'));
        store.dispatch(Loading(isLoading: false));
      }
    }

    next(action);
  };
}