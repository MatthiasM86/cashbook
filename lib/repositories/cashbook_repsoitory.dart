import 'package:cashbook/authentication/repositories/authentication_repository.dart';
import 'package:cashbook/models/cashbook_entry.dart';
import 'package:cashbook/models/cashbook_month.dart';
import 'package:cashbook/repositories/icashbook_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

class CashbookRepository implements ICashbookRepository {
  final FirebaseFirestore firebaseFirestore;

  CollectionReference? _cashbookMonth;
  CollectionReference? _cashbookEntries;

  CashbookRepository({ required this.firebaseFirestore}) {
    _cashbookEntries = firebaseFirestore.collection('cashbook_entries');
    _cashbookMonth = firebaseFirestore.collection('cashbook_month');
  }

  @override
  Future<void> addCashbookEntry(CashbookEntry cashbookEntry) {
    return _cashbookEntries!
        .add(cashbookEntry.toMap())
        .then((value) => print("entry added"))
        .catchError((error) => print("failed to add entry: $error"));
  }

  Future<void> addCashbookMonth(CashbookEntry cashbookEntry) async {
    throw UnimplementedError();

    // TODO: implement CreateCashbookMonth
  }

  Future<void> updateCashbookMonth(CashbookEntry cashbookEntry) {
    // TODO: implement CreateCashbookMonth
    throw UnimplementedError();
  }

  void getCurrentCashbookMonth() async {
    // final currentCashbookMonthRef = await _cashbookMonth!.where("yearMonth", isEqualTo: getCurrentYearMonth()).get().then((value) =>);
  }

  String getCurrentYearMonth() {
    return "${DateTime.now().year.toString()}-${DateTime.now().month.toString()}";
  }
}
