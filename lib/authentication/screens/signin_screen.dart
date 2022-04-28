import 'package:cashbook/authentication/repositories/authentication_repository.dart';
import 'package:cashbook/authentication/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';


class SignInScreen extends StatelessWidget {
  final _loginFormKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FormBuilder(
          key: _loginFormKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                FormBuilderTextField(
                  keyboardType: TextInputType.emailAddress,
                  name: 'email',
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: FormBuilderValidators.email()
                ),
                FormBuilderTextField(
                  keyboardType: TextInputType.text,
                  name: 'password',
                  decoration: const InputDecoration(labelText: 'Passwort'),
                  obscureText: true,
                ),
                ElevatedButton(
                  onPressed: () {
                    _loginFormKey.currentState?.save();
                    final email = _loginFormKey.currentState?.value['email'];
                    final password = _loginFormKey.currentState?.value['password'];
                    FocusScope.of(context).unfocus();
                    
                    context.read<AuthenticationRepository>().signIn(
                        email.trim(), password);
                    
                  },
                  child: const Text("Einloggen"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Noch nicht registriert?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()),
                        );
                      },
                      child: const Text('Registrieren'),
                    )
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
