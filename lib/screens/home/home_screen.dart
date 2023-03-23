import 'package:bloc_structure/routes/navigator_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/global/global.dart';
import '../../blocs/home/home.dart';



class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (_) => HomeBloc(),
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: Colors.white,
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                  heroTag: 'btn1',
                  onPressed: () {
                    context.read<HomeBloc>().add(Increment());
                  },
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  )),
              FloatingActionButton(
                heroTag: 'btn2',
                onPressed: () {
                  context.read<HomeBloc>().add(Decrement());
                },
                child: const Icon(
                  Icons.minimize,
                  color: Colors.white,
                ),
              ),
              FloatingActionButton(
                heroTag: 'btn3',
                onPressed: () {
                  Navigator.pushNamed(context, NavigatorRoute.detail);
                },
                child: const Icon(
                  Icons.deblur,
                  color: Colors.white,
                ),
              ),
              FloatingActionButton(
                heroTag: 'btn10',
                onPressed: () {
                  context.read<GlobalBloc>().add(AddCartItem());
                },
                child: const Icon(
                  Icons.wordpress_sharp,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is UpdateValueState || state is InitState) {
                    return Text(
                      '${state.value}',
                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
                    );
                  }
                  return const Offstage();
                },
              ),
              BlocBuilder<GlobalBloc, GlobalState>(
                builder: (context, state) {
                  if (state is UpdatedCartItem || state is InitGlobalState) {
                    return Text(
                      '${state.cartCount}',
                      style: const TextStyle(color: Colors.black),
                    );
                  }
                  return const Offstage();
                },
              )
            ],
          ),
        );
      }),
    );
  }
}
