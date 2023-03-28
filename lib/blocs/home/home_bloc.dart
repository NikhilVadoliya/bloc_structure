import 'dart:async';

import 'package:bloc_structure/blocs/home/home_event.dart';
import 'package:bloc_structure/blocs/home/home_state.dart';
import 'package:bloc_structure/blocs/network/network.dart';
import 'package:bloc_structure/core/app_string.dart';
import 'package:bloc_structure/core/logger.dart';
import 'package:bloc_structure/data/repository/user/user_local_repository.dart';
import 'package:bloc_structure/data/local/db/user/user_table.dart';
import 'package:bloc_structure/data/local/share_preference/app_preference.dart';

import 'package:bloc_structure/data/model/user.dart';
import 'package:bloc_structure/data/remote/api_provider.dart';
import 'package:bloc_structure/data/repository/user/user_remote_repository.dart';
import 'package:bloc_structure/data/repository/user/user_repository.dart';
import 'package:bloc_structure/injector/injector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UserRepository _userRepository = UserRepository(
      UserRemoteRepositoryImp(Injector.instance.get<BaseApiProvider>()),
      UserLocalRepositoryImpl(
          appDatabaseManager: Injector.instance.get<AppDatabase>(),
          appPreference: Injector.instance.get<AppPreference>()));

  final NetworkBloc _networkBloc = Injector.instance.get<NetworkBloc>();

  HomeBloc() : super(const Ideal()) {
    on<GetUserData>(_getUserData);
    on<LastUpdatedRecodeDate>(_getLastUpdateDate);
    on<AddLastUpdatedRecodeDate>(_updateLastAddedRecodeDate);
  }

  Future<void> _getUserData(GetUserData event, Emitter<HomeState> emit) async {
    try {
      emit(Loading());
      await _emitUserFromLocalIfHave(event, emit);
      if (await _networkBloc.isConnectedInternet()) {
        final remoteUsers = await _userRepository.remoteRepository.getUserFromRemote();
        add(AddLastUpdatedRecodeDate(DateTime.now().millisecondsSinceEpoch));
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
      final userData = await _userRepository.localRepository.getUsersFromDB();
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
      await _userRepository.localRepository.deleteUsersDB();
      await _userRepository.localRepository.insertListOfUserDB(remoteUsers);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _getLastUpdateDate(LastUpdatedRecodeDate event, Emitter<HomeState> emit) async {
    emit(LoadingForLastUpdatedRecodeDate());
    int? updatedTimestamp = await _userRepository.localRepository.getLastUpdateResponseTimeStamp();
    emit(GetLastUpdatedRecodeDate(updatedTimestamp ?? 0));
  }

  Future<void> _updateLastAddedRecodeDate(
      AddLastUpdatedRecodeDate event, Emitter<HomeState> emit) async {
    await _userRepository.localRepository.lastResponseTimeStamp(event.timeStamp);
    add(LastUpdatedRecodeDate());
  }
}
