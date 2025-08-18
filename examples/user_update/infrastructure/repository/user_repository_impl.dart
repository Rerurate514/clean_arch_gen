import '../../domain/entity/user.dart';
import '../../domain/factory/user_factory.dart';
import '../../domain/repository/user_repository.dart';
import '../datasource/user_api_datasource.dart';
import '../datasource/user_api_datasource_impl.dart';
import '../factory/user_factory_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_repository_impl.g.dart';

@riverpod
UserRepository userRepositoryImpl(Ref ref) {
  return UserRepositoryImpl(
    userApiDatasource: ref.watch(userApiDatasourceImplProvider), 
    userFactory: ref.watch(userFactoryImplProvider)
  );
}

class UserRepositoryImpl implements UserRepository {
  final UserApiDatasource _userApiDatasource;
  final UserFactory _userFactory;

  UserRepositoryImpl({
    required UserApiDatasource userApiDatasource,
    required UserFactory userFactory
  }) : _userApiDatasource = userApiDatasource,
      _userFactory = userFactory;

  @override
  Future<User> findById(String userId) async {
    
  }


  @override
  Future<User> update(User user) async {
    
  }

  @override
  void dispose() { }
}

