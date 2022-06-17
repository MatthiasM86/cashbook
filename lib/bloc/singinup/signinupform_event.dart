part of 'signinupform_bloc.dart';

@immutable
abstract class SigninupformEvent {}

class RegisterWithEmailAndPasswordPressed extends SigninupformEvent {
  final String? email;
  final String? password;
  RegisterWithEmailAndPasswordPressed({required this.email, required this.password});
}

class SignInWithEmailAndPasswordPressed extends SigninupformEvent {
  final String? email;
  final String? password;
  SignInWithEmailAndPasswordPressed({required this.email, required this.password});
}

class SigninformNoAccountEventPressed extends SigninupformEvent {}
 



