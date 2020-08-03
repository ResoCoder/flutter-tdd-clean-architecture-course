// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../../helpers/driver_extensions.dart';
import '../../helpers/driver_helper.dart';

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

  test('test random number trivia', () async {
    driver.delay(5);
    expect(true, true);
  });
}
