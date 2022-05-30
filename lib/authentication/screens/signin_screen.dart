import 'package:cashbook/bloc/authentication/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:cashbook/injection.dart';
import 'package:cashbook/authentication/widgets/signin_form.dart';


class SignInScreen extends StatelessWidget {
  const SignInScreen({ Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => sl<AuthenticationBloc>(),
        child: SafeArea(
          child: SignInForm(),
        ),
      ),
    );
  }
}


