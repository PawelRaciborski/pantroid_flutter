import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:flutter/material.dart';

extension StateInjectorExtension on State {
  T inject<T>() => Injector.getInjector().get<T>();
}
