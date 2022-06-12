abstract class ICommand {
  String get command;

  String get errorMessage;

  Future<void> execute();
}
