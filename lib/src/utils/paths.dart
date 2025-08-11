enum Paths {
  featureName('feature_name'),
  domain('domain'),
  domainEntities('domain.entities'),
  domainUseCases('domain.usecases'),
  domainRepositories('domain.repositories'),
  application('application'),
  applicationUseCases('application.usecases'),
  infrastructure('infrastructure'),
  infrastructureRepositories('infrastructure.repositories'),
  infrastructureDataSources('infrastructure.datasources'),
  presentation('presentation'),
  presentationPage('presentation.page'),
  presentationNotifiers('presentation.notifiers'),
  presentationNotifierStates('presentation.notifiers.LoginNotifier.states');

  const Paths(this.path);
  final String path;
}
