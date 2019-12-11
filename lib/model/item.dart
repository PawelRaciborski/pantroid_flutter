import 'package:hive/hive.dart';

part 'item.g.dart';

@HiveType()
class Item {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final int quantity;
  @HiveField(2)
  final DateTime addingDate;
  @HiveField(3)
  final DateTime expirationDate;

  Item(
    this.name,
    this.quantity,
    this.addingDate,
    this.expirationDate,
  );
}
