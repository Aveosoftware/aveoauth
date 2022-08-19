import 'package:aveoauth/core/generator.dart';

void main(List<String> arguments) async {
  var time = Stopwatch();
  time.start();

  final command = AuthCli(arguments).findCommand();
  await command.execute();

  time.stop();
}
