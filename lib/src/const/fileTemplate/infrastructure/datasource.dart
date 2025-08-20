import 'package:clean_arch_gen/src/models/infrastructure/datasource.dart';
import 'package:clean_arch_gen/src/models/infrastructure/response.dart';
import 'package:clean_arch_gen/src/utils/recase.dart';

String createDataSource(Response response, DataSource datasource){
    final methods = datasource.methods
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
import '../model/${response.name.toLowerSnakeCase()}.dart';

abstract class ${datasource.name} {
${methods}
  void dispose();
}

""";
}

String createDataSourceImpl(Response response, DataSource datasource){
  final methods = datasource.methods
    .map((method) {
      final params = method.params
          .map((param) => "${param.type} ${param.name}")
          .join(', ');
      return """
  @override
  ${method.returns} ${method.name}($params)${method.isAsync ? " async" : ""} {
    
  }
""";
    })
    .join('\n\n');

  return """
import '../model/${response.name.toLowerSnakeCase()}.dart';
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

${methods}
  @override
  void dispose() {

  }
}

""";
}
