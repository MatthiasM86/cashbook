import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc()
      : super(AuthenticationState(
            isSubmitting: false, showValidationMessages: false)) {
    on<SignUpWithEmailAndPasswordPressed>((event, emit) {
      if (event.email == null || event.password == null) {
        emit(AuthenticationState(
            isSubmitting: false, showValidationMessages: true));
      } else {
        emit(AuthenticationState(
            isSubmitting: true, showValidationMessages: false));
        // todo Trigger registration
        // emit(AuthenticationState(isSubmitting: false, showValidationMessages: true));
      }
    });

    on<SignInWithEmailAndPasswordPressed>((event, emit) {
      if (event.email == null || event.password == null) {
        emit(AuthenticationState(
            isSubmitting: false, showValidationMessages: true));
      } else {
        emit(AuthenticationState(
            isSubmitting: true, showValidationMessages: false));
        // todo Trigger authentication
        // emit(AuthenticationState(isSubmitting: false, showValidationMessages: true));
      }
    });
  }
}
