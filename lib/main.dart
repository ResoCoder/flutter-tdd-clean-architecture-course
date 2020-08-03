import 'package:flutter/material.dart';
import 'features/number_trivia/presentation/pages/number_trivia_page.dart';
import 'injection_container.dart' as di;

enum EnvironmentType { dev, prod, mock }

void main({Key key, EnvironmentType environment = EnvironmentType.prod}) async {
  WidgetsFlutterBinding.ensureInitialized();

  di.sl.reset();
  await di.init(environment: environment);

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
