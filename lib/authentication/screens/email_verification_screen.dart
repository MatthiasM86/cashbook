import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../repositories/authentication_repository.dart';

//https://dribbble.com/shots/6101536-Verify-Your-Email

class EmailVerificationScreen extends StatefulWidget {
  //   with WidgetsBindingObserver {
  @override
  _EmailVerificationScreenState createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  bool reloadUser = false;

  @override
  void initState() {
    super.initState();
    //context.read<AuthenticationRepository>().startEmailVerificationTimer();
  }

/*
  @override
  void dispose(){
    context.read<AuthenticationRepository>().stopEmailVerificationTimer();
    super.dispose();
  }
*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Account noch nicht aktiviert'),
            const Text(
                'Dein Account ist noch nicht aktiviert, bitte klicke auf den Link in der Aktivierungsmail. Falls Du keine Email bekommen hast, kannst Du sie mit dem klick auf den Button unten erneut senden.'),
            ElevatedButton(
              onPressed: () {

              },
              child: Text('Aktivierungsmail erneut senden'),
            ),
          ],
        ),
      ),
    );
  }
}

// Willkommen bei YourApp 
// Wir freuen uns, dass Du unsere App heruntergeladen hast.
// Um deinen Account zu aktivieren, klicke bitte auf den folgenden Link:
// Link
// Nach Deiner Bestätigung ist die Registrierung abgeschlossen und Dein Account freigeschaltet.
// Wir freuen uns auf Dich!
// Dein YourAPP Team