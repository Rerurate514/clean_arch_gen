import 'package:freezed_annotation/freezed_annotation.dart';

part 'datasource.freezed.dart';
part 'datasource.g.dart';

@freezed
sealed class DataSource with _$DataSource {

  factory DataSource({
    required String name
  }) = _DataSource;

  factory DataSource.fromJson(Map<String, dynamic> json) => _$DataSourceFromJson(json);
}
