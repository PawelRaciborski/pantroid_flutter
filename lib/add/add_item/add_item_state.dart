part of 'add_item_bloc.dart';

@immutable
abstract class AddItemState {
  String get name;

  int get quantity;

  DateTime get addingDate;

  DateTime get expirationDate;

  bool get isNameValid;

  bool get isDateValid;

  bool get idFormValid;

  bool get shouldFinish;
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

  @override
  bool get isNameValid => false;

  @override
  bool get isDateValid => false;

  @override
  bool get idFormValid => false;

  @override
  bool get shouldFinish => false;
}

class EditAddItemState extends AddItemState {
  final String _name;
  final int _quantity;
  final DateTime _addingDate;
  final DateTime _expirationDate;
  final bool _isNameValid;
  final bool _isDateValid;
  final bool _isFormValid;

  EditAddItemState(
    this._name,
    this._quantity,
    this._addingDate,
    this._expirationDate,
    this._isNameValid,
    this._isDateValid,
    this._isFormValid,
  );

  @override
  DateTime get addingDate => _addingDate;

  @override
  DateTime get expirationDate => _expirationDate;

  @override
  String get name => _name;

  @override
  int get quantity => _quantity;

  @override
  bool get isNameValid => _isNameValid;

  @override
  bool get isDateValid => _isDateValid;

  @override
  bool get idFormValid => _isFormValid;

  @override
  bool get shouldFinish => false;
}

class FinishState extends InitialAddItemState {
  @override
  bool get shouldFinish => true;
}
