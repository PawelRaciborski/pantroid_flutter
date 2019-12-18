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
