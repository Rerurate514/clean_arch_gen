import 'dart:io';

import 'package:clean_arch_gen/src/models/utils/Layers_model.dart';
import 'package:clean_arch_gen/src/services/yaml/domain_factory.dart';
import 'package:clean_arch_gen/src/services/yaml/infrastructure_factory.dart';
import 'package:clean_arch_gen/src/services/yaml/presentation_factory.dart';
import 'package:clean_arch_gen/src/utils/exceptions/file_not_found_exception.dart';
import 'package:yaml/yaml.dart';

class YamlAnalyzer {
  Future<LayersModel> analyze(File file) async {
    if (!await file.exists()) {
      throw FileNotFoundException(message: "${file}が見つからず、yaml解析を実行することができませんでした。");
    }

    final yamlString = await file.readAsString();
    final yaml = loadYaml(yamlString) as YamlMap;

    final DomainFactory domainFactory = DomainFactory();
    final InfrastructureFactory infrastructureFactory = InfrastructureFactory();
    final PresentationFactory presentationFactory = PresentationFactory();

    final domain = domainFactory.createDomain(yaml);
    final infrastructure = infrastructureFactory.createInfrastructure(yaml);
    final presentation = presentationFactory.createPresentation(yaml);

    return LayersModel(domain: domain, infrastructure: infrastructure, presentation: presentation);
  }
}
