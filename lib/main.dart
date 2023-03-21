import 'package:bloc_structure/config/theme/theme.dart';
import 'package:bloc_structure/screens/home/home_view.dart';
import 'package:bloc_structure/simple_bloc_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = SimpleBlocDelegate();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: true ? ThemeResource().darkTheme : ThemeResource().lightTheme,
      //TODO : Theme notifier implement
      home: const HomeView(),
    );
  }
}
