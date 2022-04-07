## Overview

A custom logger that adds the class name as a prefix in your logs.

## Getting started

- You need to add [logger](https://pub.dev/packages/logger) in your `pubspec.yaml` file as a
dependency.
- Add 'custom_logger' to your pubspec.yaml file.
  ```yaml
  custom_logger:
    git: https://github.com/YusufAbdelaziz/custom_logger
  ```
- You'd need to add `CustomLogger` as a mixin with your classes.
## Usage

```dart
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
  var logger = GenericLogger.log(functionName: 'myFunction');
  logger.i('Hello from myFunction');
}
```