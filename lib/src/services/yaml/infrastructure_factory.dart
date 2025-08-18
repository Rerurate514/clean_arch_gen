import 'package:clean_arch_gen/src/models/infrastructure/datasource.dart';
import 'package:clean_arch_gen/src/models/infrastructure/infrastructure.dart';
import 'package:clean_arch_gen/src/models/infrastructure/response.dart';
import 'package:clean_arch_gen/src/models/utils/method.dart';
import 'package:clean_arch_gen/src/models/utils/params.dart';
import 'package:clean_arch_gen/src/utils/paths.dart';
import 'package:yaml/yaml.dart';

class InfrastructureFactory {
  Infrastructure createInfrastructure(YamlMap yaml){
    return Infrastructure(
      responses: _createResponses(yaml), 
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

  List<DataSource> _createDatasource(YamlMap yaml) {
    final dataSourceYaml = yaml[Paths.infrastructure.path][Paths.infrastructureDataSources.path] as YamlList;
    return dataSourceYaml
      .cast<YamlMap>()
      .expand(_extractDatasourceFromYaml)
      .toList();
  }

  Iterable<DataSource> _extractDatasourceFromYaml(YamlMap datasourceYaml) {
    return datasourceYaml.keys.map((datasourceName) {
      final repositoryData = datasourceYaml[datasourceName];
      final methods = _createMethods(repositoryData[Paths.methods.path]);
      return DataSource(name: datasourceName, methods: methods);
    });
  }

    List<Method> _createMethods(YamlList methodsYaml) {
    return methodsYaml
        .cast<YamlMap>()
        .expand(_extractMethodsFromYaml)
        .toList();
  }

  Iterable<Method> _extractMethodsFromYaml(YamlMap methodsMap) {
    return methodsMap.keys.map((methodName) {
      final methodData = methodsMap[methodName];
      final returns = methodData[Paths.returns.path] as String;
      final params = _createParams(methodData[Paths.params.path]);
      final isAsync = methodData[Paths.isAsync.path] ?? false;
      return Method(name: methodName, returns: returns, params: params, isAsync: isAsync);
    });
  }

  List<Params> _createParams(YamlList paramsYaml) {
    return paramsYaml
        .cast<YamlMap>()
        .expand(_extractParamsFromYaml)
        .toList();
  }

  Iterable<Params> _extractParamsFromYaml(YamlMap paramsMap) {
    return paramsMap.keys
        .map((paramName) => Params(name: paramName, type: paramsMap[paramName]));
  }
}
