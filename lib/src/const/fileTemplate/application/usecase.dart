import 'package:clean_arch_gen/src/models/domain/abstract_usecase.dart';
import 'package:clean_arch_gen/src/utils/recase.dart';

String createUsecase(AbstractUsecase usecase) {
  final repoImport = usecase.repositories.map((repoName) {
    return """
import '../../domain/repository/${repoName.toLowerSnakeCase()}.dart';
import '../../infrastructure/repository/${repoName.toLowerSnakeCase()}_impl.dart';
""";
  }).join();

  final repoProvider = usecase.repositories.map((repoName) {
    return "${repoName.toLowerCamelCase()}: ref.watch(${repoName.toLowerCamelCase()}ImplProvider),";
  }).join('\n    ');

  final repoFields = usecase.repositories.map((repoName) {
    return "  final ${repoName} _${repoName.toLowerCamelCase()};";
  }).join('\n');

  final repoConstructorParams = usecase.repositories.map((repoName) {
    return "required ${repoName} ${repoName.toLowerCamelCase()}";
  }).join(',\n    ');

  final repoConstructorAssignments = usecase.repositories.map((repoName) {
    return "_${repoName.toLowerCamelCase()} = ${repoName.toLowerCamelCase()}";
  }).join(',\n    ');

  return """
import '../../domain/usecase/${usecase.name.toLowerSnakeCase()}.dart';
${repoImport}
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '${usecase.name.toLowerSnakeCase()}_impl.g.dart';

@riverpod
${usecase.name}Impl get${usecase.name}Impl(Ref ref){
  return ${usecase.name}Impl(
    ${repoProvider}
  );
}

class ${usecase.name}Impl implements ${usecase.name} {
${repoFields}

  ${usecase.name}Impl({
    ${repoConstructorParams}
  }) : ${repoConstructorAssignments};
  
  ${usecase.method.returns} ${usecase.method.name}(${usecase.method.params.map((param) => "${param.type} ${param.name}").join(', ')})${usecase.method.isAsync ? " async " : ""}{
    
  }
}
""";
}
