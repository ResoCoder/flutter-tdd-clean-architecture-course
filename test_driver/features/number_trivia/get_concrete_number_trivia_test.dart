// Imports the Flutter Driver API.
import 'package:clean_architecture_tdd_course/features/number_trivia/presentation/pages/number_trivia_page_keys.dart';
import 'package:clean_architecture_tdd_course/mock/driver_command.dart';
import 'package:flutter_driver/flutter_driver.dart';
// import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
// import 'package:http/http.dart' as http;

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

  // sends command to the flutter driver extension method to restart the app
  // in-between each test
  setUp(() async {
    await driver.requestData(DriverCommand.restart.toString());
  });

  group('getConcreteNumberTrivia - ', () {
    final tNumber = 1;

    test(
      '''should navigate the app and perform a valid concrete number trivia
         request''',
      () async {
        await driver
            .requestData(DriverCommand.getConcreteNumberSuccess.toString());

        await driver.type(
            text: '$tNumber',
            textFieldKey: NumberTriviaPageKeys.txtFieldNumber);

        await driver.tapOn(key: NumberTriviaPageKeys.btnGetNumberTrivia);

        // capture result number text
        String resultText =
            await driver.getTextFrom(key: NumberTriviaPageKeys.txtResultNumber);
        expect(resultText, '$tNumber');
      },
    );

    test(
      '''X2 should navigate the app and perform an invalid concrete number trivia
         request''',
      () async {
        await driver.type(
            text: '-1', textFieldKey: NumberTriviaPageKeys.txtFieldNumber);

        await driver.tapOn(key: NumberTriviaPageKeys.btnGetNumberTrivia);

        // capture result number text
        String resultText = await driver.getTextFrom(
            key: NumberTriviaPageKeys.txtMessageDisplay);

        bool didSucceed = resultText.contains('Invalid Input');
        expect(true, didSucceed);
      },
    );
  });
}
