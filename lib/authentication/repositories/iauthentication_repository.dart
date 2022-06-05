import 'package:cashbook/authentication/core/auth_failures.dart';
import 'package:dartz/dartz.dart';

abstract class IAuthenticationRepository {
  
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({required String email, required String password});

  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({required String email, required String password});
  /*
  Future<void> signOut();
  Future<void> sendEmailVerification();
  User? getCurrentUser();
  void startEmailVerificationTimer();
  void stopEmailVerificationTimer();
  */
}
