import '../entity/user.dart';

abstract class GetGetUserProfileUsecase {
  Future<User> execute(String userId);
}
