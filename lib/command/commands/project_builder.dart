import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:archive/archive_io.dart';
import 'package:structure_building_cli/command/base_command/icommand.dart';
import 'package:structure_building_cli/command/commands/change_bundle_id.dart';
import 'package:structure_building_cli/command/commands/change_name.dart';
import 'package:structure_building_cli/constants/const.dart';

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
    print('downloading project...\n');
    http.Client client = http.Client();
    var req = await client.get(Uri.parse(projectUrl));
    print('unzipping...\n');
    final archive = ZipDecoder().decodeBytes(req.bodyBytes);
    print('please wait...\n');
    await extractArchiveToDisk(archive, Directory.current.path);
    String path;
    if (Platform.isMacOS || Platform.isLinux) {
      path = '$baseProjectName/';
    } else {
      path = '.\\$baseProjectName';
    }
    await ChangeName(appName, path).execute();
    await ChangeBundleId(bundleId, path).execute();
    await renameDirectory(baseProjectName, appName);
  }

  Future<void> renameDirectory(String from, String to) async {
    final fromDir = Directory(from);
    final toDir = Directory(to);

    if (await toDir.exists()) {
      await toDir.delete(recursive: true);
    }

    await fromDir.rename(to);
  }
}
