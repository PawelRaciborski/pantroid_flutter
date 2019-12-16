import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:hive/hive.dart';
import 'package:pantroid/add/bloc/add_item_bloc.dart';
import 'package:pantroid/add/save_item_usecase.dart';
import 'package:pantroid/home/bloc/home_bloc.dart';
import 'package:pantroid/home/get_items_usecase.dart';
import 'package:pantroid/model/db/hive_extension.dart';
import 'package:pantroid/model/db/repository.dart';
import 'package:pantroid/model/item.dart';
import 'package:pantroid/model/tables.dart';

abstract class Module {
  Injector initialise(Injector injector);
}

class BlocModule implements Module {
  Injector initialise(Injector injector) => injector
    ..map<AddItemBloc>((i) => AddItemBloc(i.get<SaveItemUseCase>()))
    ..map<HomeBloc>((i) => HomeBloc(i.get<GetItemsUseCase>()));
}

class UseCaseModule implements Module {
  @override
  Injector initialise(Injector injector) => injector
    ..map<SaveItemUseCase>(
        (i) => SaveItemUseCaseImpl(i.get<Repository<MoorItem, MoorItemsCompanion>>()))
    ..map<GetItemsUseCase>(
        (i) => GetItemsUseCaseImpl(i.get<Repository<MoorItem, MoorItemsCompanion>>()));
}

class DatabaseModule implements Module {
  @override
  Injector initialise(Injector injector) => injector
    ..map<Box<Item>>(
      (i) => Hive.defaultBox<Item>(),
      isSingleton: true,
    )
    ..map<Database>((i) => Database(), isSingleton: true)
    ..map<Repository<Item, Item>>(
      (i) => ItemRepository(i.get<Box<Item>>()),
      isSingleton: true,
    )
    ..map<Repository<MoorItem, MoorItemsCompanion>>(
      (i) => MoorItemRepository(i.get<Database>()),
      isSingleton: true,
    );
}
