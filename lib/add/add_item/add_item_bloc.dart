import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_item_event.dart';

part 'add_item_state.dart';

class AddItemBloc extends Bloc<AddItemEvent, AddItemState> {
  @override
  AddItemState get initialState => InitialAddItemState();

  @override
  Stream<AddItemState> mapEventToState(AddItemEvent event) async* {
    switch (event.runtimeType) {
      case AddItemNameEnteredEvent:
        {
          var name = (event as AddItemNameEnteredEvent).name;
          var isNameValid = _validateName(name);
          var editAddItemState = EditAddItemState(
            name,
            state.quantity,
            state.addingDate,
            state.expirationDate,
            isNameValid,
            state.isDateValid,
            state.isDateValid && isNameValid,
          );
          yield editAddItemState;
          break;
        }

      case AddItemAddingDateChangedEvent:
        var addingDate = (event as AddItemAddingDateChangedEvent).dateTime;
        var isDateValid = _validateDate(addingDate, state.expirationDate);
        var editAddItemState = EditAddItemState(
          state.name,
          state.quantity,
          addingDate,
          state.expirationDate,
          state.isNameValid,
          isDateValid,
          state.isNameValid && isDateValid,
        );
        yield editAddItemState;
        break;

      case AddItemExpirationDateChangedEvent:
        var expirationDate =
            (event as AddItemExpirationDateChangedEvent).dateTime;
        var isDateValid = _validateDate(state.addingDate, expirationDate);
        var editAddItemState = EditAddItemState(
          state.name,
          state.quantity,
          state.addingDate,
          expirationDate,
          state.isNameValid,
          isDateValid,
          state.isNameValid && isDateValid,
        );
        yield editAddItemState;
        break;
    }
  }

  bool _validateName(String name) => name.isNotEmpty && name.length <= 200;

  bool _validateDate(DateTime addingDate, DateTime expirationDate) =>
      addingDate.isBefore(expirationDate);
}
