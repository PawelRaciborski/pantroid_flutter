import 'package:flutter/material.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:pantroid/add/add_item_page.dart';
import 'package:pantroid/di/injector.dart';
import 'package:pantroid/di/modules.dart';
import 'package:pantroid/home/home_page.dart';

void main() async {
  Injector.getInjector()
      .addModule(BlocModule())
      .addModule(UseCaseModule())
      .addModule(DatabaseModule());

  runApp(PantroidApp());
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
