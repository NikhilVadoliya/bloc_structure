import 'package:bloc_structure/core/network/network_service.dart';
import 'package:bloc_structure/injector/injector.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkProvider {
  Future<bool> hasInternetConnection();

  Stream<bool> onStateChange();
}

class NetworkProviderImp extends NetworkProvider {
  final InternetConnectionChecker internetConnectionChecker =
      Injector.instance(instanceName: NetworkService.networkInstanceName);

  @override
  Future<bool> hasInternetConnection() => internetConnectionChecker.hasConnection;

  @override
  Stream<bool> onStateChange() => internetConnectionChecker.onStatusChange
      .map((event) => event == InternetConnectionStatus.connected);
}
