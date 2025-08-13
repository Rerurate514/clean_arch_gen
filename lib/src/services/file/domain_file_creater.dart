import 'dart:io';

import 'package:clean_arch_gen/src/const/fileTemplate/domain/factory.dart';
import 'package:clean_arch_gen/src/const/fileTemplate/domain/usecase.dart';
import 'package:clean_arch_gen/src/models/domain/abstract_repository.dart';
import 'package:clean_arch_gen/src/models/domain/entity.dart';
import 'package:clean_arch_gen/src/models/infrastructure/infrastructure.dart';
import 'package:clean_arch_gen/src/models/infrastructure/response.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:clean_arch_gen/src/const/fileTemplate/domain/domain.dart';
import 'package:clean_arch_gen/src/const/fileTemplate/domain/entity.dart';
import 'package:clean_arch_gen/src/const/fileTemplate/domain/repository.dart';
import 'package:clean_arch_gen/src/const/layers.dart';
import 'package:clean_arch_gen/src/models/domain/domain.dart';
import 'package:clean_arch_gen/src/services/file/directory_creater.dart';

class DomainFileCreater {
  final DirectoryCreater directoryCreater;

  DomainFileCreater(this.directoryCreater);

  void create(File yaml, Domain domain, Infrastructure infrastructure) {
    final layerDir = "${yaml.parent}/${Layers.domain}/";

    for(final subDir in DomainLayer.values){
      final path = File("$layerDir/${subDir.name}");
      switch(subDir) {
        case DomainLayer.entity:
          for(final entity in domain.entities) {
            path.writeAsString(
              createEntity(entity)
            );
          }
          break;
        
        case DomainLayer.repositoy:
          for (final pair in IterableZip([domain.entities, domain.repositories])) {
            path.writeAsString(
              createRepository(pair[0] as Entity, pair[1] as AbstractRepository)
            );
          }
          break;
        
        case DomainLayer.usecase:
          for(final entity in domain.entities) {
            path.writeAsString(
              createUsecase(entity)
            );
          }
          break;
        case DomainLayer.factory:
          for (final pair in IterableZip([domain.entities, infrastructure.responses])) {
            path.writeAsString(
              createDomainFactory(pair[0] as Entity, pair[1] as Response)
            );
          }
          break;
      }
    }
  }
}
