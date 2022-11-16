library custom_logger;

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:stack_trace/stack_trace.dart';

import 'logger.dart';

/// Used to be added to any class so runtime type can be inferred automatically,
/// without specifying the type.
mixin CustomLoggerMixin {
  CustomLogger _logger(String runtimeType) {
    return CustomLogger(
      filter: kDebugMode ? DevelopmentFilter() : ReleaseModeLogFilter(),
      printer: CustomLogPrinter(runtimeType),
    );
  }

  CustomLogger get logger => _logger(runtimeType.toString());
}

/// Used to provide the format with which logs are printed.
///
/// [[Level Emoji]] className - message.
class CustomLogPrinter extends PrettyPrinter {
  late final String className;

  CustomLogPrinter(this.className);

  @override
  List<String> log(LogEvent event) {
    final level = event.level;
    final emoji = PrettyPrinter.levelEmojis[level];
    final eventStrings = <String>[];
    eventStrings.add(
        '[${level.toString().split(".")[1].toUpperCase()} ${emoji!.trimRight()}] $className - ${event.message}');
    if (event.error != null) eventStrings.add('\t\t\tError : ${event.error}');
    if (event.stackTrace != null) {
      eventStrings.add('\t\t\tStackTrace : ${Trace.format(event.stackTrace!)}');
    }
    return eventStrings;
  }
}

class ReleaseModeLogFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return event.level == Logger.level;
  }
}

/// Used only to log high level functions that don't belong to a class or may
/// be used with a class we're not interested in its name.
class GenericLogger {
  static CustomLogger create({required String functionName}) {
    if (functionName.startsWith('Instance of')) {
      functionName = _formatClassName(functionName);
    }
    return CustomLogger(
      printer: CustomLogPrinter(functionName),
    );
  }

  /// Removes the "Instance Of " prefix when trying to print a class name.
  static String _formatClassName(String className) {
    return className.replaceAll('Instance of \'', '').replaceAll("'", '');
  }
}
