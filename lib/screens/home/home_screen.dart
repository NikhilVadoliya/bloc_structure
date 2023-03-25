import 'package:bloc_structure/blocs/network/network.dart';
import 'package:bloc_structure/core/app_string.dart';
import 'package:bloc_structure/core/theme/app_snackbar.dart';
import 'package:bloc_structure/data/repository/user_remote_repository.dart';
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
      create: (_) => HomeBloc()..add(GetUserData()),
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: BlocConsumer<HomeBloc, HomeState>(
            buildWhen: (oldState, newState) => newState != RefreshData(),
            listener: (context, state) {
              if (state == RefreshData()) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(AppSnackBar.normalSnackBar(AppString.refreshData));
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
        );
      }),
    );
  }
}
