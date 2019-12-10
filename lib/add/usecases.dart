import 'package:pantroid/model/item.dart';
import 'package:pantroid/usecases/base_usecases.dart';

abstract class SaveItemUseCase implements FutureUseCase<Item> {
  void initialize(Item item);
}

class SaveItemUseCaseImpl implements SaveItemUseCase {
  Item _item;

  @override
  void initialize(Item item) {
    _item = item;
  }

  @override
  Future<Item> execute() => _item != null
      //TODO: provide real implementation
      ? Future.value(_item)
      : Future.error(
          UninitializedUseCaseException("Item not set for SaveItemUseCase"),
        );
}
