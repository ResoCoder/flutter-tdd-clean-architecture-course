import 'package:clean_architecture_tdd_course/mock/command_mocker.dart';
import 'package:flutter/material.dart';
import 'features/number_trivia/presentation/pages/number_trivia_page.dart';
import 'injection_container.dart' as di;
import 'mock/driver_command.dart';

enum EnvironmentType { prod, mock }

/// [EnvironmentType] is to determine which dependencies are to be initialized: actual vs mocked
/// [DriverCommand] determines how and which service calls will be mocked when running the mock environment
void main({
  Key key,
  EnvironmentType environment = EnvironmentType.prod,
  DriverCommand command,
}) async {
  WidgetsFlutterBinding.ensureInitialized();

  di.sl.reset();

  switch (environment) {
    case EnvironmentType.prod:
      await di.init();
      break;
    case EnvironmentType.mock:
      await di.initMock();
      CommandMocker.mock(command: command);
      break;
  }

  runApp(MyApp(key: key));
}

class MyApp extends StatelessWidget {
  MyApp({this.key});

  final Key key;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: key,
      title: 'Number Trivia',
      theme: ThemeData(
        primaryColor: Colors.green.shade800,
        accentColor: Colors.green.shade600,
      ),
      home: NumberTriviaPage(),
    );
  }
}
