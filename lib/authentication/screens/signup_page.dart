import 'package:flutter/material.dart';
import 'package:cashbook/authentication/widgets/signup_form.dart';
import 'package:cashbook/injection.dart';
import 'package:cashbook/bloc/singinup/signinupform_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => sl<SigninupformBloc>(),
        child: SafeArea(
          child: SignUpForm(),
        ),
      ),
    );
  }
}
