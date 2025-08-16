import 'package:clean_arch_gen/src/models/infrastructure/datasource.dart';
import 'package:clean_arch_gen/src/models/infrastructure/repository.dart';
import 'package:clean_arch_gen/src/models/infrastructure/response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'infrastructure.freezed.dart';
part 'infrastructure.g.dart';

@freezed
sealed class Infrastructure with _$Infrastructure {
  const factory Infrastructure({
    required List<Response> responses,
    required List<Repository> repositories,
    required List<DataSource> dataSources,
  }) = _Infrastructure;

  factory Infrastructure.fromJson(Map<String, dynamic> json) => _$InfrastructureFromJson(json);
}
