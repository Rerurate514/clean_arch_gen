import 'dart:io';

import 'package:clean_arch_gen/src/services/command/command_options.dart';

class CommandManager {
  void execute(List<String> arguments) async {
  if (arguments.isEmpty) {
    print('使用方法: dart run executor.dart <ファイルパス>');
    exit(1);
  }

  CommandOptions options = CommandOptions(
    command: '',
    args: arguments,
    yamlPath: '',
  );

  try {
    await options.execute();
  } catch (e) {
    print('エラー: $e');
    exit(1);
  }
  }
}
