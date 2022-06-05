

import 'package:cashbook/authentication/repositories/authentication_repository.dart';
import 'package:cashbook/authentication/repositories/iauthentication_repository.dart';
import 'package:cashbook/bloc/authentication/authentication_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.I; // sl == service locator / injection container

Future<void> init() async {

  //! state management
  sl.registerFactory(() => AuthenticationBloc(authenticationRepository: sl()));

  //! repos
  sl.registerLazySingleton<AuthenticationRepository>(() => AuthenticationRepository(firebaseAuth: sl()));

  //! extern
  final firebaseAuth = FirebaseAuth.instance;
  sl.registerLazySingleton(() => firebaseAuth);

}