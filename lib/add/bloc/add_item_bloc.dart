import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pantroid/add/save_item_usecase.dart';
import 'package:pantroid/model/item.dart';
import 'package:pantroid/model/tables.dart';

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
        final name = (event as AddItemNameEnteredEvent).name;
        final isNameValid = state.name == null || _validateName(name);
        final newState = state.copyWith(
          name: name,
          shouldFinish: false,
          isNameValid: isNameValid,
          isFormValid: state.isDateValid && isNameValid,
        );
        yield newState;
        break;

      case AddItemQuantityChangedEvent:
        final quantityString = (event as AddItemQuantityChangedEvent).quantity;
        // Quietly ignoring parse exception
        final quantity = int.tryParse(quantityString) ?? 0;

        final newState =
            state.copyWith(shouldFinish: false, quantity: quantity);
        yield newState;
        break;

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
        final item = MoorItemsCompanion.insert(
          name: state.name,
          quantity:  state.quantity,
          addingDate: state.addingDate,
          expirationDate:  state.addingDate,
        );

        try {
          //TODO: add some progress indicator
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
