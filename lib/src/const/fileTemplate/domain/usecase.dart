import 'package:clean_arch_gen/src/models/domain/entity.dart';

String createUsecase(Entity entity){
  return """
import '../entity/${entity.name.toLowerCase()}.dart';

abstract class Get${entity.name}Usecase {
  Future<${entity.name}> finlById();
  Future<List<${entity.name}>> findAll();
}

""";
}
