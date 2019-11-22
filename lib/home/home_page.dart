import 'package:flutter/material.dart';
import 'package:pantroid/add/add_item_page.dart';

class HomePage extends StatelessWidget {
  static const route = "/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pantroid"),
      ),
      body: _buildList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, AddItemPage.route);
        },
      ),
    );
  }

  Widget _buildList() => ListView.builder(
      itemCount: 20,
      itemBuilder: (BuildContext context, int index) =>
          _buildListItem(index, () {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text("Item $index clicked"),
            ));
          }));

  Widget _buildListItem(int index, Function onTap) => ListTile(
    title:  Text("$index"),
    subtitle: Text("AAAA"),
    trailing: Icon(Icons.ac_unit),
  );
}
