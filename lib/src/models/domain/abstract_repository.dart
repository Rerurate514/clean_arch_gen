import 'package:clean_arch_gen/src/models/utils/method.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'abstract_repository.freezed.dart';
part 'abstract_repository.g.dart';

@freezed
sealed class AbstractRepository with _$AbstractRepository {
  const factory AbstractRepository({
    required String name,
    required Method methods
  }) = _AbstractRepository;

  factory AbstractRepository.fromJson(Map<String, dynamic> json) => _$AbstractRepositoryFromJson(json);
}
