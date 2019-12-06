part of 'add_item_bloc.dart';

@immutable
class AddItemState {
  final String name;
  final int quantity;
  final DateTime addingDate;
  final DateTime expirationDate;
  final bool isNameValid;
  final bool isDateValid;
  final bool isFormValid;
  final bool shouldFinish;

  const AddItemState({
    @required this.name,
    @required this.quantity,
    @required this.addingDate,
    @required this.expirationDate,
    @required this.isNameValid,
    @required this.isDateValid,
    @required this.isFormValid,
    @required this.shouldFinish,
  });

  factory AddItemState.initial() {
    return AddItemState(
      name: null,
      quantity: 0,
      addingDate: DateTime.now(),
      expirationDate: null,
      isNameValid: true,
      isDateValid: false,
      isFormValid: false,
      shouldFinish: false,
    );
  }

  AddItemState copyWith({
    String name,
    int quantity,
    DateTime addingDate,
    DateTime expirationDate,
    bool isNameValid,
    bool isDateValid,
    bool isFormValid,
    bool shouldFinish,
  }) =>
      AddItemState(
          name: name ?? this.name,
          quantity: quantity ?? this.quantity,
          addingDate: addingDate ?? this.addingDate,
          expirationDate: expirationDate ?? this.expirationDate,
          isNameValid: isNameValid ?? this.isNameValid,
          isDateValid: isDateValid ?? this.isDateValid,
          isFormValid: isFormValid ?? this.isFormValid,
          shouldFinish: shouldFinish ?? this.shouldFinish);
}
