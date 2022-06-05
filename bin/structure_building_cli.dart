import 'dart:io';

import 'package:structure_building_cli/structure_building_cli.dart';

Future<void> main(List<String> arguments) async {
  stdout.write('Please enter your screen name:');
  String? screenName = stdin.readLineSync();

  if (screenName == null) stderr.write('Screen name is null');
  ScreenBuilder.create(screenName!);
}