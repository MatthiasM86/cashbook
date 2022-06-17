

import 'package:cashbook/authentication/models/id.dart';
import 'package:cashbook/authentication/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

extension FirebaseUserMapper on User{
  CustomUser toDomain(){
    return CustomUser(id: UniqueID.fromUniqueString(uid), isEmailVerified: emailVerified);
  }
}