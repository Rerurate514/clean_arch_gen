import 'dart:io';

import 'package:clean_arch_gen/src/const/fileTemplate/domain/factory.dart';
import 'package:clean_arch_gen/src/const/fileTemplate/domain/usecase.dart';
import 'package:clean_arch_gen/src/models/domain/abstract_repository.dart';
import 'package:clean_arch_gen/src/models/domain/abstract_usecase.dart';
import 'package:clean_arch_gen/src/models/domain/entity.dart';
import 'package:clean_arch_gen/src/models/infrastructure/infrastructure.dart';
import 'package:clean_arch_gen/src/models/infrastructure/response.dart';
import 'package:clean_arch_gen/src/services/file/file_system_service.dart';
import 'package:clean_arch_gen/src/utils/recase.dart';
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
            final entityFile = File("${path.path}/${entity.name.toLowerSnakeCase()}.dart");
            fileSystemService.writeAsString(
              entityFile, 
              createEntity(entity)
            );
          }
          break;

        case DomainLayer.repository:
          for (final pair in IterableZip([domain.entities, domain.repositories])) {
            final entity = pair[0] as Entity;
            final repository = pair[1] as AbstractRepository;
            final repositoryFile = File("${path.path}/${repository.name.toLowerSnakeCase()}.dart");
            fileSystemService.writeAsString(
              repositoryFile,
              createRepository(entity, repository),
            );
          }
          break;

        case DomainLayer.usecase:
          for (final pair in IterableZip([domain.entities, domain.usecases])) {
            final entity = pair[0] as Entity;
            final usecase = pair[1] as AbstractUsecase;
            final usecaseFile = File("${path.path}/get_${usecase.name.toLowerSnakeCase()}.dart");
            fileSystemService.writeAsString(
              usecaseFile, 
              createUsecase(entity, usecase)
            );
          }
          break;
          
        case DomainLayer.factory:
          for (final pair in IterableZip([domain.entities, infrastructure.responses])) {
            final entity = pair[0] as Entity;
            final response = pair[1] as Response;
            final factoryFile = File("${path.path}/${entity.name.toLowerSnakeCase()}_factory.dart");
            fileSystemService.writeAsString(
              factoryFile,
              createDomainFactory(entity, response),
            );
          }
          break;
      }
    }
  }
}
