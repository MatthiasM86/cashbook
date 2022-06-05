import 'package:cashbook/authentication/core/auth_failures.dart';
import 'package:cashbook/bloc/authentication/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpForm extends StatelessWidget {
  late String _email;
  late String _password;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    String? validateEmail(String? input) {
      const emailRegex =
          r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~+@[a-zA-Z0-9]+\.[a-zA-Z]]+""";
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

    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        // TODO: implement listener
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
                          BlocProvider.of<AuthenticationBloc>(context).add(
                              RegisterWithEmailAndPasswordPressed(
                                  email: _email, password: _password));
                        } else {
                          BlocProvider.of<AuthenticationBloc>(context).add(
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
