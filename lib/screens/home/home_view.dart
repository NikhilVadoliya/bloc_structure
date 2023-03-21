import 'package:bloc_structure/screens/home/home_bloc.dart';
import 'package:bloc_structure/screens/home/home_event.dart';
import 'package:bloc_structure/screens/home/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeBloc homeBloc = HomeBloc();
    return BlocProvider<HomeBloc>(
      create: (_) => homeBloc,
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
                onPressed: () {
                  homeBloc.add(Increment());
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                )),
            FloatingActionButton(
              onPressed: () {
                homeBloc.add(Decrement());
              },
              child: const Icon(
                Icons.minimize,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: Center(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is UpdateValueState || state is InitState) {
                print('value : ${state.value}');
                return Text(
                  '${state.value}',
                  style: const TextStyle(color: Colors.black),
                );
              }
              return const Offstage();
            },
          ),
        ),
      ),
    );
    return const Placeholder();
  }
}
