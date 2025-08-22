import 'package:clean_arch_gen/src/models/domain/domain.dart';
import 'package:clean_arch_gen/src/models/infrastructure/infrastructure.dart';
import 'package:clean_arch_gen/src/models/presentation/presentation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'Layers_model.freezed.dart';
part 'Layers_model.g.dart';

@freezed
sealed class LayersModel with _$LayersModel {
  const factory LayersModel({
    required Domain domain,
    required Infrastructure infrastructure,
    required Presentation presentation
  }) = _LayersModel;

  factory LayersModel.fromJson(Map<String, dynamic> json) => _$LayersModelFromJson(json);
}
