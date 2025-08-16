import 'package:clean_arch_gen/src/models/infrastructure/datasource.dart';
import 'package:clean_arch_gen/src/models/infrastructure/response.dart';
import 'package:clean_arch_gen/src/utils/recase.dart';

String createDataSource(Response response, DataSource datasource){
  return """
import '../model/${response.name.toLowerSnakeCase()}_response.dart';

abstract class ${datasource.name} {
  Future<${response.name}Response> findById();

  Future<List<${response.name}Response>> findAll();
  
  void dispose();
}

""";
}

String createDataSourceImpl(Response response, DataSource datasource){
  return """
import '../model/${response.name.toLowerSnakeCase()}_response.dart';
import './${datasource.name.toLowerSnakeCase()}.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '${datasource.name.toLowerSnakeCase()}_impl.g.dart';

@riverpod
${datasource.name} ${datasource.name.toLowerCamelCase()}Impl (Ref ref) {
  return ${datasource.name}Impl();
}

class ${datasource.name}Impl implements ${datasource.name} {
  ${datasource.name}Impl();

  @override
  Future<${response.name}Response> findById() async {
    
  }

  @override
  Future<List<${response.name}Response>> findAll() async {
    
  }

  @override
  void dispose() {

  }
}

""";
}
