import 'package:flutter_simple_dependency_injection/injector.dart';

abstract class DInjector {
  factory DInjector._() => null;

  T inject<T>() => Injector.getInjector().get<T>();
}
