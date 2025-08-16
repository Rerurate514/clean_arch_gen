import 'package:clean_arch_gen/src/models/domain/abstract_usecase.dart';
import 'package:clean_arch_gen/src/models/domain/entity.dart';
import 'package:clean_arch_gen/src/utils/recase.dart';

String createUsecase(Entity entity, AbstractUsecase usecase){
  return """
import '../entity/${entity.name.toLowerCamelCase()}.dart';

abstract class Get${usecase.name} {
  Future<${entity.name}> findById();
  Future<List<${entity.name}>> findAll();
}

""";
}
