import 'package:structure_building_cli/command/icommand.dart';

import 'commands.dart';

class CommandGetter {
  static ICommand find(List<String> arguments) {
    String currentArgument = arguments.reduce((value, element) => '$value $element');
    return commandList.firstWhere((command) => command.command == currentArgument);
  }
}
