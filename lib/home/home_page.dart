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
  HomeBloc _bloc;
  final _filterController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _bloc = inject<HomeBloc>();
    _filterController.addListener(() {
      _bloc.add(FilterListHomeEvent(_filterController.text));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pantroid"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _filterController,
                  ),
                ),
                DropdownButton<String>(
                  items: <String>[
                    "A",
                    "B",
                    "C"
                  ].map<DropdownMenuItem<String>>((value) => DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      )).toList(),
                  onChanged: (value) {

                  },
                )
              ],
            ),
          ),
          Expanded(child: _buildList(expandedItems))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, AddItemPage.route);
        },
      ),
    );
  }

  Widget _buildList(List<Item> expandedItems) => BlocProvider<HomeBloc>(
        create: (_) => _bloc,
        child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          return ListView.builder(
            itemCount: state.displayItems.length,
            itemBuilder: (BuildContext context, int index) {
              final item = state.displayItems[index];
              return _buildListItem(
                item,
                expandedItems.any((i) => i.id == item.id),
                () {
                  _bloc.add(ItemAddedHomeEvent(item));
                },
                () {
                  _bloc.add(ItemRemovedHomeEvent(item));
                },
                () {
                  expandedItems.remove(item);
                  _bloc.add(ItemDeletedHomeEvent(item));
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
