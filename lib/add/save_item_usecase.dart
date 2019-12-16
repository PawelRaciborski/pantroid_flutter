import 'package:pantroid/model/db/repository.dart';
import 'package:pantroid/model/tables.dart';
import 'package:pantroid/usecases/base_usecases.dart';

abstract class SaveItemUseCase implements FutureUseCase<int> {
  void initialize(MoorItemsCompanion item);
}

class SaveItemUseCaseImpl implements SaveItemUseCase {
  MoorItemsCompanion _item;

  final Repository<MoorItem> _repository;

  SaveItemUseCaseImpl(this._repository);

  @override
  void initialize(MoorItemsCompanion item) {
    _item = item;
  }

  @override
  Future<int> execute() => _item != null
      ? _repository.addItem(_item)
      : Future.error(
          UninitializedUseCaseException("Item not set for SaveItemUseCase"),
        );
}
