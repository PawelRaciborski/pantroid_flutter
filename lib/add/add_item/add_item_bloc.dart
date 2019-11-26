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
          yield EditAddItemState(
            (event as AddItemNameEnteredEvent).name,
            state.quantity,
            state.addingDate,
            state.expirationDate,
          );
        }
    }
  }
}
