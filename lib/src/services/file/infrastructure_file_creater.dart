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
import 'package:clean_arch_gen/src/utils/recase.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

class InfrastructureFileCreater {
  final FileSystemService fileSystemService;

  InfrastructureFileCreater(this.fileSystemService);

  void create(File yaml, Infrastructure infra, Domain domain) {
    final layerDir = "${yaml.parent.path}/${Layers.infrastructure.name}";

    for (final subDir in InfrastructureLayer.values) {
      final path = File("$layerDir/${subDir.name}");
      switch (subDir) {
        case InfrastructureLayer.datasource:
          for (final pair in IterableZip([infra.responses, infra.dataSources])) {
            final response = pair[0] as Response;
            final dataSource = pair[1] as DataSource;
            final dataSourceFile = File("${path.path}/${dataSource.name.toLowerSnakeCase()}.dart");
            fileSystemService.writeAsString(
              dataSourceFile,
              createDataSource(response, dataSource),
            );

            final dataSourceImplFile = File("${path.path}/${dataSource.name.toLowerSnakeCase()}_impl.dart");
            fileSystemService.writeAsString(
              dataSourceImplFile,
              createDataSourceImpl(response, dataSource),
            );
          }
          break;
        case InfrastructureLayer.factory:
          for (final pair in IterableZip([domain.entities, infra.repositories, infra.responses])) {
            final entity = pair[0] as Entity;
            final repository = pair[1] as Repository;
            final response = pair[2] as Response;
            final factoryFile = File("${path.path}/${entity.name.toLowerSnakeCase()}_factory_impl.dart");
            fileSystemService.writeAsString(
              factoryFile,
              createInfrastructureFactory(entity, repository, response),
            );
          }
          break;
        case InfrastructureLayer.model:
          for (final response in infra.responses) {
            final modelFile = File("${path.path}/${response.name.toLowerSnakeCase()}_response.dart");
            fileSystemService.writeAsString(
              modelFile, 
              createModel(response)
            );
          }
          break;
        case InfrastructureLayer.repository:
          for (final pair in IterableZip([domain.entities, infra.repositories, infra.dataSources])) {
            final entity = pair[0] as Entity;
            final repository = pair[1] as Repository;
            final dataSource = pair[2] as DataSource;
            final repositoryFile = File("${path.path}/${repository.name.toLowerSnakeCase()}_impl.dart");
            fileSystemService.writeAsString(
              repositoryFile,
              createRepository(entity, repository, dataSource),
            );
          }
          break;
      }
    }
  }
}
