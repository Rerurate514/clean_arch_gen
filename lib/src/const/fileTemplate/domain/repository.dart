import 'package:clean_arch_gen/src/models/domain/abstract_repository.dart';

String createRepository(AbstractRepository repository) {
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
abstract class ${repository.name} {
${methods}
  void dispose();
}

""";
}
