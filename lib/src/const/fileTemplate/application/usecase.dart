import 'package:clean_arch_gen/src/models/domain/abstract_repository.dart';
import 'package:clean_arch_gen/src/models/domain/abstract_usecase.dart';
import 'package:clean_arch_gen/src/models/domain/entity.dart';
import 'package:clean_arch_gen/src/utils/recase.dart';

String createUsecase(AbstractUsecase usecase, AbstractRepository repository, Entity entity){
  return """
import '../../domain/entity/${entity.name.toLowerCamelCase()}.dart';
import '../../domain/repository/${repository.name.toLowerSnakeCase()}.dart';
import '../../domain/usecase/${usecase.name.toLowerSnakeCase()}.dart';
import '../../infrastructure/repository/${repository.name.toLowerSnakeCase()}_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '${usecase.name.toLowerSnakeCase()}_impl.g.dart';

@riverpod
${usecase.name}Impl get${usecase.name}Impl(Ref ref){
  return ${usecase.name}Impl(
    ${repository.name.toLowerCamelCase()}: ref.watch(${repository.name.toLowerCamelCase()}ImplProvider)
  );
}

class ${usecase.name}Impl implements ${usecase.name} {
  final ${repository.name} _${repository.name.toLowerCamelCase()};

  ${usecase.name}Impl({
    required ${repository.name} ${repository.name.toLowerCamelCase()}
  }): _${repository.name.toLowerCamelCase()} = ${repository.name.toLowerCamelCase()};
  
  ${usecase.method.returns} ${usecase.method.name}(${usecase.method.params.map((param) => "${param.type} ${param.name}") .join(', ')})${" ${usecase.method.isAsync ? "async " : ""}"}{
    
  }
}

""";
}
