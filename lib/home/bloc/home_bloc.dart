import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pantroid/home/home_usecases.dart';
import 'package:pantroid/model/tables.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetItemsUseCase _getAllItemsUseCase;
  final UpdateItemQuantityUseCase _updateItemQuantityUseCase;
  final DeleteItemUseCase _deleteItemUseCase;
  StreamSubscription _streamSubscription;

  HomeBloc(
    this._getAllItemsUseCase,
    this._updateItemQuantityUseCase,
    this._deleteItemUseCase,
  );

  @override
  HomeState get initialState {
    _streamSubscription = _getAllItemsUseCase.execute().listen((data) {
      add(ListUpdatedHomeEvent(data));
    });
    return HomeState.initial();
  }

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    switch (event.runtimeType) {
      case ListUpdatedHomeEvent:
        final items = (event as ListUpdatedHomeEvent).items;
        yield state.copyWith(isLoading: false, displayItems: items);
        break;
      case ItemAddedHomeEvent:
        final item = (event as ItemAddedHomeEvent).item;
        await _updateItemQuantityUseCase
            .initialize(item, UpdateItemActionType.increment)
            .execute();
        break;
      case ItemRemovedHomeEvent:
        final item = (event as ItemRemovedHomeEvent).item;
        await _updateItemQuantityUseCase
            .initialize(item, UpdateItemActionType.decrement)
            .execute();
        break;
      case ItemDeletedHomeEvent:
        final item = (event as ItemDeletedHomeEvent).item;
        await _deleteItemUseCase.initialize(item).execute();
        break;
    }
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
