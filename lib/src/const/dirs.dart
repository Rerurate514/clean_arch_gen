import 'package:clean_arch_gen/src/const/layers.dart';

class Dirs{
  static const project = [
    "application",
    "core",
    "domain",
    "infrastructure",
    "presentation"
  ];

  static const application = [
    "extension",
    "usecase",
    "utiles"
  ];

  static const domain = [
    "entity",
    "factory",
    "repository",
    "usecase"
  ];

  static const infrastructure = [
    "datasource",
    "factory",
    "model",
    "repository"
  ];

  static const presentation = [
    "pages",
    "components",
    "notifier"
  ];

  static List<String> getDirs(Layers layers){
    return switch(layers){
      Layers.application => application,
      Layers.domain => domain,
      Layers.infrastructure => infrastructure,
      Layers.presentation => presentation
    };
  }
}
