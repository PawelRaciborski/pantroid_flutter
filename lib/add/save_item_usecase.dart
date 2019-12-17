import 'package:pantroid/model/db/repository.dart';
import 'package:pantroid/model/tables.dart';
import 'package:pantroid/usecases/base_usecases.dart';

abstract class SaveItemUseCase implements FutureUseCase<int> {
  void initialize(ItemsCompanion item);
}

class SaveItemUseCaseImpl implements SaveItemUseCase {
  ItemsCompanion _item;

  final Repository<Item> _repository;

  SaveItemUseCaseImpl(this._repository);

  @override
  void initialize(ItemsCompanion item) {
    _item = item;
  }

  @override
  Future<int> execute() => _item != null
      ? _repository.addItem(_item)
      : Future.error(
          UninitializedUseCaseException("Item not set for SaveItemUseCase"),
        );
}
