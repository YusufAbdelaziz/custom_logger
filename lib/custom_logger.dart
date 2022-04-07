library custom_logger;

import 'package:logger/logger.dart';

/// Used to be added to any class so runtime type can be inferred automatically,
/// without specifying the type.
mixin CustomLogger {
  Logger _logger(String runtimeType) {
    return Logger(
      printer: CustomLogPrinter(runtimeType),
    );
  }

  Logger get logger => _logger(runtimeType.toString());
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
    return [
      '[${level.toString().split(".")[1].toUpperCase()} ${emoji!.trimRight()}] $className - ${event.message}'
    ];
  }
}

/// Used only to log high level functions that don't belong to a class or may
/// be used with a class we're not interested in its name.
class GenericLogger {
  static Logger create({required String functionName}) {
    if (functionName.startsWith('Instance of')) {
      functionName = formatClassName(functionName);
    }
    return Logger(
      printer: CustomLogPrinter(functionName),
    );
  }

  /// Removes the "Instance Of " prefix when trying to print a class name.
  static String formatClassName(String className) {
    return className.replaceAll('Instance of \'', '').replaceAll("'", '');
  }
}