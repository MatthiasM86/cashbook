part of 'observer_bloc.dart';

@immutable
abstract class ObserverEvent {}

class ObserveAllEvent extends ObserverEvent {}

class CashbookItemsUpdatedEvent extends ObserverEvent {
  final Either<CashbookFailure, List<CashbookItem>> failureOrCashbookItems;

  CashbookItemsUpdatedEvent({required this.failureOrCashbookItems});
}
