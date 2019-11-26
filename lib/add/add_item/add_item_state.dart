part of 'add_item_bloc.dart';

@immutable
abstract class AddItemState {
  String get name;

  int get quantity;

  DateTime get addingDate;

  DateTime get expirationDate;
}

class InitialAddItemState extends AddItemState {
  @override
  DateTime get addingDate => DateTime.now();

  @override
  DateTime get expirationDate => DateTime.now();

  @override
  String get name => "";

  @override
  int get quantity => 0;
}

class EditAddItemState extends AddItemState {
  final String _name;

  final int _quantity;

  final DateTime _addingDate;

  final DateTime _expirationDate;

  EditAddItemState(
    this._name,
    this._quantity,
    this._addingDate,
    this._expirationDate,
  );

  @override
  DateTime get addingDate => _addingDate;

  @override
  DateTime get expirationDate => _expirationDate;

  @override
  String get name => _name;

  @override
  int get quantity => _quantity;
}
