// Imports the Flutter Driver API.
import 'package:clean_architecture_tdd_course/features/number_trivia/presentation/pages/number_trivia_page_keys.dart';
import 'package:clean_architecture_tdd_course/mock/driver_command.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../../helpers/driver_extensions.dart';

void main() {
  FlutterDriver driver;

  // Connect to the Flutter driver before running any tests.
  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  // Close the connection to the driver after the tests have completed.
  tearDownAll(() async {
    if (driver != null) {
      driver.close();
    }
  });

  setUp(() async {
    await driver.requestData(DriverCommand.restart.toString());
  });

  test(
    '''should navigate the app and perform a valid random number trivia
         request''',
    () async {
      await driver.requestData(DriverCommand.getRandomNumberSuccess.toString());

      await driver.tapOn(key: NumberTriviaPageKeys.btnGetRandomNumberTrivia);

      // capture result number text
      await driver.waitOn(key: NumberTriviaPageKeys.txtResultNumber);
    },
  );
}
