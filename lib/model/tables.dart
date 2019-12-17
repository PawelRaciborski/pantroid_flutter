import 'package:moor_flutter/moor_flutter.dart';

part 'tables.g.dart';

class Items extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text().withLength(min: 1, max: 200)();

  IntColumn get quantity => integer()();

  DateTimeColumn get addingDate => dateTime()();

  DateTimeColumn get expirationDate => dateTime()();
}

@UseMoor(tables: [Items])
class Database extends _$Database {
  Database()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: 'db.sqlite', logStatements: true));

  @override
  int get schemaVersion => 1;

  Future<int> addItem(ItemsCompanion entry) => into(items).insert(entry);

  Stream<List<Item>> getAllItems() => select(items).watch();
}
