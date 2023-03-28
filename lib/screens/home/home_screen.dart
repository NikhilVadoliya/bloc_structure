import 'package:bloc_structure/blocs/network/network.dart';
import 'package:bloc_structure/blocs/theme/theme.dart';
import 'package:bloc_structure/core/app_string.dart';
import 'package:bloc_structure/core/app_snackbar.dart';
import 'package:bloc_structure/screens/home/widget/user_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/home/home.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<NetworkBloc>().add(StartListener());
    return BlocProvider<HomeBloc>(
      create: (_) => HomeBloc()
        ..add(GetUserData())
        ..add(LastUpdatedRecodeDate()),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Users'),
          ),
          floatingActionButton: BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return FloatingActionButton(
                  child:
                      Icon(context.read<ThemeBloc>().state.isDark ? Icons.dark_mode : Icons.light),
                  onPressed: () {
                    context.read<ThemeBloc>().add(context.read<ThemeBloc>().state.isDark
                        ? LightThemeEvent()
                        : DarkThemeEvent());
                  });
            },
          ),
          body: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<HomeBloc, HomeState>(
                buildWhen: (oldState, newState) =>
                    newState != RefreshData() && newState is LastUpdateDataState,
                builder: (context, state) {
                  if (state is GetLastUpdatedRecodeDate) {
                    return Text(
                      '$lastUpdatedOn ${state.timestamp}',
                      style: const TextStyle(fontSize: 10),
                    );
                  } else if (state is LoadingForLastUpdatedRecodeDate) {
                    return const SizedBox(
                      width: 20,
                      height: 20,
                      child: Center(
                          child: CircularProgressIndicator(
                        color: Colors.green,
                      )),
                    );
                  }
                  return const Offstage();
                },
              ),
              Expanded(
                child: BlocConsumer<HomeBloc, HomeState>(
                  buildWhen: (oldState, newState) =>
                      newState != RefreshData() && newState is UserListState,
                  listener: (context, state) {
                    if (state == RefreshData()) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(AppSnackBar.normalSnackBar(refreshData));
                    }
                  },
                  builder: (context, state) {
                    if (state is GetUser) {
                      final userList = state.user;
                      return ListView.separated(
                        itemCount: userList.length,
                        itemBuilder: (_, index) => UserListItem(
                          user: userList[index],
                        ),
                        separatorBuilder: (BuildContext context, int index) => const Divider(),
                      );
                    } else if (state is Loading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is Error) {
                      return Center(child: Text(state.message));
                    }
                    return const Offstage();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
