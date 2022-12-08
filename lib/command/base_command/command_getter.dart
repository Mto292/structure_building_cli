import 'package:structure_building_cli/command/base_command/commands.dart';
import 'package:structure_building_cli/command/base_command/icommand.dart';

import '../../exception/http_error_exception.dart';

class CommandGetter {
  static ICommand find(List<String> arguments) {
    if (arguments.isEmpty) throw NotFountCommand();
    String currentArgument = arguments.reduce((value, element) => '$value $element');
    return commandList.firstWhere(
      (command) => command.command == currentArgument,
      orElse: () => throw NotFountCommand(),
    );
  }
}
