import 'dart:io';

import 'package:clean_arch_gen/src/const/fileTemplate/presentation/notifier.dart';
import 'package:clean_arch_gen/src/const/fileTemplate/presentation/pages.dart';
import 'package:clean_arch_gen/src/const/fileTemplate/presentation/presentation.dart';
import 'package:clean_arch_gen/src/const/layers.dart';
import 'package:clean_arch_gen/src/models/domain/abstract_usecase.dart';
import 'package:clean_arch_gen/src/models/domain/domain.dart';
import 'package:clean_arch_gen/src/models/infrastructure/infrastructure.dart';
import 'package:clean_arch_gen/src/models/infrastructure/repository.dart';
import 'package:clean_arch_gen/src/models/presentation/notifier.dart';
import 'package:clean_arch_gen/src/models/presentation/presentation.dart';
import 'package:clean_arch_gen/src/services/file/file_system_service.dart';
import 'package:clean_arch_gen/src/utils/recase.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

class PresentationFileCreater {
  final FileSystemService fileSystemService;

  PresentationFileCreater(this.fileSystemService);

  void create(File yaml, Presentation presentation, Infrastructure infra, Domain domain) {
    final layerDir = "${yaml.parent.path}/${Layers.presentation.name}";

    for (final subDir in PresentationLayer.values) {
      final path = File("$layerDir/${subDir.name}");
      switch (subDir) {
        case PresentationLayer.notifier:
          for (final pair in IterableZip([infra.repositories, domain.usecases, presentation.notifiers])) {
            final repository = pair[0] as Repository;
            final usecase = pair[1] as AbstractUsecase;
            final notifier = pair[2] as Notifier;
            final notifierFile = File("${path.path}/${usecase.name.toLowerSnakeCase()}_notifier.dart");
            fileSystemService.writeAsString(
              notifierFile,
              createNotifier(repository, usecase, notifier),
            );
          }
          break;
        case PresentationLayer.pages:
          for (final page in presentation.pages) {
            final pageFile = File("${path.path}/${page.name.toLowerSnakeCase()}_page.dart");
            fileSystemService.writeAsString(
              pageFile, 
              createPages(page)
            );
          }
          break;
      }
    }
  }
}
