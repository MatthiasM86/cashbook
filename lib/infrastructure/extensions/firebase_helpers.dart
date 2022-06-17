import 'package:cashbook/authentication/repositories/authentication_repository.dart';
import 'package:cashbook/authentication/core/errors/errors.dart';
import 'package:cashbook/injection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

extension FirestorExt on FirebaseFirestore {
  Future<DocumentReference> userDocument() async {
    final userOption = sl<AuthenticationRepository>().getSignedInUser();
    final user = userOption.getOrElse(() => throw NotAuthenticatedError());

    return FirebaseFirestore.instance.collection("users").doc(user.id.value);
  }
}
 
 extension DocumentReferenceExt on DocumentReference {
  CollectionReference<Map<String, dynamic>>get cashbookItemCollection => collection("cashbook");
 }
