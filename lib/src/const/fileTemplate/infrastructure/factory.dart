import 'package:clean_arch_gen/src/models/domain/entity.dart';
import 'package:clean_arch_gen/src/models/infrastructure/repository.dart';
import 'package:clean_arch_gen/src/models/infrastructure/response.dart';
import 'package:clean_arch_gen/src/utils/recase.dart';

String createInfrastructureFactory(Entity entity, Repository repository, Response response){
  return """
import '../domain/entity/${entity.name.toLowerSnakeCase()}.dart';
import '../domain/factory/${repository.name.toLowerSnakeCase()}_factory.dart';
import '../model/${response.name.toLowerSnakeCase()}.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '${entity.name.toLowerSnakeCase()}_factory_impl.g.dart';

@riverpod
${entity.name}Factory ${entity.name.toLowerCamelCase()}FactoryImpl(Ref ref) {
  return ${entity.name}FactoryImpl();
}

class ${entity.name}FactoryImpl implements ${entity.name}Factory {
  @override
  ${entity.name} create() {
    return ${entity.name}();
  }

  @override
  ${entity.name} createFromModel(${response.name} response) {
    return ${entity.name}();
  }
}

""";
}
