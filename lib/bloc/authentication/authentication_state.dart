part of 'authentication_bloc.dart';

class AuthenticationState {
  final bool isSubmitting;
  final bool showValidationMessages;
  final Option<Either<AuthFailure, Unit>>? authFailureOrSuccessOption;

  AuthenticationState(
      {required this.isSubmitting, required this.showValidationMessages, required this.authFailureOrSuccessOption});

  AuthenticationState copyWith({
    bool? isSubmitting,
    bool? showValidationMessages,
    Option<Either<AuthFailure, Unit>>? authFailureOrSuccessOption,
  }) {
    return AuthenticationState(
        isSubmitting: isSubmitting ?? this.isSubmitting,
        authFailureOrSuccessOption: authFailureOrSuccessOption ?? this.authFailureOrSuccessOption,
        showValidationMessages: showValidationMessages ?? this.showValidationMessages
      );
  }
}
