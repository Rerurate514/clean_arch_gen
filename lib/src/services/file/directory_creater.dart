import 'dart:io';

import 'package:clean_arch_gen/src/const/dirs.dart';
import 'package:clean_arch_gen/src/const/layers.dart';

abstract class FileSystemService {
  Future<bool> directoryExists(String path);
  Future<void> createDirectory(String path, {bool recursive = true});
}

class DirectoryCreater {
  final File yaml;
  final FileSystemService fileSystemService;

  const DirectoryCreater({
    required this.yaml,
    required this.fileSystemService,
  });

  Future<void> createProject() async {
    final makePos = yaml.parent;

    for (final dir in Dirs.project) {
      final path = '${makePos.path}/$dir';
      if (await fileSystemService.directoryExists(path)) continue;
      await fileSystemService.createDirectory(path, recursive: true);
    }

    for (final layer in Layers.values) {
      await _createLayers(makePos, layer);
    }
  }

  Future<void> _createLayers(Directory makePos, Layers layer) async {
    for (final dir in Dirs.getDirs(layer)) {
      final path = '${makePos.path}/${layer.name}/$dir';
      if (await fileSystemService.directoryExists(path)) continue;
      await fileSystemService.createDirectory(path, recursive: true);
    }
  }
}
