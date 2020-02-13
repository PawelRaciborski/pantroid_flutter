import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:pantroid/add/add_item_page.dart';
import 'package:pantroid/di/injector.dart';
import 'package:pantroid/di/modules.dart';
import 'package:pantroid/home/home_page.dart';

void main() async {
  Injector.getInjector()
      .addModule(BlocModule())
      .addModule(UseCaseModule())
      .addModule(DatabaseModule());

  var delegate = await LocalizationDelegate.create(
      fallbackLocale: 'en', supportedLocales: ['en', 'pl']);

  runApp(LocalizedApp(delegate, PantroidApp()));
}

class PantroidApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;

    return LocalizationProvider(
      state: LocalizationProvider.of(context).state,
      child: MaterialApp(
        title: translate('app_bar.title'),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          localizationDelegate
        ],
        supportedLocales: localizationDelegate.supportedLocales,
        locale: localizationDelegate.currentLocale,
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
        ),
        initialRoute: HomePage.route,
        routes: {
          HomePage.route: (context) => HomePage(),
          AddItemPage.route: (context) => AddItemPage(),
        },
      ),
    );
  }
}
