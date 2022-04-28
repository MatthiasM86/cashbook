import 'package:cashbook/authentication/repositories/authentication_repository.dart';
import 'package:cashbook/authentication/screens/email_verification_screen.dart';
import 'package:cashbook/authentication/screens/signin_screen.dart';
import 'package:cashbook/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationRepository>(
          create: (_) => AuthenticationRepository(FirebaseAuth.instance),
        ),
        StreamProvider(
            create: (context) =>
                context.read<AuthenticationRepository>().authStateChanges,
            initialData: null),
      ],
      child: MaterialApp(
        title: 'Cashbook',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AuthenticationWrapper(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  //const AuthenticationWrapper({Key key,}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    if (firebaseUser != null) {
      if (firebaseUser.emailVerified) {
        return HomeScreen();
      } else {
        return EmailVerificationScreen();
      }
    }
    return SignInScreen();
  }
}
