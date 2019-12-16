import 'package:pantroid/model/db/repository.dart';
import 'package:pantroid/model/item.dart';
import 'package:pantroid/model/tables.dart';
import 'package:pantroid/usecases/base_usecases.dart';

abstract class GetItemsUseCase implements StreamUseCase<List<MoorItem>> {}

class GetItemsUseCaseImpl implements GetItemsUseCase {
  final Repository<MoorItem, MoorItemsCompanion> _repository;

  GetItemsUseCaseImpl(this._repository);

  @override
  Stream<List<MoorItem>> execute() => _repository.getAllItems();
}
