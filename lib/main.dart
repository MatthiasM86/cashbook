import 'package:cashbook/authentication/repositories/authentication_repository.dart';
import 'package:cashbook/authentication/screens/email_verification_screen.dart';
import 'package:cashbook/authentication/screens/signin_screen.dart';
import 'package:cashbook/injection.dart' as di;
import 'package:cashbook/repositories/cashbook_repsoitory.dart';
import 'package:cashbook/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  /*
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  */
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Cashbook',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SignInScreen(),
      );
  }
}

/*
class AuthenticationWrapper extends StatelessWidget {
  //const AuthenticationWrapper({Key key,}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    final isEmailVerified = context.watch<bool>();
    if (firebaseUser != null) {
      if (isEmailVerified || firebaseUser.emailVerified) {
        return HomeScreen();
      } else {
        return EmailVerificationScreen();
      }
    }
    return SignInScreen();
  }
}
*/
