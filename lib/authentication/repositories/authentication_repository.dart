import 'package:cashbook/authentication/repositories/iauthentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationRepository implements IAuthenticationRepository {
  final FirebaseAuth _firebaseAuth;

  AuthenticationRepository(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

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
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
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
//https://firebase.blog/posts/2017/02/email-verification-in-firebase-auth
  Future<void> sendEmailVerification() async {
    authStateChanges.listen((user) { 
      if(user != null){
        user.sendEmailVerification();
      }
    });

  }
}
