import 'dart:async';

import 'package:bloc_structure/blocs/app/app_bloc.dart';
import 'package:bloc_structure/blocs/theme/theme_bloc.dart';
import 'package:bloc_structure/core/app_snackbar.dart';
import 'package:bloc_structure/core/network/network_provider.dart';
import 'package:bloc_structure/injector/injector.dart';
import 'package:bloc_structure/routes/navigator_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'blocs/splash/splash.dart';
import 'blocs/theme/theme_state.dart';
import 'core/theme/dark_theme.dart';
import 'core/theme/light_theme.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late StreamSubscription<bool> _networkStreamSubscription;
  final messengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    _networkStreamSubscription =
        Injector.instance.get<NetworkProvider>().onStateChange().listen((isConnected) {
      if (isConnected) {
        messengerKey.currentState?.hideCurrentSnackBar();
      } else {
        messengerKey.currentState?.showSnackBar(AppSnackBar.snackBarNoInternetConnection());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
        return ScreenUtilInit(
          designSize: const Size(360, 690),
          builder: (BuildContext context, Widget? child) {
            return MaterialApp(
              scaffoldMessengerKey: messengerKey,
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              routes: NavigatorRoute.routes,
              initialRoute: NavigatorRoute.root,
              theme: state.isDark ? darkTheme : lightTheme,
            );
          },
        );
      }),
    );
  }

  @override
  void dispose() {
    _networkStreamSubscription.cancel();
    super.dispose();
  }
}
