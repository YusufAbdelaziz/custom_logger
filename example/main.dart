import 'package:custom_logger/src/utils.dart';

class Example with CustomLoggerMixin {
  void demo() {
    logger.v('verbose');
    logger.d('debug');
    logger.i('info');
    logger.w('warning');
    logger.e('error', 'an error',
        StackTrace.fromString('a stacktrace from exception'));
    logger.wtf('wtf');
    logger.prettyJson(json: {'Name': 'Joe', 'Age': 22});
  }
}

void main() {
  // You can define the logging level using :
  // Logger.level = Level.warning;
  var example = Example();
  example.demo();
  print('\n');
  var logger = GenericLogger.create(functionName: 'myFunction');
  logger.i('Hello from myFunction');
}
