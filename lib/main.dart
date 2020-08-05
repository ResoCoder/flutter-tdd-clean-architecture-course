import 'package:clean_architecture_tdd_course/mock/command_mocker.dart';
import 'package:flutter/material.dart';
import 'features/number_trivia/presentation/pages/number_trivia_page.dart';
import 'injection_container.dart' as di;
import 'mock/driver_command.dart';

enum Environment { prod, mock }

/// [EnvironmentType] is to determine which dependencies are to be initialized: actual vs mocked
/// [DriverCommand] determines how and which service calls will be mocked when running the mock environment
Future<void> main({
  Environment environment = Environment.prod,
  DriverCommand command,
}) async {
  WidgetsFlutterBinding.ensureInitialized();

  di.sl.reset();

  switch (environment) {
    case Environment.prod:
      await di.init();
      break;
    case Environment.mock:
      await di.initMock();
      CommandMocker.mock(command: command);
      break;
  }

  runApp(MyApp(key: UniqueKey()));
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
