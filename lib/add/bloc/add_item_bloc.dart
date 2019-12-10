import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pantroid/add/usecases.dart';
import 'package:pantroid/model/item.dart';

part 'add_item_event.dart';

part 'add_item_state.dart';

class AddItemBloc extends Bloc<AddItemEvent, AddItemState> {
  final SaveItemUseCase _saveItemUseCase;

  AddItemBloc(this._saveItemUseCase);

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
        final item = Item(
          state.name,
          state.quantity,
          state.addingDate,
          state.addingDate,
        );

        try {
          await (_saveItemUseCase..initialize(item)).execute();
          final newState = state.copyWith(shouldFinish: true);
          yield newState;
        } on Exception catch (exception) {
          //TODO: Handle data writing exceptions
        }

        break;
    }
  }

  bool _validateName(String name) => name.isNotEmpty && name.length <= 200;

  bool _validateDate(DateTime addingDate, DateTime expirationDate) =>
      addingDate.isBefore(expirationDate);
}
