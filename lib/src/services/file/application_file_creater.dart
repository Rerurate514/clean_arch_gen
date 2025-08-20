import 'dart:io';

import 'package:clean_arch_gen/src/const/fileTemplate/application/application.dart';
import 'package:clean_arch_gen/src/const/fileTemplate/application/extension.dart';
import 'package:clean_arch_gen/src/const/fileTemplate/application/usecase.dart';
import 'package:clean_arch_gen/src/const/layers.dart';
import 'package:clean_arch_gen/src/models/domain/domain.dart';
import 'package:clean_arch_gen/src/services/file/file_system_service.dart';
import 'package:clean_arch_gen/src/utils/recase.dart';

class ApplicationFileCreater {
  final FileSystemService fileSystemService;

  ApplicationFileCreater(this.fileSystemService);

  void create(File yaml, Domain domain) {
    final layerDir = "${yaml.parent.path}/${Layers.application.name}";

    for(final subDir in ApplicationLayer.values){
      final path = File("$layerDir/${subDir.name}");
      switch(subDir) {
        case ApplicationLayer.extension:
          createExtension();
          break;
        case ApplicationLayer.usecase:
          for (final usecase in domain.usecases) {
            final usecaseFile = File("${path.path}/${usecase.name.toLowerSnakeCase()}_impl.dart");
            fileSystemService.writeAsString(
              usecaseFile,
              createUsecase(usecase)
            );
          }
          break;
      }
    }
  }
}
