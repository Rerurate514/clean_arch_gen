import '../entity/user.dart';
import '../../infrastructure/model/user_response.dart';

abstract class UserFactory {
  User create({required String id, required String name, required String bio, required String profileImageUrl,});
  User createFromModel(UserResponse user);
}

