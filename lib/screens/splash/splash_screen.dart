import 'package:bloc_structure/routes/navigator_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/splash/splash.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<SplashBloc>().add(LaunchScreen());
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocListener<SplashBloc, SplashState>(
        listener: (_, state) {
          if (state is NavigateToHome) {
            Navigator.of(context).pushReplacementNamed(NavigatorRoute.home);
          }
        },
        child: const Center(
          child: Icon(
            Icons.ac_unit_outlined,
            size: 120,
            color: Colors.amber,
          ),
        ),
      ),
    );
  }
}
