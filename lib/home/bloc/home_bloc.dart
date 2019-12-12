import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pantroid/home/get_items_usecase.dart';
import 'package:pantroid/model/item.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetItemsUseCase _getAllItemsUseCase;
  StreamSubscription _streamSubscription;

  HomeBloc(this._getAllItemsUseCase);

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
    }
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
