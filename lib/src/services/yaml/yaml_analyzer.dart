import 'dart:io';

import 'package:clean_arch_gen/src/services/file/application_file_creater.dart';
import 'package:clean_arch_gen/src/services/file/directory_creater.dart';
import 'package:clean_arch_gen/src/services/file/domain_file_creater.dart';
import 'package:clean_arch_gen/src/services/file/infrastructure_file_creater.dart';
import 'package:clean_arch_gen/src/services/file/presentation_file_creater.dart';
import 'package:clean_arch_gen/src/services/yaml/domain_factory.dart';
import 'package:clean_arch_gen/src/services/yaml/infrastructure_factory.dart';
import 'package:clean_arch_gen/src/services/yaml/presentation_factory.dart';
import 'package:yaml/yaml.dart';

class YamlAnalyzer {
  void analyze(File file) async {
    if (!await file.exists()) {
      return;
    }
    final yamlString = await file.readAsString();
    final yaml = loadYaml(yamlString) as YamlMap;

    final DomainFactory domainFactory = DomainFactory();
    final InfrastructureFactory infrastructureFactory = InfrastructureFactory();
    final PresentationFactory presentationFactory = PresentationFactory();

    final domain = domainFactory.createDomain(yaml);
    final infrastructure = infrastructureFactory.createInfrastructure(yaml);
    final presentation = presentationFactory.createPresentation(yaml);

    final DirectoryCreater directoryCreater = DirectoryCreater(
      fileSystemService: RealFileSystemService(), 
      yaml: file
    );

    final applicationFileCreater = ApplicationFileCreater(directoryCreater);
    final domainFileCreater = DomainFileCreater(directoryCreater);
    final infrastructureFileCreater = InfrastructureFileCreater(directoryCreater);
    final presentationFileCreater = PresentationFileCreater(directoryCreater);

    applicationFileCreater.create(file, domain);
    domainFileCreater.create(file, domain, infrastructure);
    infrastructureFileCreater.create(file, infrastructure, domain);
    presentationFileCreater.create(file, presentation, infrastructure, domain);
  }
}
