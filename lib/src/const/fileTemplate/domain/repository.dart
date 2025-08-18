import 'package:clean_arch_gen/src/models/domain/abstract_repository.dart';
import 'package:clean_arch_gen/src/models/domain/entity.dart';
import 'package:clean_arch_gen/src/utils/recase.dart';

String createRepository(Entity entity, AbstractRepository repository) {
    final methods = repository.methods
    .map((method) {
      final params = method.params
          .map((param) => "${param.type} ${param.name}")
          .join(', ');
      return """
  ${method.returns} ${method.name}($params);
""";
    })
    .join('');

  return """
import '../entity/${entity.name.toLowerCamelCase()}.dart';

abstract class ${repository.name} {
${methods}
  void dispose();
}

""";
}
