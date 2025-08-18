import '../model/user_response.dart';

abstract class UserApiDatasource {
  Future<UserResponse> fetchProfile(String userId);
  Future<UserResponse> updateProfile(String userId, Map<String, dynamic> data);

  void dispose();
}

