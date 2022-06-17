import 'package:cashbook/authentication/core/failures/auth_failures.dart';
import 'package:dartz/dartz.dart';
import '../models/user.dart';

abstract class IAuthenticationRepository {
  
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({required String email, required String password});

  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({required String email, required String password});
  
  Future<void> signOut();

  Option<CustomUser> getSignedInUser();
  
  Future<Either<AuthFailure, Unit>> sendEmailVerification();

  Future<bool> checkEmailVerified();
}
