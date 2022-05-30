import 'package:cashbook/models/cashbook_entry.dart';
import 'package:cashbook/repositories/cashbook_repsoitory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:cashbook/authentication/repositories/authentication_repository.dart';
import 'package:provider/provider.dart';

//https://www.youtube.com/watch?v=eGwq3_0K_Sg
class HomeScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Neuer Eintrag'),
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
                        final userId = context.read<AuthenticationRepository>().getCurrentUser()!.uid;
                        final cashbookEntry = prepareFormDataForSave(userId, formData!);
                        
                        
                         context
                        .read<CashbookRepository>()
                        .addCashbookEntry(cashbookEntry);
                        
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Kassenbuch',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              title: const Text('Ausloggen'),
              onTap: () {
                context.read<AuthenticationRepository>().signOut();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  CashbookEntry prepareFormDataForSave(String userId, Map<String, dynamic> formData){

    final test = {
      ...formData,
      'userId': userId
    };
    final cashbookEntry = CashbookEntry.fromMap(test);
    if(cashbookEntry.bookingText.isNotEmpty){
      cashbookEntry.bookingTexts.add(cashbookEntry.bookingText);
    }
    return cashbookEntry;
  }
}
