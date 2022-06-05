import 'package:auto_route/auto_route.dart';
import 'package:cashbook/authentication/core/auth_failures.dart';
import 'package:cashbook/authentication/screens/signup_screen.dart';
import 'package:cashbook/bloc/authentication/authentication_bloc.dart';
import 'package:cashbook/routes/router.gr.dart';
import 'package:cashbook/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:form_builder_validators/form_builder_validators.dart';
//import 'package:flutter_form_builder/flutter_form_builder.dart';

class SignInForm extends StatelessWidget {
  //const SignInForm({Key? key}) : super(key: key);

  late String _email;
  late String _password;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    String? validateEmail(String? input) {
      const emailRegex =
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
      if (input == null || input.isEmpty) {
        return "please enter email";
      } else if (RegExp(emailRegex).hasMatch(input)) {
        _email = input;
        return null;
      } else {
        print("invalid email format");
        return "invalid email format";
      }
    }

    String? validatePassword(String? input) {
      if (input == null || input.isEmpty) {
        return "please enter password";
      } else if (input.length >= 6) {
        _password = input;
        return null;
      } else {
        return "short password";
      }
    }

    String mapFailureMessage(AuthFailure failure) {
      switch (failure.runtimeType) {
        case ServerFailure:
          return "something went wrong";
        case InvalidEmailAndPasswordCombinationFailure:
          return "email or password wrong";
        default:
          return "something went wrong";
      }
    }

    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        state.authFailureOrSuccessOption!.fold(
            () => {},
            (eitherFailureOrSuccess) => eitherFailureOrSuccess.fold((failure) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.redAccent,
                      content: Text(
                        mapFailureMessage(failure),
                      )));
                }, (_) => {
                  AutoRouter.of(context).push(const HomeScreenRoute())
                }));
      },
      builder: (context, state) {
        return Form(
          autovalidateMode: state.showValidationMessages
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          key: formKey,
          child: ListView(
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                validator: validateEmail,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Passwort',
                ),
                obscureText: true,
                validator: validatePassword,
              ),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    BlocProvider.of<AuthenticationBloc>(context).add(
                        SignInWithEmailAndPasswordPressed(
                            email: _email, password: _password));
                  } else {
                    BlocProvider.of<AuthenticationBloc>(context).add(
                        SignInWithEmailAndPasswordPressed(
                            email: null, password: null));
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Colors.redAccent,
                        content: Text("invalid input")));
                  }
                },
                child: const Text("Einloggen"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Noch nicht registriert?"),
                  TextButton(
                    onPressed: () {
                      //Todo Navigation to Registration Screen
                    },
                    child: const Text('Registrieren'),
                  )
                ],
              ),
              if (state.isSubmitting) ...[
                const SizedBox(
                  height: 10,
                ),
                const LinearProgressIndicator(
                  color: Colors.blue,
                )
              ]
            ],
          ),
        );
      },
    );
  }
}
