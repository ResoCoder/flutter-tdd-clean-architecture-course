import 'package:flutter_driver/flutter_driver.dart';
import 'package:meta/meta.dart';

extension FlutterDriverExtensions on FlutterDriver {
  SerializableFinder findByKey(String key) {
    return find.byValueKey(key);
  }

  Future<void> type(
      {@required String text, @required String textFieldKey}) async {
    var textField = findByKey(textFieldKey);
    await tap(textField);
    await enterText(text);
  }

  Future<void> tapOn({@required String key}) async {
    var widget = findByKey(key);
    await this.tap(widget);
  }

  Future<void> delay([int milliseconds = 250]) async {
    await Future<void>.delayed(Duration(milliseconds: milliseconds));
  }

  Future<void> waitOn({@required String key}) async {
    var widget = findByKey(key);
    await this.waitFor(widget);
  }
}
