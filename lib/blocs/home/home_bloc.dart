import 'dart:async';

import 'package:bloc_structure/blocs/home/home_event.dart';
import 'package:bloc_structure/blocs/home/home_state.dart';
import 'package:bloc_structure/blocs/network/network.dart';
import 'package:bloc_structure/core/app_string.dart';
import 'package:bloc_structure/core/logger.dart';
import 'package:bloc_structure/data/local/user/user_local_repository.dart';
import 'package:bloc_structure/data/local/user/user_table.dart';
import 'package:bloc_structure/data/model/user.dart';
import 'package:bloc_structure/data/remote/api_provider.dart';
import 'package:bloc_structure/data/repository/user_remote_repository.dart';
import 'package:bloc_structure/injector/injector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UserRemoteRepository _userRepository =
      UserRemoteRepository(Injector.instance.get<BaseApiProvider>());
  final UserLocalRepository _userLocalRepository =
      UserLocalRepositoryImpl(appDatabaseManager: Injector.instance.get<AppDatabase>());
  final NetworkBloc _networkBloc = Injector.instance.get<NetworkBloc>();

  HomeBloc() : super(const Ideal()) {
    on<GetUserData>(_getUserData);
  }

  Future<void> _getUserData(GetUserData event, Emitter<HomeState> emit) async {
    try {
      emit(Loading());
      await _emitUserFromLocalIfHave(event, emit);
      if (await _networkBloc.isConnectedInternet()) {
        final remoteUsers = await _userRepository.getUserFromRemote();
        await _replaceWithNewDataInLocal(remoteUsers);
        await _emitUserFromLocalIfHave(event, emit);
        emit(RefreshData());
      }
    } on Exception catch (e) {
      AppLogger.e(e.toString());
      emit(Error(AppString.somethingWentWrong));
    }
  }

  Future<void> _emitUserFromLocalIfHave(GetUserData event, Emitter<HomeState> emit) async {
    try {
      final userData = await _userLocalRepository.getUsersFromDB();
      final hasLocalUserData = userData.isNotEmpty;
      if (hasLocalUserData) {
        List<User> user = userData
            .map((user) => User(
                name: Name.fromString(user.name),
                email: user.email,
                gender: user.gender,
                phone: user.phone))
            .toList();
        return emit(GetUser(user));
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _replaceWithNewDataInLocal(List<User> remoteUsers) async {
    try {
      await _userLocalRepository.deleteUsersDB();
      await _userLocalRepository.insertListOfUserDB(remoteUsers);
    } catch (e) {
      rethrow;
    }
  }
}
