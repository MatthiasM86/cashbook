import 'package:cashbook/authentication/repositories/authentication_repository.dart';
import 'package:cashbook/authentication/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<AuthenticationRepository>().signIn(
                    emailController.text.trim(), passwordController.text);
              },
              child: Text("Sign in"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?"),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()),
                    );
                    print('rout to sign up');
                  },
                  child: Text('Register'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
