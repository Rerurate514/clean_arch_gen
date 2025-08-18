import 'package:clean_arch_gen/src/models/presentation/presentation.dart';
import 'package:clean_arch_gen/src/models/presentation/page.dart';
import 'package:clean_arch_gen/src/models/presentation/notifier.dart';
import 'package:clean_arch_gen/src/utils/paths.dart';
import 'package:yaml/yaml.dart';

class PresentationFactory {
  Presentation createPresentation(YamlMap yaml) {
    return Presentation(
      pages: _createPages(yaml), 
      notifiers: _createNotifiers(yaml)
    );
  }

  List<Page> _createPages(YamlMap yaml) {
    final presentationYaml = yaml[Paths.presentation.path];
    if (presentationYaml == null || presentationYaml[Paths.presentationPages.path] == null) {
      return [];
    }
    
    final pagesYaml = presentationYaml[Paths.presentationPages.path] as YamlList;
    return pagesYaml
        .cast<String>()
        .map((pageName) => Page(name: pageName))
        .toList();

  }

  List<Notifier> _createNotifiers(YamlMap yaml) {
    final presentationYaml = yaml[Paths.presentation.path];
    if (presentationYaml == null || presentationYaml[Paths.presentationNotifiers.path] == null) {
      return [];
    }
    
    final notifiersYaml = presentationYaml[Paths.presentationNotifiers.path] as YamlList;
    return notifiersYaml
        .cast<String>()
        .map((notifierName) => Notifier(name: notifierName))
        .toList();
  }
}
