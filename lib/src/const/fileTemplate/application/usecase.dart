import 'package:clean_arch_gen/src/models/domain/abstract_repository.dart';
import 'package:clean_arch_gen/src/models/domain/abstract_usecase.dart';
import 'package:clean_arch_gen/src/models/domain/entity.dart';
import 'package:clean_arch_gen/src/utils/recase.dart';

String createUsecase(AbstractUsecase usecase, AbstractRepository repository, Entity entity){
  return """
import '../../domain/entity/${entity.name.toLowerCamelCase()}.dart';
import '../../domain/repository/${repository.name.toLowerSnakeCase()}.dart';
import '../../domain/usecase/get_${usecase.name.toLowerSnakeCase()}.dart';
import '../../infrastructure/repository/${repository.name.toLowerSnakeCase()}_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_${usecase.name.toLowerCamelCase()}_impl.g.dart';

@riverpod
Get${usecase.name}Impl get${usecase.name}Impl(Ref ref){
  return Get${usecase.name}Impl(
    ${repository.name.toLowerCamelCase()}: ref.watch(${repository.name.toLowerCamelCase()}Provider)
  );
}

class Get${usecase.name}Impl implements Get${usecase.name} {
  final ${repository.name} _${repository.name.toLowerCamelCase()};

  Get${usecase.name}Impl({
    required ${repository.name.toLowerCamelCase()} ${repository.name.toLowerCamelCase()}
  }): _${repository.name.toLowerCamelCase()} = ${repository.name.toLowerCamelCase()};
  
  @override
  Future<${entity.name}> findById() async  {
    return await _${repository.name.toLowerCamelCase()}.findById();
  }

  @override
  Future<List<${entity.name}>> findAll() async {
    return await _${repository.name.toLowerCamelCase()}.findAll();
  }
}

""";
}
