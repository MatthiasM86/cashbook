import 'package:flutter/material.dart';
import 'package:cashbook/authentication/widgets/signup_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({ Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SignUpForm(),
      ),
    );
  }
}
