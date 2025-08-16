import 'package:clean_arch_gen/src/models/infrastructure/datasource.dart';
import 'package:clean_arch_gen/src/models/infrastructure/response.dart';
import 'package:clean_arch_gen/src/utils/recase.dart';

String createDataSource(Response response, DataSource datasource){
  return """
import '../model/${response.name.toLowerSnakeCase()}.dart';

abstract class ${datasource.name} {
  Future<${response.name}> findById();

  Future<List<${response.name}> findAll();
  
  void dispose();
}

""";
}

String createDataSourceImpl(DataSource datasource){
  return """
import 'dart:developer';

import '../../application/extension/github_api_exception.dart';
import '../../application/utils/dio.dart';
import '../../core/env/env.dart';
import '../../datasource/github_api_datasource.dart';
import '../../model/github_api_response.dart';
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
  Future<GithubApiResponse> findbyId() async {
    
  }

  @override
  Future<List<GithubApiResponse>> findAll() async {
    
  }

  @override
  void dispose() {

  }
}

""";
}
