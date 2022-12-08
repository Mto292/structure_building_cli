import 'package:structure_building_cli/command/base_command/command_getter.dart';
import 'package:structure_building_cli/exception/http_error_exception.dart';

Future<void> main(List<String> arguments) async {
  final time = Stopwatch()..start();

  try {
    final command = CommandGetter.find(arguments);
    await command.execute();
  } on AppException catch (e) {
    print(e.toString());
  } catch (e) {
    print(AppException().toString());
  }

  time.stop();
  print('Time: ${time.elapsed.inMilliseconds} Milliseconds');
}
