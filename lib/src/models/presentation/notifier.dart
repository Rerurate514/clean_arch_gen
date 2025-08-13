import 'package:freezed_annotation/freezed_annotation.dart';

part 'notifier.freezed.dart';
part 'notifier.g.dart';

@freezed
sealed class Notifier with _$Notifier {
  const factory Notifier({
    required String name 
  }) = _Notifier;

  factory Notifier.fromJson(Map<String, dynamic> json) => _$NotifierFromJson(json);
}
