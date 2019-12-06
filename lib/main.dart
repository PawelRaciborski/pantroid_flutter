import 'package:flutter/material.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:pantroid/add/add_item_page.dart';
import 'package:pantroid/add/bloc/add_item_bloc.dart';
import 'package:pantroid/home/home_page.dart';

void main() {
  final injector = ModuleContainer().initialise(Injector.getInjector());

  print(injector.get<String>(key: "asdasd"));
  runApp(PantroidApp());
}

class ModuleContainer {
  Injector initialise(Injector injector) {
    return injector
      ..map<String>((i) => "Jajeczko", key: "asdasd")
      ..map<AddItemBloc>((i) => AddItemBloc());
  }
}

class PantroidApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      initialRoute: HomePage.route,
      routes: {
        HomePage.route: (context) => HomePage(),
        AddItemPage.route: (context) => AddItemPage(),
      },
    );
  }
}
