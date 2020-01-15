part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class ListUpdatedHomeEvent implements HomeEvent {
  final List<Item> items;

  ListUpdatedHomeEvent(this.items);
}

class ItemAddedHomeEvent implements HomeEvent {
  final Item item;

  ItemAddedHomeEvent(this.item);
}

class ItemRemovedHomeEvent implements HomeEvent {
  final Item item;

  ItemRemovedHomeEvent(this.item);
}

class ItemDeletedHomeEvent implements HomeEvent {
  final Item item;

  ItemDeletedHomeEvent(this.item);
}

class FilterListHomeEvent implements HomeEvent {
  final String query;

  FilterListHomeEvent(this.query);
}

class SortListHomeEvent implements HomeEvent {
  final String sortingType;

  SortListHomeEvent(this.sortingType);
}
