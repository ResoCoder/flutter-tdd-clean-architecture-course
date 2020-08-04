import 'package:flutter_driver/flutter_driver.dart';
import 'package:meta/meta.dart';

/// methods to simplify identifying and interacting with known widgets
extension FlutterDriverExtensions on FlutterDriver {
  SerializableFinder findByKey(String key) {
    return find.byValueKey(key);
  }

  SerializableFinder findByType(Type type) {
    return find.byType(type.toString());
  }

  SerializableFinder findBySemanticsLabel(Pattern pattern) {
    return find.bySemanticsLabel(type.toString());
  }

  SerializableFinder findByTooltip(String message) {
    return find.byTooltip(message);
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
    print('waiting for $key');
    await this.waitFor(widget);
  }

  Future<String> getTextFrom({@required String key}) async {
    var resultFinder = find.byValueKey(key);
    return await getText(resultFinder);
  }
}
