import 'package:clean_arch_gen/src/models/infrastructure/repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'repositories.freezed.dart';
part 'repositories.g.dart';

@freezed
sealed class Repositories with _$Repositories {

  const factory Repositories({
    required List<Repository> repositories
  }) = _Repositories;

  factory Repositories.fromJson(Map<String, dynamic> json) => _$RepositoriesFromJson(json);
}
