import 'dart:async';

import 'package:cashbook/authentication/core/auth_failures.dart';
import 'package:cashbook/authentication/repositories/iauthentication_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationRepository implements IAuthenticationRepository {
  final FirebaseAuth _firebaseAuth;
  final _controller = StreamController<bool>();
  late Timer _timer;

  AuthenticationRepository(this._firebaseAuth);


  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
  Stream<bool> get isEmailVerified => _controller.stream;

  @override
  Future<Either<AuthFailure, Unit>> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
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
  Future<Either<AuthFailure, Unit>> signUp(String email, String password) async {
    try {
      await _firebaseAuth
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
  Future<void> sendEmailVerification() async {
    authStateChanges.listen((user) {
      if (user != null) {
        user.sendEmailVerification();
      }
    });
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  void startEmailVerificationTimer() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      final emailVerified = await forceReloadUser();
      if (emailVerified) {
        _controller.sink.add(true);
        stopEmailVerificationTimer();
      } else {
        _controller.sink.add(false);
      }
    });
  }

  @override
  void stopEmailVerificationTimer() {
    _timer.cancel();
  }
  @override
  User? getCurrentUser(){
    return _firebaseAuth.currentUser;
  }

  //private methods
  Future<bool> forceReloadUser() async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      await _firebaseAuth.currentUser!.reload();
      final userReloaded = await _firebaseAuth.currentUser;
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
