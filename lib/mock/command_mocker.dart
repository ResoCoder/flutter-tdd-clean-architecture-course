import 'package:clean_architecture_tdd_course/mock/classes/mock_data_connection_checker.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

import 'classes/mock_http_client.dart';
import 'driver_command.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import '../injection_container.dart' as di;

class CommandMocker {
  CommandMocker._();
  static void mock({@required DriverCommand command}) {
    var mockDataConnection =
        di.sl.get<DataConnectionChecker>() as MockDataConnectionChecker;
    mockDataConnection.setupHasConnection();

    switch (command) {
      case DriverCommand.getConcreteNumberSuccess:
      case DriverCommand.getRandomNumberSuccess:
        var client = di.sl.get<http.Client>() as MockHttpClient;
        print('${client.runtimeType} - setting up successful http request');

        client.setUpGetSuccess200();
        break;
      case DriverCommand.getNumberServerFailure:
        var client = di.sl.get<http.Client>() as MockHttpClient;
        print('${client.runtimeType} - setting up failed http request');

        client.setUpGetFailure404();
        break;

        break;
      case DriverCommand.restart:
        break;
    }
  }
}
