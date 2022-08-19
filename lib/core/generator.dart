import 'package:aveoauth/command/command.dart';
import 'package:aveoauth/command/command_list.dart';
import 'package:aveoauth/command/command_parent.dart';

class AuthCli {
  AuthCli(this._arguments) {
    _instance = this;
  }

  final List<String> _arguments;

  static AuthCli? _instance;
  static AuthCli? get to => _instance;

  static List<String> get arguments => to!._arguments;

  Command findCommand() => _findCommand(0, commands);

  Command _findCommand(int currentIndex, List<Command> commands) {
    try {
      final currentArgument = arguments[currentIndex].split(':').first;

      var command = commands.firstWhere(
          (command) =>
              command.commandName == currentArgument ||
              command.alias.contains(currentArgument),
          orElse: () => ErrorCommand('command not found'));
      if (command.children.isNotEmpty) {
        if (command is CommandParent) {
          command = _findCommand(++currentIndex, command.children);
        } else {
          var childrenCommand = _findCommand(++currentIndex, command.children);
          if (childrenCommand is! ErrorCommand) {
            command = childrenCommand;
          }
        }
      }
      return command;
      // ignore: avoid_catching_errors
    } on RangeError catch (e) {
      return ErrorCommand(e.message);
    } on Exception catch (_) {
      rethrow;
    }
  }
}

class ErrorCommand extends Command {
  @override
  String get commandName => 'onerror';
  String error;
  ErrorCommand(this.error);
  @override
  Future<void> execute() async {}
}

class NotFoundCommand extends Command {
  @override
  String get commandName => 'Not Found Command';

  @override
  Future<void> execute() async {
    //Command findCommand() => _findCommand(0, commands);
  }
}
