import 'package:cashbook/bloc/authentication/authentication_bloc.dart';
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
        // TODO: navigate to another page (homepage) if auth was success
        // TODO: show error message if not
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
                validator: validatePassword,
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
                      /*
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()),
                        );
                        */
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
