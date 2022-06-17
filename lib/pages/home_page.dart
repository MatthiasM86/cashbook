import 'package:auto_route/auto_route.dart';
import 'package:cashbook/application/cashbook/observer/observer_bloc.dart';
import 'package:cashbook/bloc/auth/auth_bloc.dart';
import 'package:cashbook/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:cashbook/widgets/cashbook_item_form.dart';
import '../injection.dart';

class HomePage extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final observerBloc = sl<ObserverBloc>()..add(ObserveAllEvent());
    return MultiBlocProvider(
      providers: [
        BlocProvider<ObserverBloc>(
          create: ((context) => observerBloc),
        )
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(listener: (context, state) {
            if (state is AuthStateUnauthenticated) {
              AutoRouter.of(context).push(const SignInPageRoute());
            }
          })
        ],
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Neuer Eintrag'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: CashbookItemForm(formKey: _formKey),
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
                  title: const Text('Kassenbuch Einträge'),
                  onTap: () {},
                ),
                const Divider(),
                ListTile(
                  title: const Text('Ausloggen'),
                  onTap: () {
                    BlocProvider.of<AuthBloc>(context)
                        .add(SignOutPressedEvent());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /*
  CashbookItem prepareFormDataForSave(
      String userId, Map<String, dynamic> formData) {
    final cashbookEntry = CashbookItem.fromMap(formData);
    if (cashbookEntry.bookingText.isNotEmpty) {
      cashbookEntry.bookingTexts.add(cashbookEntry.bookingText);
    }
    return cashbookEntry;
  }
  */
}
