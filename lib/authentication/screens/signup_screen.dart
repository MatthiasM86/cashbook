import 'package:cashbook/authentication/repositories/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class SignUpScreen extends StatelessWidget {
  final _signUpFormKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      */
      body: SafeArea(
        child: FormBuilder(
          key: _signUpFormKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                FormBuilderTextField(
                  keyboardType: TextInputType.emailAddress,
                  name: 'email',
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                FormBuilderTextField(
                  keyboardType: TextInputType.text,
                  name: 'password',
                  decoration: const InputDecoration(labelText: 'Passwort'),
                  obscureText: true,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _signUpFormKey.currentState?.reset();
                        Navigator.pop(context);
                      },
                      child: const Text('Abbrechen'),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _signUpFormKey.currentState?.save();
                        final email =
                            _signUpFormKey.currentState?.value['email'];
                        final password =
                            _signUpFormKey.currentState?.value['password'];

                        FocusScope.of(context).unfocus();
                        context
                            .read<AuthenticationRepository>()
                            .signUp(email.trim(), password);
                        Navigator.pop(context);
                      },
                      child: const Text('Registrieren'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
