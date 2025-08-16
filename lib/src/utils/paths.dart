enum Paths {
  featureName('feature_name'),
  domain('domain'),
  domainEntities('entities'),
  domainUseCases('usecases'),
  domainRepositories('repositories'),
  application('application'),
  applicationUseCases('usecases'),
  infrastructure('infrastructure'),
  infrastructureResponses('responses'),
  infrastructureRepositories('repositories'),
  infrastructureDataSources('datasources'),
  presentation('presentation'),
  presentationPage('page'),
  presentationNotifiers('notifiers'),
  presentationNotifierStates('states'),
  fields('fields'),
  id('id'),
  type('type'),
  methods('methods'),
  returns('returns'),
  params('params'),
  implements('implements'),
  dependencies('dependencies');

  const Paths(this.path);
  final String path;
}
