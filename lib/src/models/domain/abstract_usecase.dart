import 'package:clean_arch_gen/src/models/utils/method.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'abstract_usecase.freezed.dart';
part 'abstract_usecase.g.dart';

@freezed
sealed class AbstractUsecase with _$AbstractUsecase {
  const factory AbstractUsecase({
    required String name,
    required List<String> repositories, 
    required Method method,
  }) = _AbstractUsecase;

  factory AbstractUsecase.fromJson(Map<String, dynamic> json) => _$AbstractUsecaseFromJson(json);
}
