import '../entity/user.dart';

abstract class UserRepository {
  Future<User> findById(String userId);
  Future<User> update(User user);

  void dispose();
}

