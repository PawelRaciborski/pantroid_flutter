import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_item_event.dart';

part 'add_item_state.dart';

class AddItemBloc extends Bloc<AddItemEvent, AddItemState> {
  @override
  AddItemState get initialState => AddItemState.initial();

  @override
  Stream<AddItemState> mapEventToState(AddItemEvent event) async* {
    switch (event.runtimeType) {
      case AddItemNameEnteredEvent:
        {
          final name = (event as AddItemNameEnteredEvent).name;
          final isNameValid = state.name == null || _validateName(name);
          final newState = state.copyWith(
            name: name,
            isNameValid: isNameValid,
            isFormValid: state.isDateValid && isNameValid,
          );
          yield newState;
          break;
        }

      case AddItemAddingDateChangedEvent:
        final addingDate = (event as AddItemAddingDateChangedEvent).dateTime;
        final isDateValid = _validateDate(addingDate, state.expirationDate);
        final newState = state.copyWith(
          addingDate: addingDate,
          isDateValid: isDateValid,
          isFormValid: state.isNameValid && isDateValid,
        );
        yield newState;
        break;

      case AddItemExpirationDateChangedEvent:
        final expirationDate =
            (event as AddItemExpirationDateChangedEvent).dateTime;
        final isDateValid = _validateDate(state.addingDate, expirationDate);
        final newState = state.copyWith(
            expirationDate: expirationDate,
            isDateValid: isDateValid,
            isFormValid: state.isNameValid && isDateValid);
        yield newState;
        break;

      case SubmitAddItemFormEvent:
        final newState = state.copyWith(shouldFinish: true);
        yield newState;
        break;
    }
  }

  bool _validateName(String name) => name.isNotEmpty && name.length <= 200;

  bool _validateDate(DateTime addingDate, DateTime expirationDate) =>
      addingDate.isBefore(expirationDate);
}
