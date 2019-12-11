import 'package:hive/hive.dart';
import 'package:pantroid/model/item.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

abstract class Repository<T> {
  Future<int> addItem(T item);
}

class ItemRepository implements Repository<Item> {
  static const _boxName = "ITEMS_BOX";
  bool isInitialized = false;

  Future<Box<Item>> get _box async {
    if (!isInitialized) {
      final path = await path_provider.getApplicationDocumentsDirectory();
      Hive.init(path.path);
      Hive.registerAdapter(ItemAdapter(), 0);
      isInitialized = true;
    }
    return Hive.openBox<Item>(_boxName);
  }

  @override
  Future<int> addItem(Item item) async {
    final box = await _box;

    return box.add(item);
  }
}
