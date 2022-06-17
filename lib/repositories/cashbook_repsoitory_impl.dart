import 'package:cashbook/failures/cashbook_failures.dart';
import 'package:cashbook/models/cashbook_item.dart';
import 'package:cashbook/models/cashbook_item_model.dart';
import 'package:cashbook/repositories/cashbook_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:cashbook/infrastructure/extensions/firebase_helpers.dart';

class CashbookRepositoryImpl implements CashbookRepository {
  final FirebaseFirestore firestore;

  CashbookRepositoryImpl({required this.firestore});

  @override
  Stream<Either<CashbookFailure, List<CashbookItem>>> watchAll() async* {
    final userDoc = await firestore.userDocument();
    // right side listen on cashbook items
    yield* userDoc.cashbookItemCollection
        .snapshots()
        .map((snapshot) => right<CashbookFailure, List<CashbookItem>>(snapshot
            .docs
            .map((doc) => CashbookItemModel.fromFirestore(doc).toDomain())
            .toList()))
        // error handling (left side)
        .handleError((e) {
      if (e is FirebaseException) {
        if (e.code.contains('permission-denied') ||
            e.code.contains("PERMISSION_DENIED")) {
          return left(InsufficientPermissions());
        } else {
          return left(UnexpectedFailure());
        }
      } else {
        print(e.message);
        return left(UnexpectedFailure());
      }
    });
  }

  @override
  Future<Either<CashbookFailure, Unit>> create(CashbookItem cashbookItem) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<Either<CashbookFailure, Unit>> delete(CashbookItem cashbookItem) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Either<CashbookFailure, Unit>> update(CashbookItem cashbookItem) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Stream<Either<CashbookFailure, List<CashbookItem>>> watchCurrentMonth() {
    // TODO: implement watchAll
    throw UnimplementedError();
  }
}
