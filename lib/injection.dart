import 'package:cashbook/application/cashbook/observer/observer_bloc.dart';
import 'package:cashbook/authentication/repositories/authentication_repository.dart';
import 'package:cashbook/authentication/repositories/iauthentication_repository.dart';
import 'package:cashbook/bloc/auth/auth_bloc.dart';
import 'package:cashbook/bloc/singinup/signinupform_bloc.dart';
import 'package:cashbook/repositories/cashbook_repository.dart';
import 'package:cashbook/repositories/cashbook_repsoitory_impl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.I; // sl == service locator / injection container

Future<void> init() async {
  //? ################## auth ######################
  //! state management
  sl.registerFactory(() => SigninupformBloc(authenticationRepository: sl()));
  sl.registerFactory(() => AuthBloc(authenticationRepository: sl()));

  //! repos
  sl.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepository(firebaseAuth: sl()));

  //! extern
  final firebaseAuth = FirebaseAuth.instance;
  sl.registerLazySingleton(() => firebaseAuth);

  //? ################## cashbook ##################
  //! state management
  sl.registerFactory(() => ObserverBloc(cashbookRepository: sl()));
  //! repos
  sl.registerLazySingleton<CashbookRepository>(
      () => CashbookRepositoryImpl(firestore: sl()));

  //! extern
  final firestore = FirebaseFirestore.instance;
  sl.registerLazySingleton(() => firestore);
}
