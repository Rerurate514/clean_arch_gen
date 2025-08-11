import 'package:clean_arch_gen/src/models/utils/params.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'method.freezed.dart';
part 'method.g.dart';

@freezed
sealed class Method with _$Method {

  factory Method({
    required String name,
    required String returns,
    required List<Params> params
  }) = _Method;

  factory Method.fromJson(Map<String, dynamic> json) => _$MethodFromJson(json);
}
