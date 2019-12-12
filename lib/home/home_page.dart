import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pantroid/add/add_item_page.dart';
import 'package:pantroid/model/db/repository.dart';
import 'package:pantroid/model/item.dart';

class HomePage extends StatelessWidget {
  static const route = "/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pantroid"),
      ),
      body: Text("asd"), //_buildList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, AddItemPage.route);
        },
      ),
    );
  }

  Widget _buildList() => WatchBoxBuilder(
      box: Hive.box<Item>(ItemRepository.boxName),
      builder: (context, box) {
        return ListView.builder(
            itemCount: box.length,
            itemBuilder: (BuildContext context, int index) {
              var item = box.getAt(index);
              return _buildListItem(item, () {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text("Item [$index] \"${item.name}\" clicked"),
                ));
              });
            });
      });

  Widget _buildListItem(Item item, Function onTap) => ListTile(
        title: Text(item.name),
        subtitle: Text(
            "Quantity: ${item.quantity}, expiration date: ${item.expirationDate}"),
        trailing: Icon(Icons.ac_unit),
        onTap: onTap,
      );
}
