import 'dart:io';
import 'package:structure_building_cli/command/base_command/icommand.dart';


class ChangeBundleId extends ICommand {
  String? bundleId;

  String? path;

  late String androidAppBuildGradlePath;

  late String iosProjectPbxprojPath;

  ChangeBundleId([this.bundleId, this.path]) {
    if (Platform.isMacOS || Platform.isLinux) {
      androidAppBuildGradlePath = '${path ?? ''}android/app/build.gradle';
      iosProjectPbxprojPath = '${path ?? ''}ios/Runner.xcodeproj/project.pbxproj';
    } else {
      androidAppBuildGradlePath = '${path ?? '.'}\\android\\app\\build.gradle';
      iosProjectPbxprojPath = '${path ?? '.'}\\ios\\Runner.xcodeproj\\project.pbxproj';
    }
  }

  @override
  String get command => 'change bundle id';

  @override
  String get errorMessage => '';

  @override
  Future<void> execute() async {
    if (bundleId == null) {
      stdout.write('Please enter the bundle id:');
      bundleId = stdin.readLineSync()!;
    }
    _changeAndroidBundleId();
    _changeIosBundleId();
  }

  void _changeIosBundleId() {
    try {
      List line = readAndSplit(iosProjectPbxprojPath);
      for (var i = 0; i < line.length; i++) {
        if (line[i].contains('PRODUCT_BUNDLE_IDENTIFIER')) {
          line[i] = """				PRODUCT_BUNDLE_IDENTIFIER = $bundleId; """;
          break;
        }
      }
      File(iosProjectPbxprojPath).writeAsStringSync(line.join('\n'));
    } catch (e) {
      print(e.toString());
      print(' ❌ ❌ ❌ change Ios BundleId failed ❌ ❌ ❌ ');
    }
  }

  void _changeAndroidBundleId() {
    try {
      List line = readAndSplit(androidAppBuildGradlePath);
      for (var i = 0; i < line.length; i++) {
        if (line[i].contains('applicationId')) {
          line[i] = """        applicationId "$bundleId" """;
          break;
        }
      }
      File(androidAppBuildGradlePath).writeAsStringSync(line.join('\n'));
    } catch (e) {
      print(e.toString());
      print(' ❌ ❌ ❌ change Android BundleId failed ❌ ❌ ❌ ');
    }
  }

  List<String> readAndSplit(String path) {
    String text = File(path).readAsStringSync();
    return text.split('\n');
  }
}
