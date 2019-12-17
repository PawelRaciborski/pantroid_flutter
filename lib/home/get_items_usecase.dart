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
