import 'dart:io';
import 'package:structure_building_cli/command/base_command/icommand.dart';

class ChangeName extends ICommand {
  String? appName;

  String? path;

  late String androidManifestPath;

  late String iosInfoPlistPath;

  ChangeName([this.appName, this.path]) {
    if (Platform.isMacOS || Platform.isLinux) {
      androidManifestPath = '${path ?? ''}android/app/src/main/AndroidManifest.xml';
      iosInfoPlistPath = '${path ?? ''}ios/Runner/Info.plist';
    } else {
      androidManifestPath = '${path ?? '.'}\\android\\app\\src\\main\\AndroidManifest.xml';
      iosInfoPlistPath = '${path ?? '.'}\\ios\\Runner\\Info.plist';
    }
  }

  @override
  String get command => 'change app name';

  @override
  String get errorMessage => '';

  @override
  Future<void> execute() async {
    if (appName == null) {
      stdout.write('Please enter the project name:');
      appName = stdin.readLineSync()!;
    }
    changeAndroidName();
    changeIosName();
  }

  void changeIosName() {
    try {
      List line = readAndSplit(iosInfoPlistPath);
      for (var i = 0; i < line.length; i++) {
        if (line[i].contains('CFBundleName')) {
          line[i + 1] = """    <string>$appName</string>""";
          break;
        }
      }
      File(iosInfoPlistPath).writeAsStringSync(line.join('\n'));
    } catch (e) {
      print(e.toString());
      print(' ❌ ❌ ❌ change Ios app name failed ❌ ❌ ❌ ');
    }
  }

  void changeAndroidName() {
    try {
      final line = readAndSplit(androidManifestPath);
      for (var i = 0; i < line.length; i++) {
        if (line[i].contains('android:label=')) {
          line[i] = line[i].replaceFirst(RegExp(r'"([^"]*)"'), '"$appName"');
          break;
        }
      }
      File(androidManifestPath).writeAsStringSync(line.join('\n'));
    } catch (e) {
      print(e.toString());
      print(' ❌ ❌ ❌ change Android app name failed ❌ ❌ ❌ ');
    }
  }

  List<String> readAndSplit(String path) {
    String text = File(path).readAsStringSync();
    return text.split('\n');
  }
}
