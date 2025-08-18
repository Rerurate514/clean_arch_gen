import 'package:clean_arch_gen/src/models/domain/abstract_repository.dart';
import 'package:clean_arch_gen/src/models/domain/abstract_usecase.dart';
import 'package:clean_arch_gen/src/models/domain/domain.dart';
import 'package:clean_arch_gen/src/models/domain/entity.dart';
import 'package:clean_arch_gen/src/models/utils/class_field.dart';
import 'package:clean_arch_gen/src/models/utils/method.dart';
import 'package:clean_arch_gen/src/models/utils/params.dart';
import 'package:clean_arch_gen/src/utils/paths.dart';
import 'package:yaml/yaml.dart';

class DomainFactory {
  Domain createDomain(YamlMap yaml) {
    return Domain(
      entities: _createEntities(yaml), 
      usecases: _createUseCases(yaml), 
      repositories: _createRepositories(yaml)
    );
  }

  List<Entity> _createEntities(YamlMap yaml) {
    final entitiesYaml = yaml[Paths.domain.path][Paths.domainEntities.path] as YamlList;
    return entitiesYaml
        .cast<YamlMap>()
        .expand(_extractEntitiesFromYaml)
        .toList();
  }

  Iterable<Entity> _extractEntitiesFromYaml(YamlMap entityYaml) {
    return entityYaml.keys.map((entityName) {
      final entityData = entityYaml[entityName];
      final classFields = _createClassFields(entityData[Paths.fields.path]);
      return Entity(name: entityName, classFields: classFields);
    });
  }

  List<ClassField> _createClassFields(YamlMap fieldsYaml) {
    return fieldsYaml.keys
        .map((name) => ClassField(name: name, type: fieldsYaml[name]))
        .toList();
  }

  List<AbstractUsecase> _createUseCases(YamlMap yaml) {print(yaml[Paths.domain.path][Paths.domainUseCases.path]);
    final usecaseYaml = yaml[Paths.domain.path][Paths.domainUseCases.path] as YamlList;
    return usecaseYaml
        .cast<YamlMap>()
        .expand(_extractUseCasesFromYaml)
        .toList();
  }

  Iterable<AbstractUsecase> _extractUseCasesFromYaml(YamlMap usecaseYaml) {
    return usecaseYaml.keys.map((usecaseName) {
      final usecaseData = usecaseYaml[usecaseName];
      final method = _createMethodsForUsecase(usecaseData[Paths.method.path]);
      return AbstractUsecase(name: usecaseName, method: method);
    });
  }

  Method _createMethodsForUsecase(YamlMap methodYaml) {
    final methodName = "execute";
    final returns = methodYaml[Paths.returns.path] as String;
    final params = _createParams(methodYaml[Paths.params.path] as YamlList);
    final isAsync = methodYaml[Paths.isAsync.path] ?? false;
    return Method(name: methodName, returns: returns, params: params, isAsync:  isAsync);
  }

  List<AbstractRepository> _createRepositories(YamlMap yaml) {
    final repositoryYaml = yaml[Paths.domain.path][Paths.domainRepositories.path] as YamlList;
    return repositoryYaml
        .cast<YamlMap>()
        .expand(_extractRepositoriesFromYaml)
        .toList();
  }

  Iterable<AbstractRepository> _extractRepositoriesFromYaml(YamlMap repositoryYaml) {
    return repositoryYaml.keys.map((repositoryName) {
      final repositoryData = repositoryYaml[repositoryName];
      final methods = _createMethods(repositoryData[Paths.methods.path]);
      return AbstractRepository(name: repositoryName, methods: methods);
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
