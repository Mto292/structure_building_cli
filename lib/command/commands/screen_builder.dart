import 'dart:io';
import 'package:structure_building_cli/command/base_command/icommand.dart';
import 'package:structure_building_cli/constants/paths_const.dart';

class ScreenBuilder extends ICommand {
  @override
  String get command => 'create screen';

  @override
  String get errorMessage => throw UnimplementedError();

  @override
  Future<void> execute() async {
    try {
      stdout.write('Please enter the screen name:');
      String? name = stdin.readLineSync();
      stdout.write(name);

      while (name == null || name == '') {
        stdout.write('Please enter the screen name:');
        name = stdin.readLineSync();
      }

      final paths = PathsConst(name.trim().toLowerCase());
      createFile(paths.controllerFilePath);
      createFile(paths.mainViewFilePath);
      createFile(paths.viewFilePath);

      final mainViewFile = File(paths.mainViewFilePath).openWrite();
      mainViewFile.write(paths.mainViewFileContent);
      mainViewFile.close();

      final viewFile = File(paths.viewFilePath).openWrite();
      viewFile.write(paths.viewFileContent);
      viewFile.close();

      final controllerFile = File(paths.controllerFilePath).openWrite();
      controllerFile.write(paths.controllerFileContent);
      controllerFile.close();
    } catch (e) {
      stdout.addError(e.toString());
    }
  }

  void createFile(String path) => File(path).createSync(recursive: true);
}
