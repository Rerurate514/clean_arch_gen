import 'package:clean_arch_gen/src/models/infrastructure/datasources.dart';
import 'package:clean_arch_gen/src/models/infrastructure/repositories.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'infrastructure.freezed.dart';
part 'infrastructure.g.dart';

@freezed
sealed class Infrastructure with _$Infrastructure {
  const factory Infrastructure({
    required Repositories repositories,
    required DataSources dataSources,
  }) = _Infrastructure;

  factory Infrastructure.fromJson(Map<String, dynamic> json) => _$InfrastructureFromJson(json);
}
