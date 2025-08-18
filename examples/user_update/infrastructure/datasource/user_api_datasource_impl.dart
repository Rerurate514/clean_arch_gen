import '../model/user_response.dart';
import './user_api_datasource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_api_datasource_impl.g.dart';

@riverpod
UserApiDatasource userApiDatasourceImpl (Ref ref) {
  return UserApiDatasourceImpl();
}

class UserApiDatasourceImpl implements UserApiDatasource {
  UserApiDatasourceImpl();

  @override
  Future<UserResponse> fetchProfile(String userId) async {
    
  }


  @override
  Future<UserResponse> updateProfile(String userId, Map<String, dynamic> data) async {
    
  }

  @override
  void dispose() {

  }
}

