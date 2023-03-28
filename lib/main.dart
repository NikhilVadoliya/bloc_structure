import 'package:bloc_structure/blocs/network/network.dart';
import 'package:bloc_structure/blocs/theme/theme.dart';
import 'package:bloc_structure/core/app_snackbar.dart';
import 'package:bloc_structure/core/theme/dark_theme.dart';
import 'package:bloc_structure/core/theme/light_theme.dart';
import 'package:bloc_structure/injector/injector.dart';
import 'package:bloc_structure/routes/navigator_route.dart';
import 'package:bloc_structure/blocs/splash/splash_bloc.dart';
import 'package:bloc_structure/core/bloc/simple_bloc_delegate.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/app/app.dart';

void main() {
  Bloc.observer = SimpleBlocDelegate();
  Injector.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final messengerKey = GlobalKey<ScaffoldMessengerState>();

    return MultiBlocProvider(
      providers: [
        BlocProvider<ApplicationBloc>(
          create: (BuildContext context) => ApplicationBloc(),
        ),
        BlocProvider<ThemeBloc>(
          create: (BuildContext context) => ThemeBloc(ChangeTheme(
              WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark)),
        ),
        BlocProvider<SplashBloc>(
          create: (BuildContext context) => SplashBloc(),
        ),
        BlocProvider<NetworkBloc>(
          create: (BuildContext context) => NetworkBloc(),
        ),
      ],
      child: BlocListener<NetworkBloc, NetworkState>(listener: (context, state) {
        if (state.isConnected != null && !state.isConnected!) {
          messengerKey.currentState?.showSnackBar(AppSnackBar.snackBarNoInternetConnection());
        } else {
          messengerKey.currentState?.hideCurrentSnackBar();
        }
      }, child: BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
        return MaterialApp(
          scaffoldMessengerKey: messengerKey,
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          routes: NavigatorRoute.routes,
          initialRoute: NavigatorRoute.root,
          theme: state.isDark ? darkTheme : lightTheme,
          //TODO : Theme notifier implement
        );
      })),
    );
  }
}
