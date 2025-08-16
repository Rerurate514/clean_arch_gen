import 'dart:io';

import 'package:clean_arch_gen/src/const/fileTemplate/infrastructure/datasource.dart';
import 'package:clean_arch_gen/src/const/fileTemplate/infrastructure/factory.dart';
import 'package:clean_arch_gen/src/const/fileTemplate/infrastructure/infrastructure.dart';
import 'package:clean_arch_gen/src/const/fileTemplate/infrastructure/model.dart';
import 'package:clean_arch_gen/src/const/fileTemplate/infrastructure/repository.dart';
import 'package:clean_arch_gen/src/const/layers.dart';
import 'package:clean_arch_gen/src/models/domain/domain.dart';
import 'package:clean_arch_gen/src/models/domain/entity.dart';
import 'package:clean_arch_gen/src/models/infrastructure/datasource.dart';
import 'package:clean_arch_gen/src/models/infrastructure/infrastructure.dart';
import 'package:clean_arch_gen/src/models/infrastructure/repository.dart';
import 'package:clean_arch_gen/src/models/infrastructure/response.dart';
import 'package:clean_arch_gen/src/services/file/file_system_service.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

class InfrastructureFileCreater {
  final FileSystemService fileSystemService;

  InfrastructureFileCreater(this.fileSystemService);

  void create(File yaml, Infrastructure infra, Domain domain) {
    final layerDir = "${yaml.parent}/${Layers.infrastructure}/";

    for (final subDir in InfrastructureLayer.values) {
      final path = File("$layerDir/${subDir.name}");
      switch (subDir) {
        case InfrastructureLayer.datasource:
          for (final pair in IterableZip([infra.responses, infra.dataSources])) {
            fileSystemService.writeAsString(
              path,
              createDataSource(pair[0] as Response, pair[1] as DataSource),
            );
          }
          break;
        case InfrastructureLayer.factory:
          for (final pair in IterableZip([domain.entities, infra.repositories, infra.responses])) {
            fileSystemService.writeAsString(
              path,
              createInfrastructureFactory(
                  pair[0] as Entity, pair[1] as Repository, pair[2] as Response),
            );
          }
          break;
        case InfrastructureLayer.model:
          for (final pair in IterableZip([infra.responses])) {
            fileSystemService.writeAsString(path, createModel(pair[0]));
          }
          break;
        case InfrastructureLayer.repositoy:
          for (final pair in IterableZip([domain.entities, infra.repositories, infra.dataSources])) {
            fileSystemService.writeAsString(
              path,
              createRepository(pair[0] as Entity, pair[1] as Repository, pair[2] as DataSource),
            );
          }
          break;
      }
    }
  }
}
