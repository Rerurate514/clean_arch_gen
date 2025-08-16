import 'dart:io';

import 'package:clean_arch_gen/src/const/fileTemplate/domain/factory.dart';
import 'package:clean_arch_gen/src/const/fileTemplate/domain/usecase.dart';
import 'package:clean_arch_gen/src/models/domain/abstract_repository.dart';
import 'package:clean_arch_gen/src/models/domain/entity.dart';
import 'package:clean_arch_gen/src/models/infrastructure/infrastructure.dart';
import 'package:clean_arch_gen/src/models/infrastructure/response.dart';
import 'package:clean_arch_gen/src/services/file/file_system_service.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:clean_arch_gen/src/const/fileTemplate/domain/domain.dart';
import 'package:clean_arch_gen/src/const/fileTemplate/domain/entity.dart';
import 'package:clean_arch_gen/src/const/fileTemplate/domain/repository.dart';
import 'package:clean_arch_gen/src/const/layers.dart';
import 'package:clean_arch_gen/src/models/domain/domain.dart';

class DomainFileCreater {
  final FileSystemService fileSystemService;

  DomainFileCreater(this.fileSystemService);

  void create(File yaml, Domain domain, Infrastructure infrastructure) {
    final layerDir = "${yaml.parent.path}/${Layers.domain.name}";

    for (final subDir in DomainLayer.values) {
      final path = File("$layerDir/${subDir.name}");
      switch (subDir) {
        case DomainLayer.entity:
          for (final entity in domain.entities) {
            fileSystemService.writeAsString(path, createEntity(entity));
          }
          break;

        case DomainLayer.repository:
          for (final pair in IterableZip([domain.entities, domain.repositories])) {
            fileSystemService.writeAsString(
              path,
              createRepository(pair[0] as Entity, pair[1] as AbstractRepository),
            );
          }
          break;

        case DomainLayer.usecase:
          for (final entity in domain.entities) {
            fileSystemService.writeAsString(path, createUsecase(entity));
          }
          break;
        case DomainLayer.factory:
          for (final pair in IterableZip([domain.entities, infrastructure.responses])) {
            fileSystemService.writeAsString(
              path,
              createDomainFactory(pair[0] as Entity, pair[1] as Response),
            );
          }
          break;
      }
    }
  }
}
