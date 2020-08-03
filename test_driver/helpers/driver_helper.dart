enum DriverCommand { restart, getConcreteNumberTrivia }

class DriverHelper {
  static void getConcreteNumberTrivia() {}

  /// attemps to convert a string to a [DriverCommand]
  static DriverCommand getDriverCommand(String commandString) {
    try {
      print(commandString);
      return DriverCommand.values
          .firstWhere((e) => e.toString() == commandString);
    } catch (exception) {
      throw 'invalid command sent through the driver';
    }
  }
}
