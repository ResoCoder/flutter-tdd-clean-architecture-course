// project-specific imports
import 'package:clean_architecture_tdd_course/main.dart' as app;
import 'package:flutter/widgets.dart';
import 'helpers/driver_helper.dart';

// flutter-specific imports
import 'package:flutter_driver/driver_extension.dart';

void main() async {
  Future<String> dataHandler(String commandString) async {
    var command = DriverHelper.getDriverCommand(commandString);
    switch (command) {
      case DriverCommand.restart:
        app.main(key: UniqueKey());
        return 'success';
        break;
      case DriverCommand.getConcreteNumberTrivia:
        return 'success';
      default:
        return 'fail';
    }
  }

  // This line enables the extension.
  enableFlutterDriverExtension(handler: dataHandler);

  // Initialize dependencies specifying the environment.
  // environemtn is used to determine which services to be injected.
  app.main(environment: app.EnvironmentType.mock);
}
