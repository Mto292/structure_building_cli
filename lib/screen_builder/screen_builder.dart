import 'dart:io';
import 'package:structure_building_cli/command/icommand.dart';

class ScreenBuilder extends ICommand {
  late String screenName;

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

      screenName = name.trim().toLowerCase();
      createFile(controllerFilePath);
      createFile(mainViewFilePath);
      createFile(viewFilePath);

      final mainViewFile = File(mainViewFilePath).openWrite();
      mainViewFile.write(mainViewFileContent);
      mainViewFile.close();

      final viewFile = File(viewFilePath).openWrite();
      viewFile.write(viewFileContent);
      viewFile.close();

      final controllerFile = File(controllerFilePath).openWrite();
      controllerFile.write(controllerFileContent);
      controllerFile.close();
    } catch (e) {
      stdout.addError(e.toString());
    }
  }

  void createFolder(String path) {
    Directory(path).createSync(recursive: true);
  }

  void createFile(String path) {
    File(path).createSync(recursive: true);
  }

  /// Paths

  String get controllerFolderPath => '$screenFolderName/$controllerFolderName';

  String get viewFolderPath => '$screenFolderName/$viewFolderName';

  String get controllerFilePath => '$controllerFolderPath/$controllerFileName';

  String get mainViewFilePath => '$screenFolderName/$mainViewFileName';

  String get viewFilePath => '$viewFolderPath/$viewFileName';

  /// folder name

  String get screenFolderName => '${screenName}_screen';

  String get viewFolderName => 'view';

  String get controllerFolderName => 'controller';

  /// file Name

  String get controllerFileName => '${screenName}_controller.dart';

  String get mainViewFileName => '${screenName}_screen.dart';

  String get viewFileName => '$screenName.dart';

  /// class Name

  String get controllerClassName => '${viewClassName}Controller';

  String get mainViewClassName => '${viewClassName}Screen';

  String get viewClassName => screenName[0].toUpperCase() + screenName.substring(1);

  /// Contents
  String get mainViewFileContent => """
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '$controllerFolderName/$controllerFileName';
import '$viewFolderName/$viewFileName';

class $mainViewClassName extends StatelessWidget {
  const $mainViewClassName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: $controllerClassName(),
      builder: (_) => const $viewClassName(),
    );
  }
}""";

  String get controllerFileContent => """
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class $controllerClassName extends GetxController {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  
  BuildContext get context => scaffoldKey.currentContext!;  
}""";

  String get viewFileContent => """
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../$controllerFolderName/$controllerFileName';
  
class $viewClassName extends StatelessWidget {
  const $viewClassName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<$controllerClassName>();
    return Scaffold(
      key: controller.scaffoldKey,
      appBar: AppBar(),
      body: Container(),
    );
  }
}""";
}
