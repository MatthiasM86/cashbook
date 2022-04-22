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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FormBuilder(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FormBuilderTextField(
                  keyboardType: TextInputType.number,
                  name: 'amount',
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0))),
                  ),
                ),
                FormBuilderSwitch(
                  initialValue: true,
                  name: 'taking',
                  title: Text('Einnahme'),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0))),
                  ),
                ),
                FormBuilderFilterChip(
                  name: 'bookingTextChip',
                  decoration: const InputDecoration(
                    labelText: 'Buchungstext',
                  ),
                  options: const [
                    FormBuilderFieldOption(
                      value: 'schneiden',
                      child: Text('schneiden'),
                    ),
                    FormBuilderFieldOption(
                      value: 'föhnen',
                      child: Text('föhnen'),
                    ),
                    FormBuilderFieldOption(
                        value: 'waschen', child: Text('waschen')),
                    FormBuilderFieldOption(
                      value: 'färben',
                      child: Text('färben'),
                    ),
                  ],
                ),
                FormBuilderTextField(
                  keyboardType: TextInputType.text,
                  name: 'bookingText',
                ),
                FormBuilderTextField(
                  keyboardType: TextInputType.number,
                  name: 'taxRate',
                ),
                FormBuilderTextField(
                  keyboardType: TextInputType.text,
                  name: 'documentNumber',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _formKey.currentState?.reset();
                      },
                      child: const Text('Abbrechen'),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _formKey.currentState?.save();
                        final formData = _formKey.currentState?.value;
                        FocusScope.of(context).unfocus();

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: const Duration(seconds: 3),
                            content: Text(
                              '$formData',
                              textScaleFactor: 1.0,
                            ),
                          ),
                        );
                      },
                      child: const Text('Speichern'),
                    )
                  ],
                )
              ],
            ),
          ),
          onChanged: () => print('Form has changed'),
        ),
      ),
    );
  }
}
