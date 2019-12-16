part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class ListUpdatedHomeEvent implements HomeEvent {
  final List<MoorItem> items;

  ListUpdatedHomeEvent(this.items);
}
