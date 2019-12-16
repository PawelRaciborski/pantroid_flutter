import 'package:moor_flutter/moor_flutter.dart';
import 'package:pantroid/model/tables.dart';

abstract class Repository<T extends MoorItem> {
  Future<int> addItem(UpdateCompanion<T> item);

  Stream<List<T>> getAllItems();
}

class MoorItemRepository implements Repository<MoorItem> {
  final Database db;

  MoorItemRepository(this.db);

  @override
  Future<int> addItem(UpdateCompanion<MoorItem> item) => db.addItem(item);

  @override
  Stream<List<MoorItem>> getAllItems() => db.getAllItems();
}
