part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class SignUpWithEmailAndPasswordPressed extends AuthenticationEvent {
  final String? email;
  final String? password;
  SignUpWithEmailAndPasswordPressed({required this.email, required this.password});
}

class SignInWithEmailAndPasswordPressed extends AuthenticationEvent {
  final String? email;
  final String? password;
  SignInWithEmailAndPasswordPressed({required this.email, required this.password});
}
