import 'package:logger/logger.dart';

class AppLogger {
  AppLogger._();

  static void wtf(String message) {
    Logger().wtf(message);
  }
  static void i(String message) {
    Logger().i(message);
  }
}
