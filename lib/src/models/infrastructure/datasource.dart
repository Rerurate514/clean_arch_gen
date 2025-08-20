import 'package:clean_arch_gen/src/models/utils/method.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'datasource.freezed.dart';
part 'datasource.g.dart';

@freezed
sealed class DataSource with _$DataSource {
  const factory DataSource({
    required String name,
    required List<Method> methods
  }) = _DataSource;

  factory DataSource.fromJson(Map<String, dynamic> json) => _$DataSourceFromJson(json);
}
