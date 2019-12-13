import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pantroid/add/add_item_page.dart';
import 'package:pantroid/di/injector.dart';
import 'package:pantroid/home/bloc/home_bloc.dart';
import 'package:pantroid/model/item.dart';

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
              var item = state.displayItems[index];
              return _buildListItem(
                item,
                () {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Item [$index] \"${item.name}\" clicked"),
                    ),
                  );
                },
              );
            },
          );
        }),
      );

  Widget _buildListItem(Item item, Function onTap) => ListTile(
        title: Text(item.name),
        subtitle: Text(
            "Quantity: ${item.quantity}, expiration date: ${item.expirationDate}"),
        trailing: Icon(Icons.ac_unit),
        onTap: onTap,
      );
}
