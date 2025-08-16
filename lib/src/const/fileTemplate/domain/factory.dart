import 'package:clean_arch_gen/src/models/domain/entity.dart';
import 'package:clean_arch_gen/src/models/infrastructure/response.dart';
import 'package:clean_arch_gen/src/utils/recase.dart';

String createDomainFactory(Entity entity, Response response){
  return """
import '../entity/${entity.name.toLowerCamelCase()}.dart';
import '../../infrastructure/model/${response.name.toLowerSnakeCase()}_response.dart';

abstract class ${entity.name}Factory {
  ${entity.name} create();

  ${entity.name} createFromModel(${response.name}Response ${entity.name.toLowerCamelCase()});
}

""";
}
