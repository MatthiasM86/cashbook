
import 'package:cashbook/authentication/models/id.dart';

class CustomUser {
  final UniqueID id;
  final bool isEmailVerified;
  CustomUser({required this.id, required this.isEmailVerified});
}