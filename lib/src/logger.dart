// coverage:ignore-file
import 'package:cli_util/cli_logging.dart';

// cli_util logger does not have a singelton.
// This was created to avoid passing the logger all over the place.
class Log {
  static final Logger _logger = Logger.standard();
  static final Logger _loggerVerbose = Logger.verbose();

  static bool verbose = false;

  /// Print trace output.
  static void trace(String message) => verbose ? _loggerVerbose.trace(message) : _logger.trace(message);

  /// Print a standard status message.
  static void stdout(String message) => verbose ? _loggerVerbose.stdout(message) : _logger.stdout(message);

  /// Print an error message.
  static void stderr(String message) => verbose ? _loggerVerbose.stderr(message) : _logger.stderr(message);

  /// Print text to stdout, without a trailing newline.
  void write(String message) => verbose ? _loggerVerbose.write(message) : _logger.write(message);

  /// Print a character code to stdout, without a trailing newline.
  void writeCharCode(int charCode) =>
      verbose ? _loggerVerbose.writeCharCode(charCode) : _logger.writeCharCode(charCode);

  /// Print text to stdout, without a trailing newline.
  static Progress progress(String message) => verbose ? _loggerVerbose.progress(message) : _logger.progress(message);
}
