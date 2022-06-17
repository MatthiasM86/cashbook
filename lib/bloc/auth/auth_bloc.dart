import 'package:bloc/bloc.dart';
import 'package:cashbook/authentication/repositories/authentication_repository.dart';
import 'package:meta/meta.dart';
import 'dart:async';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthenticationRepository authenticationRepository;

  AuthBloc({required this.authenticationRepository}) : super(AuthInitial()) {
    on<SignOutPressedEvent>((event, emit) async {
      await authenticationRepository.signOut();
      emit(AuthStateUnauthenticated());
    });

    on<AuthCheckRequestedEvent>((event, emit) async {
      final userOption = authenticationRepository.getSignedInUser();
      userOption.fold(
          () => emit(AuthStateUnauthenticated()),
          (user) => {
                if (user.isEmailVerified)
                  {
                    emit(AuthStateAuthenticated()),
                  }
                else
                  {
                    emit(AuthStateEmailNotVerified()),
                  }
              });
    });

    on<SendVerificationEmailAgainPressedEvent>((event, emit) async {
      await authenticationRepository.sendEmailVerification();
    });

    on<StartCheckEmailVerifiedEvent>((event, emit) async {
      Timer.periodic(const Duration(seconds: 5), (timer) async {
        final emailVerified = await authenticationRepository.checkEmailVerified();
            
        if (emailVerified) {
          add(AuthCheckRequestedEvent());
          timer.cancel();
        }
      });
    });
  }
}
