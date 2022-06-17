import 'package:auto_route/auto_route.dart';
import 'package:cashbook/bloc/auth/auth_bloc.dart';
import 'package:cashbook/models/cashbook_item.dart';
import 'package:cashbook/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CashbookItemForm extends StatelessWidget {
  const CashbookItemForm({
    Key? key,
    required GlobalKey<FormBuilderState> formKey,
  }) : _formKey = formKey, super(key: key);

  final GlobalKey<FormBuilderState> _formKey;

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FormBuilderTextField(
              keyboardType: TextInputType.number,
              name: 'amount',
              decoration: const InputDecoration(
                labelText: 'Betrag',
              ),
            ),
            FormBuilderSwitch(
              initialValue: true,
              name: 'taking',
              title: const Text('Einnahme'),
            ),
            FormBuilderFilterChip(
              name: 'bookingTexts',
              decoration: const InputDecoration(
                labelText: 'Buchungstext Schnellauswahl',
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
              decoration: const InputDecoration(
                labelText: 'Buchungstext',
              ),
            ),
            FormBuilderTextField(
              keyboardType: TextInputType.number,
              name: 'taxRate',
              decoration: const InputDecoration(
                labelText: 'Steuersatz',
              ),
            ),
            FormBuilderTextField(
              keyboardType: TextInputType.text,
              name: 'documentNumber',
              decoration: const InputDecoration(
                labelText: 'Belegnummer',
              ),
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
                const SizedBox(
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
    );
  }
}