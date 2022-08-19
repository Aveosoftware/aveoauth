import 'package:aveoauth/command/args_mixin.dart';

abstract class Command with ArgsMixin {
  String get commandName;

  List<String> get alias => [];

  /// execute command
  Future<void> execute();

  /// children command
  List<Command> get children => [];
}
