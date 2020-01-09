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

  List<Item> _items;

  String _query = "";
  HomeStateSortingType _sortingType = HomeStateSortingType.addingDateDesc;

  HomeBloc(
    this._getAllItemsUseCase,
    this._updateItemQuantityUseCase,
    this._deleteItemUseCase,
  );

  @override
  HomeState get initialState {
    _streamSubscription = _getAllItemsUseCase.execute().listen((data) {
      _items = data;
      add(ListUpdatedHomeEvent(_items));
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
      case FilterListHomeEvent:
        _query = (event as FilterListHomeEvent).query;
        yield state.copyWith(displayItems: _updateList(_query, _sortingType));
        break;
      case SortListHomeEvent:
        final sortingTypeName = (event as SortListHomeEvent).sortingType;
        _sortingType = HomeStateSortingType.values
            .firstWhere((item) => item.displayName == sortingTypeName);

        yield state.copyWith(
            sortingType: _sortingType,
            displayItems: _updateList(_query, _sortingType));
        break;
    }
  }

  List<Item> _updateList(String query, HomeStateSortingType sortingType) {
    var filteredList =
        _items.where((item) => item.name.contains(query)).toList();

    return filteredList
      ..sort((firstItem, secondItem) {
        switch (sortingType) {
          case HomeStateSortingType.nameAsc:
            return firstItem.name.compareTo(secondItem.name);
            break;
          case HomeStateSortingType.nameDes:
            return secondItem.name.compareTo(firstItem.name);
            break;
          case HomeStateSortingType.addingDateAsc:
            // TODO: Handle this case.
            break;
          case HomeStateSortingType.addingDateDesc:
            // TODO: Handle this case.
            break;
          case HomeStateSortingType.expirationDateAsc:
            // TODO: Handle this case.
            break;
          case HomeStateSortingType.expirationDateDesc:
            // TODO: Handle this case.
            break;
        }

        return 0;
      });
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
