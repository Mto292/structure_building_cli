
import 'package:structure_building_cli/command/icommand.dart';

import '../change_bundle_id/change_bundle_id.dart';
import '../change_name/change_name.dart';
import '../project_builder/project_builder.dart';
import '../screen_builder/screen_builder.dart';

List<ICommand> commandList = [
  ProjectBuilder(),
  ScreenBuilder(),
  ChangeName(),
  ChangeBundleId(),
];