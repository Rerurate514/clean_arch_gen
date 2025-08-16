import 'dart:io';
import 'package:clean_arch_gen/src/services/yaml/yaml_analyzer.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'command_options.freezed.dart';
part 'command_options.g.dart';

@freezed
sealed class CommandOptions with _$CommandOptions {
  const factory CommandOptions({
    required String command,
    required List<String> args,
    required String yamlPath
  }) = _CommandOptions;

  factory CommandOptions.fromJson(Map<String, dynamic> json) => _$CommandOptionsFromJson(json);
}

extension CommandOptionsEx on CommandOptions {
  String parse() {
    for (int i = 0; i < args.length; i++) {
      String arg = args[i];
      switch (arg) {
        case '-d':
        case '--directory':
          if (i + 1 < args.length) {
            return args[i + 1];
          }
          break;
      }
    }
    return args.isNotEmpty ? args[0] : '';
  }

  List<String> getExecutionCommand() {
    String filePath = parse();
    if (filePath.isEmpty) return [];
    
    String extension = filePath.split('.').last.toLowerCase();
    switch (extension) {
      case 'yaml':
      case 'yml':
        return ['type', filePath];
      default: return Platform.isWindows ? [filePath] : ['./${filePath.split('/').last}'];
    }
  }

  Future<void> execute() async {
    String filePath = parse();
    if (filePath.isEmpty) {
      throw Exception('ファイルパスが指定されていません');
    }

    File file = File(filePath);
    if (!await file.exists()) {
      throw Exception('ファイルが見つかりません: $filePath');
    }

    List<String> command = getExecutionCommand();
    if (command.isEmpty) {
      throw Exception('実行コマンドを生成できません');
    }

    final YamlAnalyzer yamlAnalyzer = YamlAnalyzer();
    yamlAnalyzer.analyze(file);
  }
}
