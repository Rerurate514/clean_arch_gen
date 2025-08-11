import 'package:clean_arch_gen/src/models/infrastructure/datasource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'datasources.freezed.dart';
part 'datasources.g.dart';

@freezed
sealed class DataSources with _$DataSources {

  factory DataSources({
    required List<DataSource> datasource
  }) = _DataSources;

  factory DataSources.fromJson(Map<String, dynamic> json) => _$DataSourcesFromJson(json);
}
