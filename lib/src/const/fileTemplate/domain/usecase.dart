import 'package:clean_arch_gen/src/models/domain/abstract_usecase.dart';

String createUsecase(AbstractUsecase usecase) {
  return """
abstract class ${usecase.name} {
  ${usecase.method.returns} ${usecase.method.name}(${usecase.method.params.map((param) => "${param.type} ${param.name}") .join(', ')});
}
""";
}
