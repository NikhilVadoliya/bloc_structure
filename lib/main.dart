import 'package:bloc_structure/config/theme/theme.dart';
import 'package:bloc_structure/blocs/global/global_bloc.dart';
import 'package:bloc_structure/routes/navigator_route.dart';
import 'package:bloc_structure/screens/home/home_screen.dart';
import 'package:bloc_structure/blocs/splash/splash_bloc.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<GlobalBloc>(
          create: (BuildContext context) => GlobalBloc(),
        ),
        BlocProvider<SplashBloc>(
          create: (BuildContext context) => SplashBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        routes: NavigatorRoute.routes,
        initialRoute: NavigatorRoute.root,
        theme: true ? ThemeResource().darkTheme : ThemeResource().lightTheme,
        //TODO : Theme notifier implement
      ),
    );
  }
}
