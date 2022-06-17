part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthStateAuthenticated extends AuthState {}

class AuthStateUnauthenticated extends AuthState {}

class AuthStateEmailNotVerified extends AuthState {}

class AuthStateEmailVerified extends AuthState {}