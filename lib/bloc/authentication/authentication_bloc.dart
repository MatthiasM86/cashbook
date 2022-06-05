import 'package:bloc/bloc.dart';
import 'package:cashbook/authentication/repositories/authentication_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../authentication/core/auth_failures.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository authenticationRepository;

  AuthenticationBloc({required this.authenticationRepository})
      : super(AuthenticationState(
            isSubmitting: false,
            showValidationMessages: false,
            authFailureOrSuccessOption: none())) {

    on<RegisterWithEmailAndPasswordPressed>((event, emit) async {
      if (event.email == null || event.password == null) {
        emit(state.copyWith(isSubmitting: false, showValidationMessages: true));
      } else {
        emit(state.copyWith(isSubmitting: true, showValidationMessages: false));
        final failureOrSuccess =
            await authenticationRepository.registerWithEmailAndPassword(
                email: event.email!, password: event.password!);

        emit(state.copyWith(isSubmitting: false, authFailureOrSuccessOption: optionOf(failureOrSuccess)));
      }
    });

    on<SignInWithEmailAndPasswordPressed>((event, emit) async {
      if (event.email == null || event.password == null) {
        emit(state.copyWith(isSubmitting: false, showValidationMessages: true));
      } else {
        emit(state.copyWith(isSubmitting: true, showValidationMessages: false));
        final failureOrSuccess =
            await authenticationRepository.signInWithEmailAndPassword(
                email: event.email!, password: event.password!);

        emit(state.copyWith(isSubmitting: false, authFailureOrSuccessOption: optionOf(failureOrSuccess)));
      }
    });
  }
}
