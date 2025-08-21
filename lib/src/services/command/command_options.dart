import 'dart:io';
import 'package:clean_arch_gen/src/services/file/application_file_creater.dart';
import 'package:clean_arch_gen/src/services/file/directory_creater.dart';
import 'package:clean_arch_gen/src/services/file/domain_file_creater.dart';
import 'package:clean_arch_gen/src/services/file/file_system_service.dart';
import 'package:clean_arch_gen/src/services/file/infrastructure_file_creater.dart';
import 'package:clean_arch_gen/src/services/file/presentation_file_creater.dart';
import 'package:clean_arch_gen/src/services/yaml/yaml_analyzer.dart';
import 'package:clean_arch_gen/src/utils/exceptions/file_not_found_exception.dart';
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
  (String, String?, bool) parse() {
    String? outputFilePath;
    bool forceOverwrite = false;

    List<String> remainingArgs = [];
    for (int i = 0; i < args.length; i++) {
      String arg = args[i];
      switch (arg) {
        case '-d':
        case '--directory':
          if (i + 1 < args.length) {
            return (args[i + 1], outputFilePath, forceOverwrite);
          }
          break;
        case '-o':
        case '--output':
          if (i + 1 < args.length) {
            outputFilePath = args[i + 1];
            i++;
          }
          break;
        case '-f':
        case '--force':
          forceOverwrite = true;
          break;
        default:
          remainingArgs.add(arg);
          break;
      }
    }

    return (remainingArgs.isNotEmpty ? remainingArgs[0] : '', outputFilePath, forceOverwrite);
  }

  Future<void> execute() async {
    final (String filePath, String? outputFilePath, bool forceOverwrite) = parse();

    if (filePath.isEmpty) {
      throw FileNotFoundException(message: 'ファイルパスが指定されていません');
    }

    File file = File(filePath);
    if (!await file.exists()) {
      throw FileNotFoundException(message: 'ファイルが見つかりません: $filePath');
    }

    if (outputFilePath != null) {
      final outputDirectory = Directory(outputFilePath);
      if (forceOverwrite && await outputDirectory.exists()) {
        print('既存のディレクトリを削除しています: ${outputDirectory.path}');
        await outputDirectory.delete(recursive: true);
      }

      if (!forceOverwrite && await outputDirectory.exists()) {
        throw Exception('出力ディレクトリが既に存在します。上書きするには --force オプションを使用してください: ${outputDirectory.path}');
      }
    }

    final YamlAnalyzer yamlAnalyzer = YamlAnalyzer();
    final layersModel = await yamlAnalyzer.analyze(file);

    final FileSystemService fileSystemService = RealFileSystemService();

    final DirectoryCreater directoryCreater = DirectoryCreater(
      fileSystemService: fileSystemService, 
      yaml: file
    );

    await directoryCreater.createProject();

    final applicationFileCreater = ApplicationFileCreater(fileSystemService);
    final domainFileCreater = DomainFileCreater(fileSystemService);
    final infrastructureFileCreater = InfrastructureFileCreater(fileSystemService);
    final presentationFileCreater = PresentationFileCreater(fileSystemService);

    applicationFileCreater.create(file, layersModel.domain);
    domainFileCreater.create(file, layersModel.domain, layersModel.infrastructure);
    infrastructureFileCreater.create(file, layersModel.domain, layersModel.infrastructure);
    presentationFileCreater.create(file, layersModel.domain, layersModel.presentation);

    // TODO
    // 必要に応じて、yamlAnalyzerの結果をoutputFileに書き込むロジックを追加
    // 例:
    // if (outputFile != null) {
    //   await outputFile.writeAsString(yamlAnalyzer.result.toString());
    //   print('解析結果を ${outputFile.path} に出力しました。');
    // }
  }
}
