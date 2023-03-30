import 'package:bloc_structure/data/local/db/user/user_table.dart';
import 'package:bloc_structure/data/local/share_preference/app_preference.dart';
import 'package:bloc_structure/data/model/user.dart';
import 'package:bloc_structure/data/remote/api_provider.dart';
import 'package:bloc_structure/data/repository/user/user_local_provider.dart';
import 'package:bloc_structure/data/repository/user/user_remote_repository.dart';
import 'package:bloc_structure/injector/injector.dart';


abstract class UserRepository {
  Future<List<User>> getRemoteUser();

  Future<void> addListOfUserInLocal(List<User> user);

  Future<List<User>> getUsersFromLocal();

  Future<int> deleteAllUsersFromLocal();

  Future<void> setLatestResponseTime(int timestamp);

  Future<int?> getLatestResponseTimeStamp();
}

class UserRepositoryImp extends UserRepository {
  late final UserLocalProvider userLocalRepository;
  late final UserRemoteProvider userRemoteRepository;

  UserRepositoryImp.init() {
    userLocalRepository = UserLocalProvideImpl(
        appPreference: Injector.instance.get<AppPreference>(),
        appDatabaseManager: Injector.instance.get<AppDatabase>());
    userRemoteRepository = UserRemoteProviderImp(Injector.instance.get<BaseApiProvider>());
  }

  @override
  Future<void> addListOfUserInLocal(List<User> user) async =>
      await userLocalRepository.insertListOfUserDB(user);

  @override
  Future<int> deleteAllUsersFromLocal() async => await userLocalRepository.deleteUsersDB();

  @override
  Future<int?> getLatestResponseTimeStamp() async =>
      await userLocalRepository.getLastUpdateResponseTimeStamp();

  @override
  Future<List<User>> getRemoteUser() async => await userRemoteRepository.getUserFromRemote();

  @override
  Future<List<User>> getUsersFromLocal() async {
    List<UserLocalData> localUser = await userLocalRepository.getUsersFromDB();
    return localUser
        .map((user) => User(
        name: Name.fromString(user.name),
        gender: user.gender,
        email: user.email,
        phone: user.phone))
        .toList();
  }

  @override
  Future<void> setLatestResponseTime(int timestamp) async =>
      await userLocalRepository.lastResponseTimeStamp(timestamp);
}
