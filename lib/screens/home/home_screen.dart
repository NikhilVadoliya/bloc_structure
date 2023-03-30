import 'package:bloc_structure/blocs/theme/theme.dart';
import 'package:bloc_structure/core/network/network_provider.dart';
import 'package:bloc_structure/data/repository/user/user_repository.dart';
import 'package:bloc_structure/injector/injector.dart';
import 'package:bloc_structure/screens/home/widget/last_updated_record_time.dart';
import 'package:bloc_structure/screens/home/widget/user_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/home/home.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<UserRepository>(
      create: (_) => UserRepositoryImp.init(),
      child: BlocProvider<HomeBloc>(
        create: (context) => HomeBloc(RepositoryProvider.of<UserRepository>(context),
            Injector.instance.get<NetworkProvider>())
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
                    child: Icon(
                        context.read<ThemeBloc>().state.isDark ? Icons.dark_mode : Icons.light),
                    onPressed: () {
                      context.read<ThemeBloc>().add(context.read<ThemeBloc>().state.isDark
                          ? LightThemeEvent()
                          : DarkThemeEvent());
                    });
              },
            ),
            body: Column(
              children: const [
                SizedBox(height: 20),
                LastUpdatedRecordTime(),
                Expanded(child: UserList()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
