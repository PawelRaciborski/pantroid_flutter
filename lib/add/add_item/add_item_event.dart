part of 'add_item_bloc.dart';

@immutable
abstract class AddItemEvent {}

class AddItemNameEnteredEvent extends AddItemEvent {
  final String name;

  AddItemNameEnteredEvent({@required this.name});
}
