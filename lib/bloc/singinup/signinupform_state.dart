part of 'signinupform_bloc.dart';

class SigninupformState {
  final bool isSubmitting;
  final bool showValidationMessages;
  final bool isEmailVerified;
  final Option<Either<AuthFailure, Unit>>? authFailureOrSuccessOption;

  SigninupformState(
      {required this.isSubmitting, required this.showValidationMessages, required this.isEmailVerified, required this.authFailureOrSuccessOption});

  SigninupformState copyWith({
    bool? isSubmitting,
    bool? showValidationMessages,
    bool? isEmailVerified,
    Option<Either<AuthFailure, Unit>>? authFailureOrSuccessOption,
  }) {
    return SigninupformState(
        isSubmitting: isSubmitting ?? this.isSubmitting,
        showValidationMessages: showValidationMessages ?? this.showValidationMessages,
        isEmailVerified: isEmailVerified ?? this.isEmailVerified,
        authFailureOrSuccessOption: authFailureOrSuccessOption ?? this.authFailureOrSuccessOption
        
      );
  }
}

class SigninfomrNoAccountState extends SigninupformState {
  SigninfomrNoAccountState() : super(isSubmitting: false, showValidationMessages: false, isEmailVerified: false, authFailureOrSuccessOption: null);
}


