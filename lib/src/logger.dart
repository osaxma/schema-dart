import 'package:cli_util/cli_logging.dart';

class Log {
  static late final Logger _logger = Logger.standard();
  static late final Logger _loggerV = Logger.verbose();

  static bool verbose = false;

  /// Print trace output.
  static void trace(String message) => verbose ? _loggerV.trace(message) : _logger.trace(message);

  /// Print a standard status message.
  static void stdout(String message) => verbose ? _loggerV.stdout(message) : _logger.stdout(message);

  /// Print an error message.
  static void sterr(String message) => verbose ? _loggerV.stderr(message) : _logger.stderr(message);

  /// Print text to stdout, without a trailing newline.
  void write(String message) => verbose ? _loggerV.write(message) : _logger.write(message);

  /// Print a character code to stdout, without a trailing newline.
  void writeCharCode(int charCode) => verbose ? _loggerV.writeCharCode(charCode) : _logger.writeCharCode(charCode);

  /// Print text to stdout, without a trailing newline.
  static Progress progress(String message) => verbose ? _loggerV.progress(message) : _logger.progress(message);
}
