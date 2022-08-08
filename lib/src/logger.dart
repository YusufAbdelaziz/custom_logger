import 'dart:convert';

import 'package:logger/logger.dart';

class CustomLogger extends Logger {
  CustomLogger({
    LogFilter? filter,
    LogPrinter? printer,
    LogOutput? output,
    Level? level,
  }) : super(filter: filter, level: level, output: output, printer: printer);

  /// Prints full any serializable object into a multi-line full json.
  ///
  /// You can either provide a single map object or a list of map objects.
  ///
  /// Example
  /// ```dart
  ///     logger.prettyJson(json: {'Name': 'Joe', 'Age': 22});
  ///      // prints [VERBOSE ] Example -
  ///      //{
  ///      //"Name": "Joe",
  ///      //"Age": 22
  ///      //}
  /// ```
  void prettyJson(
      {List<Map<String, dynamic>>? jsonList, Map<String, dynamic>? json}) {
    JsonEncoder encoder = const JsonEncoder.withIndent(' ');
    String prettyJson = '';
    if (jsonList != null) {
      prettyJson = encoder.convert(jsonList);
    } else if (json != null) {
      prettyJson = encoder.convert(json);
    }

    log(Level.verbose, '\n' + prettyJson);
  }
}
