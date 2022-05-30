import 'package:cashbook/models/cashbook_entry.dart';

abstract class ICashbookRepository {
  //Future<void> addCashbookMonth(CashbookEntry cashbookEntry);
  Future<void> addCashbookEntry(CashbookEntry cashbookEntry);
}