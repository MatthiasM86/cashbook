import 'package:cashbook/bloc/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cashbook/routes/router.gr.dart';
import 'package:auto_route/auto_route.dart';

class EmailVerificationPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AuthBloc>(context).add(StartCheckEmailVerifiedEvent());
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if(state is AuthStateAuthenticated){
          context.router.replace(const HomePageRoute());
        }
      },
      builder: (context, state) {
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
                    BlocProvider.of<AuthBloc>(context).add(SendVerificationEmailAgainPressedEvent());
                  },
                  child: const Text('Aktivierungsmail erneut senden'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
