part of 'authentication_bloc.dart';

/*
@immutable
abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}
*/

class AuthenticationState {
  final bool isSubmitting;
  final bool showValidationMessages;

  AuthenticationState({required this.isSubmitting, required this.showValidationMessages});
}

