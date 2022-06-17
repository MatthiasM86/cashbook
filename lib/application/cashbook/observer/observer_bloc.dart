import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cashbook/failures/cashbook_failures.dart';
import 'package:cashbook/models/cashbook_item.dart';
import 'package:cashbook/repositories/cashbook_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'observer_event.dart';
part 'observer_state.dart';

class ObserverBloc extends Bloc<ObserverEvent, ObserverState> {
  final CashbookRepository cashbookRepository;

  StreamSubscription<Either<CashbookFailure, List<CashbookItem>>>?
      _cashbookItemStreamSub;

  ObserverBloc({required this.cashbookRepository}) : super(ObserverInitial()) {
    on<ObserveAllEvent>((event, emit) async {
      emit(ObseverLoading());
      await _cashbookItemStreamSub?.cancel();
      _cashbookItemStreamSub = cashbookRepository.watchAll().listen(
          (failureOrCashbookItems) => add(CashbookItemsUpdatedEvent(
              failureOrCashbookItems: failureOrCashbookItems)));
    });

    on<CashbookItemsUpdatedEvent>((event, emit) {
      print(event.failureOrCashbookItems);
      event.failureOrCashbookItems.fold(
        (failures) => emit(ObserverFailure(cashbookFailure: failures)),
        (cashbookItems) => emit(ObserverSuccess(cashbookItems: cashbookItems)),
      );
    });
  }

  @override
  Future<void> close() async {
    await _cashbookItemStreamSub?.cancel();
    return super.close();
  }
}
