import 'package:structure_building_cli/command/command_getter.dart';

Future<void> main(List<String> arguments) async {
  var time = Stopwatch();
  time.start();

  final command = CommandGetter.find(arguments);
  await command.execute();

  time.stop();
  print('Time: ${time.elapsed.inMilliseconds} Milliseconds');
}
