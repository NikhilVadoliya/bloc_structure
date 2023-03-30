import 'dart:async';

import 'package:bloc_structure/blocs/home/home_event.dart';
import 'package:bloc_structure/blocs/home/home_state.dart';
import 'package:bloc_structure/core/app_string.dart';
import 'package:bloc_structure/core/logger.dart';
import 'package:bloc_structure/core/network/network_provider.dart';

import 'package:bloc_structure/data/model/user.dart';
import 'package:bloc_structure/data/repository/user/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  late final UserRepository _userRepository;
  final NetworkProvider _networkProvider;

  HomeBloc(this._userRepository, this._networkProvider) : super(const Ideal()) {
    on<GetUserData>(_getUserData);
    on<LastUpdatedRecodeDate>(_getLastUpdateDate);
  }

  Future<void> _getUserData(GetUserData event, Emitter<HomeState> emit) async {
    try {
      emit(Loading());
      await _emitUserFromLocalIfHave(event, emit);
      if (await _networkProvider.hasInternetConnection()) {
        final remoteUsers = await _userRepository.getRemoteUser();
        await _setLastUpdateLastAddedRecodeDate(event, emit, DateTime.now().millisecondsSinceEpoch);
        await _replaceWithNewDataInLocal(remoteUsers);
        await _emitUserFromLocalIfHave(event, emit);
        emit(RefreshData());
      }
    } on Exception catch (e) {
      AppLogger.e(e.toString());
      emit(const Error(somethingWentWrong));
    }
  }

  Future<void> _emitUserFromLocalIfHave(GetUserData event, Emitter<HomeState> emit) async {
    try {
      final userData = await _userRepository.getUsersFromLocal();
      final hasLocalUserData = userData.isNotEmpty;
      if (hasLocalUserData) {
        return emit(GetUser(userData));
      } else {
        return emit(const Error(notDataFound));
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _replaceWithNewDataInLocal(List<User> remoteUsers) async {
    try {
      await _userRepository.deleteAllUsersFromLocal();
      await _userRepository.addListOfUserInLocal(remoteUsers);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _getLastUpdateDate(HomeEvent event, Emitter<HomeState> emit) async {
    emit(LoadingForLastUpdatedRecodeDate());
    int? updatedTimestamp = await _userRepository.getLatestResponseTimeStamp();
    emit(GetLastUpdatedRecodeDate(updatedTimestamp ?? 0));
    return;
  }

  Future<void> _setLastUpdateLastAddedRecodeDate(
      HomeEvent homeEvent, Emitter<HomeState> emit, int timeStamp) async {
    await _userRepository.setLatestResponseTime(timeStamp);
    await _getLastUpdateDate(homeEvent, emit);
    return;
  }
}
