import 'package:pantroid/model/db/repository.dart';
import 'package:pantroid/model/tables.dart';
import 'package:pantroid/usecases/base_usecases.dart';

abstract class GetItemsUseCase implements StreamUseCase<List<Item>> {}

class GetItemsUseCaseImpl implements GetItemsUseCase {
  final Repository<Item> _repository;

  GetItemsUseCaseImpl(this._repository);

  @override
  Stream<List<Item>> execute() => _repository.getAllItems();
}

enum UpdateItemActionType {
  increment,
  decrement,
}

abstract class UpdateItemQuantityUseCase implements FutureUseCase<bool> {
  UpdateItemQuantityUseCase initialize(
      Item item, UpdateItemActionType actionType);
}

class UpdateItemQuantityUseCaseImpl implements UpdateItemQuantityUseCase {
  Item _item;

  UpdateItemActionType _actionType;

  final Repository<Item> _repository;

  UpdateItemQuantityUseCaseImpl(this._repository);

  @override
  Future<bool> execute() {
    if (_actionType == UpdateItemActionType.increment) {
      return _repository.updateItem(
        _item.copyWith(
          quantity: _item.quantity + 1,
        ),
      );
    } else if (_item.quantity > 0) {
      return _repository.updateItem(
        _item.copyWith(
          quantity: _item.quantity - 1,
        ),
      );
    }
    return Future.value(true);
  }

  @override
  UpdateItemQuantityUseCase initialize(
      Item item, UpdateItemActionType actionType) {
    this._item = item;
    this._actionType = actionType;
    return this;
  }
}
