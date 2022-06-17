part of 'observer_bloc.dart';

@immutable
abstract class ObserverState {}

class ObserverInitial extends ObserverState {}

class ObseverLoading extends ObserverState {}

class ObserverFailure extends ObserverState {
  final CashbookFailure cashbookFailure;
  ObserverFailure({required this.cashbookFailure});
}

class ObserverSuccess extends ObserverState {
  final List<CashbookItem> cashbookItems;
  ObserverSuccess({required this.cashbookItems});
}
