import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../repositories/authentication_repository.dart';

//https://dribbble.com/shots/6101536-Verify-Your-Email

class EmailVerificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Account noch nicht aktiviert'),
            Text(
                'Dein Account ist noch nicht aktiviert, bitte klicke auf den Link in der Bestätigungs Email. Falls Du keine Email bekommen hast, kannst Du sie mit dem klick auf den Button unten neu senden.'),
            ElevatedButton(
              onPressed: () {
                context
                    .read<AuthenticationRepository>()
                    .sendEmailVerification();
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