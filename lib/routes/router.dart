import 'package:auto_route/annotations.dart';
import 'package:cashbook/authentication/screens/email_verification_screen.dart';
import 'package:cashbook/authentication/screens/signup_page.dart';
import 'package:cashbook/authentication/screens/signin_page.dart';
import 'package:cashbook/pages/home_page.dart';
import 'package:cashbook/pages/splash_page.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(page: SplashPage, initial:  true),
    AutoRoute(page: SignInPage, initial:  false),
    AutoRoute(page: SignUpPage, initial: false),
    AutoRoute(page: EmailVerificationPage, initial: false),
    AutoRoute(page: HomePage, initial: false)
  ]
)

class $AppRouter{}