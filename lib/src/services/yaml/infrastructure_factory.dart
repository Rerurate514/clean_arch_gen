import 'package:clean_arch_gen/src/models/infrastructure/datasource.dart';
import 'package:clean_arch_gen/src/models/infrastructure/infrastructure.dart';
import 'package:clean_arch_gen/src/models/infrastructure/response.dart';
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
      .cast<String>()
      .map((dataSourceName) => DataSource(name: dataSourceName))
      .toList();
  }
}
