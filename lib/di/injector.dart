import 'package:flutter/material.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

import 'modules.dart';

extension StateInjectorExtension on State {
  T inject<T>() => Injector.getInjector().get<T>();
}

extension InjectorExtension on Injector {
  Injector addModule(Module module) => module.initialise(this);
}
