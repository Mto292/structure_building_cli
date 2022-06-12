import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:archive/archive_io.dart';
import 'package:structure_building_cli/change_bundle_id/change_bundle_id.dart';
import 'package:structure_building_cli/change_name/change_name.dart';
import 'package:structure_building_cli/command/icommand.dart';

String projectUrl = 'https://github.com/Mto292/flutter_base_project/archive/refs/heads/master.zip';

class ProjectBuilder extends ICommand {
  @override
  String get command => 'create project';

  @override
  String get errorMessage => '';

  @override
  Future<void> execute() async {
    stdout.write('Please enter the project name:');
    String appName = stdin.readLineSync()!;
    stdout.write('Please enter the bundle id:');
    String bundleId = stdin.readLineSync()!;
    stdout.write('downloading project...\n');
    http.Client client = http.Client();
    var req = await client.get(Uri.parse(projectUrl));
    stdout.write('unzipping...\n');
    final archive = ZipDecoder().decodeBytes(req.bodyBytes);
    stdout.write('please wait...\n');
    extractArchiveToDisk(archive, appName);
    String path;
    if (Platform.isMacOS || Platform.isLinux) {
      path = '$appName/flutter_base_project-master/';
    } else {
      path = '.\\$appName\\flutter_base_project-master';
    }
    await ChangeName(appName,path).execute();
    await ChangeBundleId(bundleId,path).execute();
  }
}
