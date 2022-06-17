import 'dart:async';
import 'package:cashbook/authentication/core/failures/auth_failures.dart';
import 'package:cashbook/authentication/models/user.dart';
import 'package:cashbook/authentication/repositories/iauthentication_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cashbook/authentication/models/firebase_user_mapper.dart';

class AuthenticationRepository implements IAuthenticationRepository {
  final FirebaseAuth firebaseAuth;
  late Timer _timer;

  AuthenticationRepository({required this.firebaseAuth});

  @override
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return right(unit);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        return left(InvalidEmailAndPasswordCombinationFailure());
      } else {
        return left(ServerFailure());
      }
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .whenComplete(() async => {await sendEmailVerification()});
      return right(unit);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return left(WeakPasswordFailure());
      } else if (e.code == 'email-already-in-use') {
        return left(EmailAlreadyInUserFailure());
      } else {
        return left(ServerFailure());
      }
    }
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<Either<AuthFailure, Unit>> sendEmailVerification() async {
    final user = firebaseAuth.currentUser;
    if (user != null) {
      user.sendEmailVerification();
      print('sendagain');
      return right(unit);
    } else {
      return left(SendEmailVerificationNoSignedInUserFailure());
    }
  }

  @override
  Option<CustomUser> getSignedInUser() =>
      optionOf(firebaseAuth.currentUser?.toDomain());

  @override
  Future<bool> checkEmailVerified() async {
    final emailVerified = await forceReloadUser();
    if (emailVerified) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void stopEmailVerificationTimer() {
    _timer.cancel();
  }

  Future<bool> forceReloadUser() async {
    final user = firebaseAuth.currentUser;
    if (user != null) {
      await firebaseAuth.currentUser!.reload();
      final userReloaded = firebaseAuth.currentUser;
      if (userReloaded!.emailVerified) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
