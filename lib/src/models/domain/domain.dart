import 'package:clean_arch_gen/src/models/domain/abstract_repository.dart';
import 'package:clean_arch_gen/src/models/domain/abstract_usecase.dart';
import 'package:clean_arch_gen/src/models/domain/entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'domain.freezed.dart';
part 'domain.g.dart';

@freezed
sealed class Domain with _$Domain {
  const factory Domain({
    required List<Entity> entities,
    required List<AbstractUsecase> usecases, 
    required List<AbstractRepository> repositories
  }) = _Domain;

  factory Domain.fromJson(Map<String, dynamic> json) => _$DomainFromJson(json);
}
