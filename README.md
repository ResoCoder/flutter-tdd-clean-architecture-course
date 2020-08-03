# Flutter Integration Testing with Clean Architecture

The purpose of this repo is to develop best-practices for integration testing for apps built using Clean Architecture. 

## Running Integration Tests
A script is located at the project's root that runs all test files located within the *test_driver* folder.

Execute the following command in your terminal from the root of the project:
~~~~
./integration_tests.sh
~~~~

##  Integration Tests Architecture
A test should be written for each usecase in the app, and each test should be contained within its own test file.

The folder structure of the integration tests should align with the source projects features as followed:

**Source App Use Case Path:**
*lib/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart*

**Integration Test App Use Case Path:**
*test_driver/features/number_trivia/get_concrete_number_trivia_test.dart*

## Identifying Widgets
Utilize Widget's key property to label important widgets of a page:
 - Widgets that support user interaction (buttons, text fields, etc.)
 - Widgets that hold stateful data

Since we're referencing widgets by key, each page in the app should have a corresponding Keys class to make writing integration tests less painful and to avoid duplication and hard-coded strings across the production and test code.

**Keys Class:** 
*lib/features/number_trivia/presentation/pages/number_trivia_page_keys.dart*
~~~~
class NumberTriviaPageKeys {
  static const page = 'page';
  static const txtFieldNumber = 'txtFieldNumber';
  static const btnGetNumberTrivia = 'btnGetNumberTrivia';
  static const btnGetRandomNumberTrivia = 'btnGetRandomNumberTrivia';
  static const txtResultNumber = 'txtResultNumber';
  static const txtResultTrivia = 'txtResultTrivia';
}
~~~~

**Using Keys class in Widgets:** 
*lib/features/number_trivia/presentation/widgets/trivia_controls.dart*
~~~~
Expanded(
  child: RaisedButton(
    key: Key(NumberTriviaPageKeys.btnGetRandomNumberTrivia),
    child: Text('Get random trivia'),
    onPressed: dispatchRandom,
  ),
),
~~~~

**Using Keys class in Integration Tests:** *test_driver/features/number_trivia/get_concrete_number_trivia_test.dart*
~~~~
...
var resultFinder = find.byValueKey(NumberTriviaPageKeys.txtResultNumber);
String resultText = await driver.getText(resultFinder);
...
~~~~

## Optimizing Speed of Tests - WIP
The goal is to prevent full application restarts in-between tests. One way to manage this is to simulate a hot restart by sending a command through the flutter driver.

To support communication between the driver application and the source application, a **DataHandler** can be provided when calling the enableFlutterDriverExtension() method. Providing this handler will enable the FlutterDriver's requestData method.

reference: https://api.flutter.dev/flutter/flutter_driver_extension/DataHandler.html

### Extending Flutter Driver
*test_driver/app.dart*
~~~~
void  main() async {
  Future<String> dataHandler(String commandString) async {
	var command = DriverHelper.getDriverCommand(commandString);
    switch (command) {
      case  DriverCommand.restart:
        app.main(key: UniqueKey());
        return  'success';
      break;
      default:
        return  'unknown command';
    }
  }
  
  enableFlutterDriverExtension(handler: dataHandler);
  
  app.main()
}
~~~~

## Mocking
WIP

## Integration Tests Results
### Screenshots
WIP

### App Performance
WIP