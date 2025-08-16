import 'dart:io';

abstract class FileSystemService {
  Future<bool> directoryExists(String path);
  Future<void> createDirectory(String path, {bool recursive = true});
  Future<void> writeAsString(File file, String contents);
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
  
  @override
  Future<void> writeAsString(File file, String contents) async  {
    await file.writeAsString(contents);
  }
}
