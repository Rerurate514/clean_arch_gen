import 'package:clean_arch_gen/src/models/domain/abstract_repository.dart';
import 'package:clean_arch_gen/src/models/domain/entity.dart';
import 'package:clean_arch_gen/src/models/infrastructure/datasource.dart';
import 'package:clean_arch_gen/src/utils/recase.dart';

String createRepository(Entity entity, AbstractRepository repository, DataSource datasource){
  final methods = repository.methods
    .map((method) {
      final params = method.params
          .map((param) => "${param.type} ${param.name}")
          .join(', ');
      return """
  @override
  ${method.returns} ${method.name}($params)${method.isAsync ? " async" : ""} {
    
  }
""";
    })
    .join('\n\n');
  
  return """
import '../../domain/entity/${entity.name.toLowerSnakeCase()}.dart';
import '../../domain/factory/${entity.name.toLowerSnakeCase()}_factory.dart';
import '../../domain/repository/${repository.name.toLowerSnakeCase()}.dart';
import '../datasource/${datasource.name.toLowerSnakeCase()}.dart';
import '../datasource/${datasource.name.toLowerSnakeCase()}_impl.dart';
import '../factory/${entity.name.toLowerSnakeCase()}_factory_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '${repository.name.toLowerSnakeCase()}_impl.g.dart';

@riverpod
${repository.name} ${repository.name.toLowerCamelCase()}Impl(Ref ref) {
  return ${repository.name}Impl(
    ${datasource.name.toLowerCamelCase()}: ref.watch(${datasource.name.toLowerCamelCase()}ImplProvider), 
    ${entity.name.toLowerCamelCase()}Factory: ref.watch(${entity.name.toLowerCamelCase()}FactoryImplProvider)
  );
}

class ${repository.name}Impl implements ${repository.name} {
  final ${datasource.name} _${datasource.name.toLowerCamelCase()};
  final ${entity.name}Factory _${entity.name.toLowerCamelCase()}Factory;

  ${repository.name}Impl({
    required ${datasource.name} ${datasource.name.toLowerCamelCase()},
    required ${entity.name}Factory ${entity.name.toLowerCamelCase()}Factory
  }) : _${datasource.name.toLowerCamelCase()} = ${datasource.name.toLowerCamelCase()},
      _${entity.name.toLowerCamelCase()}Factory = ${entity.name.toLowerCamelCase()}Factory;

${methods}
  @override
  void dispose() { }
}

""";
}
