import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

//https://www.youtube.com/watch?v=eGwq3_0K_Sg
class HomeScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Kassenbuch'),
      ),
      body: FormBuilder(
        key: _formKey,
        child: Column(
          children: [
            FormBuilderTextField(
              keyboardType: TextInputType.number,
              name: 'textField',
            ),
            FormBuilderSwitch(
              name: 'entryType',
              title: Text('Ausgabe'),
            ),
            FormBuilderChoiceChip(
              name: 'entryType_chip',
              decoration: const InputDecoration(
                labelText: 'Select an option',
              ),
              options: const [
                FormBuilderFieldOption(value: 'Einnahme', child: Text('Einnahme')),
                FormBuilderFieldOption(value: 'Ausgabe', child: Text('Ausgabe')),
              ],
            ),
            FormBuilderFilterChip(
              name: 'choice_chip',
              decoration: const InputDecoration(
                labelText: 'Buchungstext',
              ),
              options: const [
                FormBuilderFieldOption(value: 'Test', child: Text('schneiden')),
                FormBuilderFieldOption(value: 'Test 1', child: Text('föhnen')),
                FormBuilderFieldOption(value: 'Test 2', child: Text('waschen')),
                FormBuilderFieldOption(value: 'Test 3', child: Text('färben')),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                final textFieldData =
                    _formKey.currentState?.fields['textField']?.value;
                _formKey.currentState?.reset();
                FocusScope.of(context).unfocus();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: const Duration(seconds: 1),
                    content: Text(
                      '$textFieldData',
                      textScaleFactor: 1.5,
                    ),
                  ),
                );
              },
              child: const Text('Submit'),
            )
          ],
        ),
        onChanged: () => print('Form has changed'),
      ),
    );
  }
}
