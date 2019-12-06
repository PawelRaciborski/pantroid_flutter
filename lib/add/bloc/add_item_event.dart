part of 'add_item_bloc.dart';

@immutable
abstract class AddItemEvent {}

class AddItemNameEnteredEvent extends AddItemEvent {
  final String name;

  AddItemNameEnteredEvent({@required this.name});
}

class AddItemAddingDateChangedEvent extends AddItemEvent {
  final DateTime dateTime;

  AddItemAddingDateChangedEvent({@required this.dateTime});
}

class AddItemExpirationDateChangedEvent extends AddItemEvent {
  final DateTime dateTime;

  AddItemExpirationDateChangedEvent({@required this.dateTime});
}

class SubmitAddItemFormEvent extends AddItemEvent {}
