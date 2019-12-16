import 'package:hive/hive.dart';
import 'package:pantroid/model/item.dart';
import 'package:pantroid/model/tables.dart';
import 'package:rxdart/rxdart.dart';

abstract class Repository<T, Y> {
  Future<int> addItem(Y item);

  Stream<List<T>> getAllItems();
}

class ItemRepository implements Repository<Item, Item> {
  final Box<Item> box;

  bool isInitialized = false;
  BehaviorSubject<List<Item>> _getAllSubject;

  ItemRepository(this.box);

  @override
  Future<int> addItem(Item item) async => box.add(item);

  @override
  Stream<List<Item>> getAllItems() {
    if (_getAllSubject == null) {
      _getAllSubject = BehaviorSubject<List<Item>>();
    }

    _getAllSubject.add(box.getAll<Item>());

    _getAllSubject.addStream(box.watch().map((_) => box.getAll<Item>()));

    return _getAllSubject.stream;
  }
}

extension _BoxExtension on Box {
  List<T> getAll<T>() => List<T>.generate(
        length,
        (i) => getAt(i),
      );
}

class MoorItemRepository implements Repository<MoorItem, MoorItemsCompanion> {
  final Database db;

  MoorItemRepository(this.db);

  @override
  Future<int> addItem(MoorItemsCompanion item) => db.addItem(item);

  @override
  Stream<List<MoorItem>> getAllItems() => db.getAllItems();
}
