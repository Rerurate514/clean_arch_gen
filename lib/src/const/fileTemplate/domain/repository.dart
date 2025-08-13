import 'package:clean_arch_gen/src/models/domain/abstract_repository.dart';
import 'package:clean_arch_gen/src/models/domain/entity.dart';

String createRepository(Entity entity, AbstractRepository repository) {
  return """
import '../entity/${entity.name.toLowerCase()}.dart';

abstract class ${repository.name} {
  Future<${entity.name}> finlById();
  Future<List<${entity.name}>> findAll();
  void dispose();
}

""";
}
