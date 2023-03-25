import 'package:bloc_structure/blocs/network/network.dart';
import 'package:bloc_structure/core/theme/app_snackbar.dart';
import 'package:bloc_structure/data/local/user/user_table.dart';
import 'package:bloc_structure/injector/injector.dart';
import 'package:bloc_structure/routes/navigator_route.dart';
import 'package:bloc_structure/blocs/splash/splash_bloc.dart';
import 'package:bloc_structure/core/simple_bloc_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
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
        BlocProvider<SplashBloc>(
          create: (BuildContext context) => SplashBloc(),
        ),
        BlocProvider<NetworkBloc>(
          create: (BuildContext context) => NetworkBloc(),
        ),
      ],
      child: BlocListener<NetworkBloc, NetworkState>(
          listener: (context, state) {
            if (state.isConnected != null && !state.isConnected!) {
              messengerKey.currentState?.showSnackBar(AppSnackBar.snackBarNoInternetConnection());
            } else {
              messengerKey.currentState?.hideCurrentSnackBar();
            }
          },
          child: MaterialApp(
            scaffoldMessengerKey: messengerKey,
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            routes: NavigatorRoute.routes,
            initialRoute: NavigatorRoute.root,
            // theme: true ? ThemeResource().darkTheme : ThemeResource().lightTheme,
            //TODO : Theme notifier implement
          )),
    );
  }
}
