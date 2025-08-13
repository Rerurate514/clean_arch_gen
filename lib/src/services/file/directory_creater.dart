import 'dart:io';

import 'package:clean_arch_gen/src/const/dirs.dart';
import 'package:clean_arch_gen/src/const/layers.dart';

abstract class FileSystemService {
  Future<bool> directoryExists(String path);
  Future<void> createDirectory(String path, {bool recursive = true});
}

class RealFileSystemService implements FileSystemService {
  @override
  Future<bool> directoryExists(String path) async {
    return Directory(path).exists();
  }

  @override
  Future<void> createDirectory(String path, {bool recursive = true}) async {
    await Directory(path).create(recursive: recursive);
  }
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
