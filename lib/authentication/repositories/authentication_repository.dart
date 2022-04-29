import 'dart:async';

import 'package:cashbook/authentication/repositories/iauthentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationRepository implements IAuthenticationRepository {
  final FirebaseAuth _firebaseAuth;
  final _controller = StreamController<bool>();
  late Timer _timer;

  AuthenticationRepository(this._firebaseAuth);


  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
  Stream<bool> get isEmailVerified => _controller.stream;

  @override
  Future<String> signIn(String email, String password) async {
    // Todo: change to constants
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "signed in";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return "error signing in";
    }
  }

  @override
  Future<String> signUp(String email, String password) async {
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .whenComplete(() async => {await sendEmailVerification()});
      return "signed up";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return "error sign up";
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
    var counter = 0;
    print('start timer');
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      counter = counter + 1;
      print('loop ${counter}');
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
    print('stop timer');
    _timer.cancel();
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
