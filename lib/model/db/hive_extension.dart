import 'package:hive/hive.dart';
import 'package:pantroid/model/item.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

extension HiveExtension on HiveInterface {
  static const _boxName = "ITEMS_BOX";

  initialize() async {
    final path = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(path.path);
    Hive.registerAdapter(ItemAdapter(), 0);
    await Hive.openBox<Item>(_boxName);
  }

  Box<T> defaultBox<T>() => Hive.box<T>(_boxName);
}
