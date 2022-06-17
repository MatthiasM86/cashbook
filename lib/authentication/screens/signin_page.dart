import 'package:cashbook/bloc/singinup/signinupform_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cashbook/injection.dart';
import 'package:cashbook/authentication/widgets/signin_form.dart';


class SignInPage extends StatelessWidget {
  const SignInPage({ Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => sl<SigninupformBloc>(),
        child: SafeArea(
          child: SignInForm(),
        ),
      ),
    );
  }
}


