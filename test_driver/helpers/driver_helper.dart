import 'package:clean_architecture_tdd_course/mock/driver_command.dart';

class DriverHelper {
  /// attemps to convert a string to a [DriverCommand]
  static DriverCommand getDriverCommand(String commandString) {
    try {
      print('driver command received - $commandString');

      return DriverCommand.values
          .firstWhere((e) => e.toString() == commandString);
    } catch (exception) {
      throw 'invalid command sent through the driver';
    }
  }
}
