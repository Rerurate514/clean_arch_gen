import 'package:clean_arch_gen/src/models/domain/entity.dart';
import 'package:clean_arch_gen/src/models/infrastructure/datasource.dart';
import 'package:clean_arch_gen/src/models/infrastructure/repository.dart';
import 'package:clean_arch_gen/src/utils/recase.dart';

String createRepository(Entity entity, Repository repository, DataSource datasource){
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

  @override
  Future<${entity.name}> findById() async {

  }

  @override
  Future<List<${entity.name}>> findAll() async {
    
  }

  @override
  void dispose() { }
}

""";
}
