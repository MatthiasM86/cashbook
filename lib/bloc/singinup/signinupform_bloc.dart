import 'package:bloc/bloc.dart';
import 'package:cashbook/authentication/repositories/authentication_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../authentication/core/failures/auth_failures.dart';

part 'signinupform_event.dart';
part 'signinupform_state.dart';

class SigninupformBloc extends Bloc<SigninupformEvent, SigninupformState> {
  final AuthenticationRepository authenticationRepository;

  SigninupformBloc({required this.authenticationRepository})
      : super(SigninupformState(
            isSubmitting: false,
            showValidationMessages: false,
            isEmailVerified: false,
            authFailureOrSuccessOption: none())) {
    on<RegisterWithEmailAndPasswordPressed>((event, emit) async {
      if (event.email == null || event.password == null) {
        emit(state.copyWith(isSubmitting: false, showValidationMessages: true));
      } else {
        emit(state.copyWith(isSubmitting: true, showValidationMessages: false));
        final failureOrSuccess =
            await authenticationRepository.registerWithEmailAndPassword(
                email: event.email!, password: event.password!);

        emit(state.copyWith(
            isSubmitting: false,
            isEmailVerified: false,
            authFailureOrSuccessOption: optionOf(failureOrSuccess)));
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

        if (failureOrSuccess.isRight()) {
          final userOption = authenticationRepository.getSignedInUser();
          userOption.fold(
            () => {},
            (user) => {
              if (user.isEmailVerified)
                {
                  emit(state.copyWith(
                      isSubmitting: false,
                      isEmailVerified: true,
                      authFailureOrSuccessOption: optionOf(failureOrSuccess)))
                }
            },
          );
        }

        emit(state.copyWith(
            isSubmitting: false,
            authFailureOrSuccessOption: optionOf(failureOrSuccess)));
      }
    });

    on<SigninformNoAccountEventPressed>((event, emit) {
      emit(SigninfomrNoAccountState());
    });

    void test() {}
  }
}
