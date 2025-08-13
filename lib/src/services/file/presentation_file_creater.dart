import 'dart:io';

import 'package:clean_arch_gen/src/const/fileTemplate/infrastructure/datasource.dart';
import 'package:clean_arch_gen/src/const/fileTemplate/infrastructure/factory.dart';
import 'package:clean_arch_gen/src/const/fileTemplate/infrastructure/infrastructure.dart';
import 'package:clean_arch_gen/src/const/fileTemplate/infrastructure/model.dart';
import 'package:clean_arch_gen/src/const/fileTemplate/infrastructure/repository.dart';
import 'package:clean_arch_gen/src/const/fileTemplate/presentation/notifier.dart';
import 'package:clean_arch_gen/src/const/fileTemplate/presentation/pages.dart';
import 'package:clean_arch_gen/src/const/fileTemplate/presentation/presentation.dart';
import 'package:clean_arch_gen/src/const/layers.dart';
import 'package:clean_arch_gen/src/models/domain/abstract_usecase.dart';
import 'package:clean_arch_gen/src/models/domain/domain.dart';
import 'package:clean_arch_gen/src/models/domain/entity.dart';
import 'package:clean_arch_gen/src/models/infrastructure/datasource.dart';
import 'package:clean_arch_gen/src/models/infrastructure/infrastructure.dart';
import 'package:clean_arch_gen/src/models/infrastructure/repository.dart';
import 'package:clean_arch_gen/src/models/infrastructure/response.dart';
import 'package:clean_arch_gen/src/models/presentation/notifier.dart';
import 'package:clean_arch_gen/src/models/presentation/presentation.dart';
import 'package:clean_arch_gen/src/services/file/directory_creater.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

class PresentationFileCreater {
  final DirectoryCreater directoryCreater;

  PresentationFileCreater(this.directoryCreater);

  void create(File yaml, Presentation presentation, Infrastructure infra, Domain domain) {
    final layerDir = "${yaml.parent}/${Layers.presentation}/";

    for(final subDir in PresentationLayer.values){
      final path = File("$layerDir/${subDir.name}");
      switch(subDir) {
        case PresentationLayer.notifier:
          for (final pair in IterableZip([infra.repositories, domain.usecases, presentation.notifiers])) {
            path.writeAsString(
              createNotifier(pair[0] as Repository, pair[1] as AbstractUsecase, pair[2] as Notifier)
            );
          }
          break;
        case PresentationLayer.pages:
          for(final page in presentation.pages){
            createPages(page);
          }
          break;
      }
    }
  }
}
