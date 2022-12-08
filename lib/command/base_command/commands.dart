import 'package:structure_building_cli/command/base_command/icommand.dart';
import 'package:structure_building_cli/command/commands/change_bundle_id.dart';
import 'package:structure_building_cli/command/commands/change_name.dart';
import 'package:structure_building_cli/command/commands/project_builder.dart';
import 'package:structure_building_cli/command/commands/screen_builder.dart';

List<ICommand> commandList = [
  ProjectBuilder(),
  ScreenBuilder(),
  ChangeName(),
  ChangeBundleId(),
];

String getAllCommandStr() {
  String error = 'You can use one this command:\n';
  for (var element in commandList) {
    error += '* ${element.command} \n';
  }
  return error;
}
