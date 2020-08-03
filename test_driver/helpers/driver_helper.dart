enum DriverCommand { restart, getConcreteNumberTrivia }

class DriverHelper {
  static void getConcreteNumberTrivia() {}

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
