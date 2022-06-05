import 'package:auto_route/annotations.dart';
import 'package:cashbook/authentication/screens/signup_screen.dart';
import 'package:cashbook/authentication/screens/signin_screen.dart';
import 'package:cashbook/screens/home_screen.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(page: SignInScreen, initial:  true),
    AutoRoute(page: HomeScreen, initial: false)
  ]
)

class $AppRouter{}