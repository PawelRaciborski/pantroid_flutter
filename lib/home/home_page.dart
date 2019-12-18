import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pantroid/add/add_item_page.dart';
import 'package:pantroid/di/injector.dart';
import 'package:pantroid/home/bloc/home_bloc.dart';
import 'package:pantroid/model/tables.dart';

import 'bloc/home_bloc.dart';

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

  Widget _buildList() => BlocProvider<HomeBloc>(
        create: (_) => inject<HomeBloc>(),
        child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          return ListView.builder(
            itemCount: state.displayItems.length,
            itemBuilder: (BuildContext context, int index) {
              final item = state.displayItems[index];
              final bloc = BlocProvider.of<HomeBloc>(context);
              return _buildListItem(
                item,
                () {
                  bloc.add(ItemAddedHomeEvent(item));
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Added item [$index] \"${item.name}\""),
                    ),
                  );
                },
                () {
                  bloc.add(ItemRemovedHomeEvent(item));
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Removed item [$index] \"${item.name}\""),
                    ),
                  );
                },
              );
            },
          );
        }),
      );

  Widget _buildListItem(Item item, Function onAdd, Function onRemove) => Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(item.name),
                Text("Quantity: ${item.quantity}"),
              ],
            ),
          ),
          RaisedButton(
            child: Icon(Icons.add),
            onPressed: onAdd,
          ),
          RaisedButton(
            child: Icon(Icons.remove),
            onPressed: onRemove,
          ),
        ],
      );
}
