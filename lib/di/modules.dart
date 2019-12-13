import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:pantroid/add/bloc/add_item_bloc.dart';
import 'package:pantroid/add/save_item_usecase.dart';
import 'package:pantroid/home/bloc/home_bloc.dart';
import 'package:pantroid/home/get_items_usecase.dart';
import 'package:pantroid/model/db/repository.dart';
import 'package:pantroid/model/item.dart';

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
        (i) => SaveItemUseCaseImpl(i.get<Repository<Item>>()))
    ..map<GetItemsUseCase>(
        (i) => GetItemsUseCaseImpl(i.get<Repository<Item>>()));
}

class DatabaseModule implements Module {
  @override
  Injector initialise(Injector injector) => injector
    ..map<Repository<Item>>((i) => ItemRepository(), isSingleton: true);
}
