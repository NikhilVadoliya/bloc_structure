import 'package:bloc_structure/app.dart';
import 'package:bloc_structure/injector/injector.dart';
import 'package:bloc_structure/core/bloc/simple_bloc_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocDelegate();
  Injector.init();
  runApp(const App());
}
