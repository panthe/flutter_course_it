import 'package:redux/redux.dart';
import 'auth_state.dart';
import 'auth_actions.dart';

final authReducer = combineReducers<AuthState>([
  TypedReducer<AuthState,Loading>(_loading),
  TypedReducer<AuthState,LogInSuccessful>(_logIn),
  TypedReducer<AuthState,LogInSuccessful>(_checkLogIn),
  TypedReducer<AuthState,LogOutSuccessful>(_logOut),
]);

AuthState _loading(AuthState state, Loading action){
  return state.copyWith(isLoading: action.isLoading,
  );
}

AuthState _logIn(AuthState state, LogInSuccessful action){
  return state.copyWith(user: action.user, isLoading: action.isLoading,
      isAuthenticated: action.isAuthenticated);
}

AuthState _checkLogIn(AuthState state, LogInSuccessful action){
  return state.copyWith(user: action.user, isLoading: action.isLoading,
      isAuthenticated: action.isAuthenticated);
}

AuthState _logOut(AuthState state, LogOutSuccessful action) {
  return state.copyWith(user: action.user, isLoading: action.isLoading,
      isAuthenticated: action.isAuthenticated);
}