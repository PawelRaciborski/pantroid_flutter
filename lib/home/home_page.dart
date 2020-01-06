import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pantroid/add/add_item_page.dart';
import 'package:pantroid/di/injector.dart';
import 'package:pantroid/home/bloc/home_bloc.dart';
import 'package:pantroid/model/tables.dart';

import 'bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  static const route = "/";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Item> expandedItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pantroid"),
      ),
      body: _buildList(expandedItems),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, AddItemPage.route);
        },
      ),
    );
  }

  Widget _buildList(List<Item> expandedItems) => BlocProvider<HomeBloc>(
        create: (_) => inject<HomeBloc>(),
        child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          return ListView.builder(
            itemCount: state.displayItems.length,
            itemBuilder: (BuildContext context, int index) {
              final item = state.displayItems[index];
              final bloc = BlocProvider.of<HomeBloc>(context);
              return _buildListItem(
                item,
                expandedItems.any((i) => i.id == item.id),
                () {
                  bloc.add(ItemAddedHomeEvent(item));
                },
                () {
                  bloc.add(ItemRemovedHomeEvent(item));
                },
                () {
                  expandedItems.remove(item);
                  bloc.add(ItemDeletedHomeEvent(item));
                },
                (isExpanded) {
                  if (isExpanded) {
                    expandedItems.add(item);
                  } else {
                    expandedItems.removeWhere((i) => i.id == item.id);
                  }
                },
              );
            },
          );
        }),
      );

  Widget _buildListItem(Item item, bool isExpanded, Function onAdd,
      Function onRemove, Function onDelete, Function(bool) onExpanded) {
    return ExpansionTile(
      key: PageStorageKey<int>(item.id),
      title: Text("${item.name} [${item.quantity}]"),
      initiallyExpanded: isExpanded,
      onExpansionChanged: onExpanded,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FlatButton(
              child: Icon(Icons.add),
              onPressed: onAdd,
            ),
            FlatButton(
              child: Icon(Icons.remove),
              onPressed: onRemove,
            ),
            FlatButton(
              child: Icon(Icons.delete),
              onPressed: onDelete,
            ),
          ],
        ),
      ],
    );
  }
}
