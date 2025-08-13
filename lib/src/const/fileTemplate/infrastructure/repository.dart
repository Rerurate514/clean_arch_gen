import 'package:clean_arch_gen/src/models/domain/entity.dart';
import 'package:clean_arch_gen/src/models/infrastructure/datasource.dart';
import 'package:clean_arch_gen/src/models/infrastructure/repository.dart';
import 'package:clean_arch_gen/src/utils/recase.dart';

String createRepository(Entity entity, Repository repository, DataSource datasource){
  return """
import '../domain/entity/${entity.name.toLowerSnakeCase()}.dart';
import '../domain/factory/${entity.name.toLowerSnakeCase()}_factory.dart';
import '../domain/repository/${repository.name.toLowerSnakeCase()}.dart';
import '../datasource/${entity.name.toLowerSnakeCase()}.dart';
import '../datasource/${entity.name.toLowerSnakeCase()}_impl.dart';
import '../factory/${entity.name.toLowerSnakeCase()}_factory_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '${repository.name.toLowerSnakeCase()}_impl.g.dart';

@riverpod
${repository.name} ${repository.name.toLowerCase()}(Ref ref) {
  return ${repository.name}Impl(
    ${datasource.name.toLowerCase()}Impl: ref.watch(${datasource.name.toLowerCase()}ImplProvider), 
    ${repository.name.toLowerCase()}FactoryImpl: ref.watch(${repository.name.toLowerCase()}FactoryImplProvider)
  );
}

${repository.name}Impl ${datasource.name.toLowerCase()}Impl (Ref ref) {
  return ${repository.name}Impl(
    ${datasource.name.toLowerCase()}Impl: ref.watch(${datasource.name.toLowerCase()}ImplProvider), 
    ${repository.name.toLowerCase()}FactoryImpl: ref.watch(${repository.name.toLowerCase()}FactoryImplProvider)
  );
}

class ${repository.name}Impl implements ${repository.name} {
  final ${datasource.name.toLowerCase()} _${datasource.name.toLowerCase()};
  final ${repository.name}Factory _${entity.name.toLowerCase()}Factory;

  ${repository.name}Impl({
    required ${datasource.name.toLowerCase()} ${datasource.name.toLowerCase()}Impl,
    required ${entity.name}Factory ${entity.name.toLowerCase()}FactoryImpl
  }) : _${datasource.name.toLowerCase()} = ${datasource.name.toLowerCase()}Impl,
      _${entity.name.toLowerCase()}Factory = ${entity.name.toLowerCase()}FactoryImpl;

  @override
  Future<${entity.name}> finlById() async {

  }

  @override
  Future<List<${entity.name}>> findAll() async {
    
  }

  @override
  void dispose() { }
}

""";
}
