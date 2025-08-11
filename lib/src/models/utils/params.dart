import 'package:freezed_annotation/freezed_annotation.dart';

part 'params.freezed.dart';
part 'params.g.dart';

@freezed
sealed class Params with _$Params {

  factory Params({
    required String name,
    required String type
  }) = _Params;

  factory Params.fromJson(Map<String, dynamic> json) => _$ParamsFromJson(json);
}
