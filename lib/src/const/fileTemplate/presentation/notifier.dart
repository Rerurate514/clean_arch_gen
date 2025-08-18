import 'package:clean_arch_gen/src/models/domain/abstract_repository.dart';
import 'package:clean_arch_gen/src/models/domain/abstract_usecase.dart';
import 'package:clean_arch_gen/src/models/presentation/notifier.dart';
import 'package:clean_arch_gen/src/utils/recase.dart';

String createNotifier(AbstractRepository repository, AbstractUsecase usecase, Notifier notifier){
  return """
import '../../application/usecase/get_${usecase.name.toLowerSnakeCase()}_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '${notifier.name.toLowerSnakeCase()}_notifier.g.dart';

@riverpod
class ${notifier.name}Notifier extends _\$${notifier.name}Notifier {
  @override
  build() {
    return [];
  }

  
}

""";
}
