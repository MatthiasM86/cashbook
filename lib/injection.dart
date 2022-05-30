

import 'package:cashbook/authentication/repositories/authentication_repository.dart';
import 'package:cashbook/bloc/authentication/authentication_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.I; // sl == service locator / injection container

Future<void> init() async {

  sl.registerFactory(() => AuthenticationBloc());

}