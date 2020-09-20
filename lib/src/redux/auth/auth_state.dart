import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';

@immutable
class AuthState{
  final bool isAuthenticated;
  final bool isLoading;
  final FirebaseUser user;

  AuthState({
    this.isLoading,
    this.isAuthenticated,
    this.user
  });


  AuthState copyWith({
    bool isLoading,
    bool isAuthenticated,
    FirebaseUser user
  }){
    return new AuthState(
        isLoading: isLoading ?? this.isLoading,
        isAuthenticated: isAuthenticated ?? this.isAuthenticated,
        user: user ?? this.user
    );
  }

  factory AuthState.initial(){
    return new AuthState(
        isLoading: false,
        isAuthenticated: false,
        user: null
    );
  }
}
