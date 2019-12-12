import 'package:pantroid/model/db/repository.dart';
import 'package:pantroid/model/item.dart';
import 'package:pantroid/usecases/base_usecases.dart';

abstract class GetItemsUseCase implements StreamUseCase<List<Item>> {}

class GetItemsUseCaseImpl implements GetItemsUseCase {
  final Repository _repository;

  GetItemsUseCaseImpl(this._repository);

  @override
  Stream<List<Item>> execute() => _repository.getAllItems();
}
