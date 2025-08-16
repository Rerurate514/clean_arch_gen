import 'dart:io';
import 'package:clean_arch_gen/src/services/file/directory_creater.dart';
import 'package:clean_arch_gen/src/services/file/file_system_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:clean_arch_gen/src/const/dirs.dart';
import 'package:clean_arch_gen/src/const/layers.dart';

@GenerateMocks([File, FileSystemService])
import 'directory_creater_test.mocks.dart';

class TestFileSystemService implements FileSystemService {
  final Map<String, bool> _existingDirs = {};
  final List<String> _createdDirs = [];

  @override
  Future<bool> directoryExists(String path) async {
    return _existingDirs[path] ?? false;
  }

  @override
  Future<void> createDirectory(String path, {bool recursive = true}) async {
    _createdDirs.add(path);
  }

  void setDirectoryExists(String path, bool exists) {
    _existingDirs[path] = exists;
  }

  List<String> get createdDirectories => List.unmodifiable(_createdDirs);

  void reset() {
    _existingDirs.clear();
    _createdDirs.clear();
  }
  
  @override
  Future<void> writeAsString(File file, String contents) {
    throw UnimplementedError();
  }
}

void main() {
  group('DirectoryCreater', () {
    late MockFile mockYaml;
    late Directory mockParentDir;
    late TestFileSystemService testFileSystemService;
    late DirectoryCreater directoryCreater;

    setUp(() {
      mockYaml = MockFile();
      mockParentDir = Directory('/test/path');
      testFileSystemService = TestFileSystemService();

      when(mockYaml.parent).thenReturn(mockParentDir);

      directoryCreater = DirectoryCreater(
        yaml: mockYaml,
        fileSystemService: testFileSystemService,
      );
    });

    tearDown(() {
      testFileSystemService.reset();
    });

    group('createProject', () {
      test('プロジェクトディレクトリが存在しない場合、すべてのプロジェクトディレクトリを作成する', () async {
        for (final dir in Dirs.project) {
          testFileSystemService.setDirectoryExists('/test/path/$dir', false);
        }

        for (final layer in Layers.values) {
          for (final dir in Dirs.getDirs(layer)) {
            testFileSystemService.setDirectoryExists(
              '/test/path/${layer.name}/$dir',
              false,
            );
          }
        }

        await directoryCreater.createProject();

        for (final dir in Dirs.project) {
          expect(
            testFileSystemService.createdDirectories,
            contains('/test/path/$dir'),
          );
        }

        for (final layer in Layers.values) {
          for (final dir in Dirs.getDirs(layer)) {
            expect(
              testFileSystemService.createdDirectories,
              contains('/test/path/${layer.name}/$dir'),
            );
          }
        }

        verify(mockYaml.parent).called(1);
      });

      test('ディレクトリがすでに存在する場合、作成をスキップする', () async {
        for (final dir in Dirs.project) {
          testFileSystemService.setDirectoryExists('/test/path/$dir', true);
        }

        for (final layer in Layers.values) {
          for (final dir in Dirs.getDirs(layer)) {
            testFileSystemService.setDirectoryExists(
              '/test/path/${layer.name}/$dir',
              true,
            );
          }
        }

        await directoryCreater.createProject();

        expect(testFileSystemService.createdDirectories, isEmpty);

        verify(mockYaml.parent).called(1);
      });

      test('正しいパスでプロジェクトディレクトリを作成する', () async {
        final expectedProjectPaths = Dirs.project
            .map((dir) => '/test/path/$dir')
            .toList();

        final expectedLayerPaths = <String>[];
        for (final layer in Layers.values) {
          for (final dir in Dirs.getDirs(layer)) {
            expectedLayerPaths.add('/test/path/${layer.name}/$dir');
          }
        }

        await directoryCreater.createProject();

        for (final path in expectedProjectPaths) {
          expect(testFileSystemService.createdDirectories, contains(path));
        }

        for (final path in expectedLayerPaths) {
          expect(testFileSystemService.createdDirectories, contains(path));
        }
      });

      test('既存と非既存のディレクトリが混在している場合を処理する', () async {
        final projectDirs = Dirs.project.toList();
        final expectedCreatedDirs = <String>[];

        for (int i = 0; i < projectDirs.length; i++) {
          final path = '/test/path/${projectDirs[i]}';
          final exists = i % 2 == 0;
          testFileSystemService.setDirectoryExists(path, exists);

          if (!exists) {
            expectedCreatedDirs.add(path);
          }
        }

        for (final layer in Layers.values) {
          final layerDirs = Dirs.getDirs(layer).toList();
          for (int i = 0; i < layerDirs.length; i++) {
            final path = '/test/path/${layer.name}/${layerDirs[i]}';
            final exists = i % 3 == 0;
            testFileSystemService.setDirectoryExists(path, exists);

            if (!exists) {
              expectedCreatedDirs.add(path);
            }
          }
        }

        await directoryCreater.createProject();

        expect(
          testFileSystemService.createdDirectories.length,
          equals(expectedCreatedDirs.length),
        );

        for (final path in expectedCreatedDirs) {
          expect(testFileSystemService.createdDirectories, contains(path));
        }

        verify(mockYaml.parent).called(1);
      });

      test('createProject()がawaitで完了を待てる', () async {
        final future = directoryCreater.createProject();
        expect(future, isA<Future<void>>());

        await future;

        expect(true, isTrue);
      });
    });

    group('_createLayers', () {
      test('指定されたレイヤーのディレクトリを作成する', () async {
        final layer = Layers.values.first;

        for (final dir in Dirs.getDirs(layer)) {
          testFileSystemService.setDirectoryExists(
            '/test/path/${layer.name}/$dir',
            false,
          );
        }

        await directoryCreater.createProject();

        for (final dir in Dirs.getDirs(layer)) {
          expect(
            testFileSystemService.createdDirectories,
            contains('/test/path/${layer.name}/$dir'),
          );
        }
      });
    });

    group('コンストラクタ', () {
      test('yamlファイルとfileSystemServiceで初期化されるべき', () {
        final mockFileSystemService = MockFileSystemService();
        final creater = DirectoryCreater(
          yaml: mockYaml,
          fileSystemService: mockFileSystemService,
        );

        expect(creater.yaml, equals(mockYaml));
        expect(creater.fileSystemService, equals(mockFileSystemService));
      });
    });

    group('DirsとLayersとの連携', () {
      test('定義されているすべてのレイヤーを使用する', () async {
        await directoryCreater.createProject();

        final usedLayers = <String>{};

        for (final path in testFileSystemService.createdDirectories) {
          final segments = path.split('/');
          if (segments.length >= 4) {
            final layerName = segments[3];
            if (Layers.values.any((layer) => layer.name == layerName)) {
              usedLayers.add(layerName);
            }
          }
        }

        final expectedLayers = Layers.values.map((layer) => layer.name).toSet();
        expect(usedLayers, equals(expectedLayers));
      });

      test('すべてのレイヤーサブディレクトリを作成する', () async {
        await directoryCreater.createProject();

        final expectedLayerDirCount = Layers.values
            .map((layer) => Dirs.getDirs(layer).length)
            .fold<int>(0, (sum, count) => sum + count);

        final actualLayerDirCount = testFileSystemService.createdDirectories
            .where((path) {
              final segments = path.split('/');
              return segments.length >= 5 &&
                  Layers.values.any((layer) => layer.name == segments[3]);
            })
            .length;

        expect(actualLayerDirCount, equals(expectedLayerDirCount));
      });
    });

    group('エラーハンドリング', () {
      test('ファイルシステムエラーが発生した場合の処理', () async {
        final mockFileSystemService = MockFileSystemService();
        final creater = DirectoryCreater(
          yaml: mockYaml,
          fileSystemService: mockFileSystemService,
        );

        when(
          mockFileSystemService.directoryExists(any),
        ).thenThrow(FileSystemException('Permission denied'));

        expect(
          () => creater.createProject(),
          throwsA(isA<FileSystemException>()),
        );
      });

      test('ディレクトリ作成時にエラーが発生した場合の処理', () async {
        final mockFileSystemService = MockFileSystemService();
        final creater = DirectoryCreater(
          yaml: mockYaml,
          fileSystemService: mockFileSystemService,
        );

        when(
          mockFileSystemService.directoryExists(any),
        ).thenAnswer((_) async => false);
        when(
          mockFileSystemService.createDirectory(
            any,
            recursive: anyNamed('recursive'),
          ),
        ).thenThrow(FileSystemException('Disk full'));

        expect(
          () => creater.createProject(),
          throwsA(isA<FileSystemException>()),
        );
      });
    });
  });
}
