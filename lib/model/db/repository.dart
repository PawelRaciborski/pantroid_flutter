import 'package:moor_flutter/moor_flutter.dart';
import 'package:pantroid/model/tables.dart';

abstract class Repository<T extends Item> {
  Future<int> addItem(UpdateCompanion<T> item);

  Stream<List<T>> getAllItems();
}

class ItemRepository implements Repository<Item> {
  final Database db;

  ItemRepository(this.db);

  @override
  Future<int> addItem(UpdateCompanion<Item> item) => db.addItem(item);

  @override
  Stream<List<Item>> getAllItems() => db.getAllItems();
}
