part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class ListUpdatedHomeEvent implements HomeEvent {
  final List<Item> items;

  ListUpdatedHomeEvent(this.items);
}
