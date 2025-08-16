import 'dart:io';

import 'package:clean_arch_gen/src/const/fileTemplate/application/application.dart';
import 'package:clean_arch_gen/src/const/fileTemplate/application/extension.dart';
import 'package:clean_arch_gen/src/const/fileTemplate/application/usecase.dart';
import 'package:clean_arch_gen/src/const/layers.dart';
import 'package:clean_arch_gen/src/models/domain/abstract_repository.dart';
import 'package:clean_arch_gen/src/models/domain/abstract_usecase.dart';
import 'package:clean_arch_gen/src/models/domain/domain.dart';
import 'package:clean_arch_gen/src/models/domain/entity.dart';
import 'package:clean_arch_gen/src/services/file/file_system_service.dart';
import 'package:clean_arch_gen/src/utils/recase.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

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
          for (final pair in IterableZip([domain.usecases, domain.repositories, domain.entities, ])) {
            final usecaseFile = File("${path.path}/get_${(pair[0] as AbstractUsecase).name.toLowerSnakeCase()}_usecase.dart");
            fileSystemService.writeAsString(
              usecaseFile, 
              createUsecase(pair[0] as AbstractUsecase, pair[1] as AbstractRepository, pair[2] as Entity)
            );
          }
          break;
      }
    }
  }
}
