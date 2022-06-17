import 'package:cashbook/failures/cashbook_failures.dart';
import 'package:cashbook/models/cashbook_item.dart';
import 'package:dartz/dartz.dart';

abstract class CashbookRepository {

  Stream<Either<CashbookFailure, List<CashbookItem>>> watchAll();
  Stream<Either<CashbookFailure, List<CashbookItem>>> watchCurrentMonth();
  Future<Either<CashbookFailure, Unit>> create(CashbookItem cashbookItem);
  Future<Either<CashbookFailure, Unit>> update(CashbookItem cashbookItem);
  Future<Either<CashbookFailure, Unit>> delete(CashbookItem cashbookItem);

}