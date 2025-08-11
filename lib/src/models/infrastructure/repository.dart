import 'package:freezed_annotation/freezed_annotation.dart';

part 'repository.freezed.dart';
part 'repository.g.dart';

@freezed
sealed class Repository with _$Repository {

  const factory Repository({
    required String name,
    required String implements,
    required String dependencies
  }) = _Repository;

  factory Repository.fromJson(Map<String, dynamic> json) => _$RepositoryFromJson(json);
}
