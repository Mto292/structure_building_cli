import 'dart:io';

class ScreenBuilder {
  String name;

  ScreenBuilder.create(this.name) {
    name = name.trim().toLowerCase();
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
  }

  void createFolder(String path) {
    Directory(path).createSync(recursive: true);
  }

  void createFile(String path) {
    File(path).createSync(recursive: true);
  }

  ScreenBuilder(this.name);

  /// Paths

  String get controllerFolderPath => '$screenFolderName/$controllerFolderName';

  String get viewFolderPath => '$screenFolderName/$viewFolderName';

  String get controllerFilePath => '$controllerFolderPath/$controllerFileName';

  String get mainViewFilePath => '$screenFolderName/$mainViewFileName';

  String get viewFilePath => '$viewFolderPath/$viewFileName';

  /// folder name

  String get screenFolderName => '${name}_screen';

  String get viewFolderName => 'view';

  String get controllerFolderName => 'controller';

  /// file Name

  String get controllerFileName => '${name}_controller.dart';

  String get mainViewFileName => '${name}_screen.dart';

  String get viewFileName => '$name.dart';

  /// class Name

  String get controllerClassName => '${viewClassName}Controller';

  String get mainViewClassName => '${viewClassName}Screen';

  String get viewClassName => name[0].toUpperCase() + name.substring(1);

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
