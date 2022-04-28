import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthenticationRepository {
  //Stream<User?> authStateChanges();
  Future<String> signIn(String email, String password);
  Future<String> signUp(String email, String password);
  Future<void> signOut();
  Future<void> sendEmailVerification();
  void startEmailVerificationTimer();
  void stopEmailVerificationTimer();
}
