import 'package:clean_arch_gen/src/models/domain/abstract_repository.dart';
import 'package:clean_arch_gen/src/models/domain/entity.dart';
import 'package:clean_arch_gen/src/utils/recase.dart';

String createRepository(Entity entity, AbstractRepository repository) {
  return """
import '../entity/${entity.name.toLowerCamelCase()}.dart';

abstract class ${repository.name} {
  Future<${entity.name}> findById();
  Future<List<${entity.name}>> findAll();
  void dispose();
}

""";
}
