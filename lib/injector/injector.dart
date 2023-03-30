import 'package:bloc_structure/core/network/network_provider.dart';
import 'package:bloc_structure/core/network/network_service.dart';
import 'package:bloc_structure/data/helper/dio_provider.dart';
import 'package:bloc_structure/data/local/db/user/user_table.dart';
import 'package:bloc_structure/data/local/share_preference/app_preference.dart';
import 'package:bloc_structure/data/remote/api_provider.dart';
import 'package:get_it/get_it.dart';

class Injector {
  static GetIt instance = GetIt.instance;

  Injector._();

  static void init() {

    DioProvide.setup();
    NetworkService.setup();
    instance.registerSingleton<AppDatabase>(AppDatabase());
    instance.registerLazySingleton<BaseApiProvider>(() => APIProvider());
    instance.registerLazySingleton<NetworkProvider>(() => NetworkProviderImp());
    instance.registerLazySingleton<AppPreference>(() => AppPreferenceImp());
  }

  static void reset() {
    instance.reset();
  }

  static void resetLazySingleton() {
    instance.resetLazySingleton();
  }
}
