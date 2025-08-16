import 'package:clean_arch_gen/src/models/domain/entity.dart';
import 'package:clean_arch_gen/src/utils/recase.dart';

String createUsecase(Entity entity){
  return """
import '../entity/${entity.name.toLowerCamelCase()}.dart';

abstract class Get${entity.name}Usecase {
  Future<${entity.name}> finlById();
  Future<List<${entity.name}>> findAll();
}

""";
}
