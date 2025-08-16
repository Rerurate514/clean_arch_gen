import 'package:clean_arch_gen/src/models/presentation/notifier.dart';
import 'package:clean_arch_gen/src/models/presentation/page.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'presentation.freezed.dart';
part 'presentation.g.dart';

@freezed
sealed class Presentation with _$Presentation {
  const factory Presentation({
    required List<Page> pages,
    required List<Notifier> notifiers
  }) = _Presentation;

  factory Presentation.fromJson(Map<String, dynamic> json) => _$PresentationFromJson(json);
}
