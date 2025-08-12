import 'package:clean_arch_gen/src/models/infrastructure/datasource.dart';
import 'package:clean_arch_gen/src/models/infrastructure/dependence.dart';
import 'package:clean_arch_gen/src/models/infrastructure/infrastructure.dart';
import 'package:clean_arch_gen/src/models/infrastructure/repository.dart';
import 'package:clean_arch_gen/src/models/infrastructure/response.dart';
import 'package:clean_arch_gen/src/utils/paths.dart';
import 'package:yaml/yaml.dart';

class InfrastructureFactory {
  Infrastructure createInfrastructure(YamlMap yaml){
    return Infrastructure(
      responses: _createResponses(yaml), 
      repositories: _createRepositories(yaml), 
      dataSources: _createDatasource(yaml)
    );
  }

  List<Response> _createResponses(YamlMap yaml) {
    final resoponseYaml = yaml[Paths.infrastructure.path][Paths.infrastructureResponses.path] as YamlList;
    return resoponseYaml
      .cast<String>()
      .map((responseName) => Response(name: responseName))
      .toList();
  }

  List<Repository> _createRepositories(YamlMap yaml) {
    final repositoryYaml = yaml[Paths.infrastructure.path][Paths.infrastructureRepositories.path] as YamlList;
    return repositoryYaml
      .cast<YamlMap>()
      .expand(_extractRepositoriesFromYaml)
      .toList();
  }

  Iterable<Repository> _extractRepositoriesFromYaml(YamlMap repositoryMap){
    return repositoryMap.keys.map((repositoryName) {
      final repositoryData = repositoryMap[repositoryName];
      final implements = repositoryMap[repositoryName][Paths.implements.path];
      final dependencies = _createDependencies(repositoryData[Paths.dependencies.path]);
      return Repository(name: repositoryName, implements: implements, dependencies: dependencies);
    });
  }

  List<Dependence> _createDependencies(YamlList dependenciesYaml) {
    return dependenciesYaml
      .cast<String>()
      .map((dependenceName) => Dependence(name: dependenceName))
      .toList();
  }

  // Iterable<Dependence> _extractDependenciesFromYaml(YamlMap dependenciesYaml) {
  //   return dependenciesYaml.keys.map((dependenceName) {
  //     return Dependence(name: dependenceName);
  //   });
  // }

  List<DataSource> _createDatasource(YamlMap yaml) {
    final dataSourceYaml = yaml[Paths.infrastructure.path][Paths.infrastructureDataSources.path] as YamlList;
    return dataSourceYaml
      .cast<String>()
      .map((dataSourceName) => DataSource(name: dataSourceName))
      .toList();
  }

  // Iterable<DataSource> _extractDataSourceFromYaml(YamlMap datasourceYaml) {
  //   return datasourceYaml.keys.map((datasourceName) {
  //     return DataSource(name: datasourceName);
  //   });
  // }
}
