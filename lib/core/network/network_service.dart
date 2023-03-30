import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkService {
  NetworkService._();

  static const String networkInstanceName = 'networkInstance';

  static void setup() {
    _setupNetworkService();
  }

  static void _setupNetworkService() {
    GetIt.instance.registerLazySingleton<InternetConnectionChecker>(() {
      return InternetConnectionChecker();
    }, instanceName: networkInstanceName);
  }
}
