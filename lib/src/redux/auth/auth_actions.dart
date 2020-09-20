import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Loading {
  bool isLoading;

  Loading({
    @required this.isLoading,
  });
}

class LogInWithGoogle {}

class LogInEmailAndPassword {
  final String email;
  final String password;

  LogInEmailAndPassword({
    @required this.email,
    @required this.password,
  });
}

class LogInSuccessful {
  final bool isLoading;
  final bool isAuthenticated;
  final FirebaseUser user;

  LogInSuccessful({
    @required this.isLoading,
    @required this.isAuthenticated,
    @required this.user,
  });
}

class CheckLogIn {}

class ForgotPassword {
  bool isLoading = true;
  final String email;

  ForgotPassword({
    @required this.email,
  });
}

class SignUpEmailAndPassword {
  final String email;
  final String password;

  SignUpEmailAndPassword({
    @required this.email,
    @required this.password,
  });

}

class SignUpSuccessful {
  final bool isLoading;
  final bool isAuthenticated;
  final FirebaseUser user;

  SignUpSuccessful({
    @required this.isLoading,
    @required this.isAuthenticated,
    @required this.user,
  });

}

class LogOut {}

class LogOutSuccessful {
  final bool isLoading;
  final bool isAuthenticated;
  final FirebaseUser user;

  LogOutSuccessful({
    @required this.isLoading,
    @required this.isAuthenticated,
    @required this.user,
  });
}