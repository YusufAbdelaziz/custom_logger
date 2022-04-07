import 'package:custom_logger/custom_logger.dart';
import 'package:logger/logger.dart';

class Example with CustomLogger {
  void demo() {
    logger.v('verbose');
    logger.d('debug');
    logger.i('info');
    logger.w('warning');
    logger.e('error');
    logger.wtf('wtf');
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
