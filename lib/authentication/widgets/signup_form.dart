import 'package:cashbook/bloc/singinup/signinupform_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cashbook/authentication/core/failures/auth_failures.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cashbook/routes/router.gr.dart';

class SignUpForm extends StatelessWidget {
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

    return BlocConsumer<SigninupformBloc, SigninupformState>(
      listener: (context, state) {
        state.authFailureOrSuccessOption!.fold(
            () => {},
            (eitherFailureOrSuccess) => eitherFailureOrSuccess.fold((failure) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.redAccent,
                      content: Text(
                        mapFailureMessage(failure),
                      )));
                },
                    (_) => {
                          if (state.isEmailVerified)
                            {
                              AutoRouter.of(context)
                                  .replace(const HomePageRoute())
                            }
                          else
                            {
                              AutoRouter.of(context)
                                  .replace(const EmailVerificationPageRoute())
                            }
                        }));
      },
      builder: (context, state) {
        return Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        formKey.currentState!.reset();
                        Navigator.pop(context);
                      },
                      child: const Text('Abbrechen'),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<SigninupformBloc>(context).add(
                              RegisterWithEmailAndPasswordPressed(
                                  email: _email, password: _password));
                        } else {
                          BlocProvider.of<SigninupformBloc>(context).add(
                              SignInWithEmailAndPasswordPressed(
                                  email: null, password: null));
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  backgroundColor: Colors.redAccent,
                                  content: Text("invalid input")));
                        }
                      },
                      child: const Text("Registrieren"),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
