import 'package:ansicolor/ansicolor.dart';

// ignore_for_file: avoid_print

// ignore: avoid_classes_with_only_static_members
class LogService {
  static final AnsiPen _penError = AnsiPen()..red(bold: true);
  static final AnsiPen _penSuccess = AnsiPen()..green(bold: true);
  static final AnsiPen _penInfo = AnsiPen()..yellow(bold: true);
  static final AnsiPen _penDivider = AnsiPen()..blue();

  static void error(String msg) {
    const sep = '\n';
    msg = '✖  ${_penError(msg.trimRight())}';
    msg = sep + msg + sep;
    print(msg);
  }

  static void success(String msg) {
    const sep = '\n';
     msg = '✓  ${_penSuccess(msg.trimRight())}';
     msg = sep + msg + sep;
    print(msg);
  }

  static void info(String msg) {
    const sep = '\n';
    msg = _penInfo(msg.trimRight());
    msg = sep + msg + sep;
    print(msg);
  }

  static void divider() {
    String msg = '----------------------------------------------------------------';
    msg = _penDivider(msg);
    print(msg);
  }
}
