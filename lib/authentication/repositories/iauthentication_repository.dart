import 'package:cashbook/authentication/core/auth_failures.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthenticationRepository {
  Future<Either<AuthFailure, Unit>> signIn(String email, String password);
  Future<Either<AuthFailure, Unit>> signUp(String email, String password);
  Future<void> signOut();
  Future<void> sendEmailVerification();
  User? getCurrentUser();
  void startEmailVerificationTimer();
  void stopEmailVerificationTimer();
}
