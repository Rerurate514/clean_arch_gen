import '../../domain/entity/user.dart';
import '../../domain/factory/user_factory.dart';
import '../model/user_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_factory_impl.g.dart';

@riverpod
UserFactory userFactoryImpl(Ref ref) {
  return UserFactoryImpl();
}

class UserFactoryImpl implements UserFactory {
  @override
  User create({
    required String id,
    required String name,
    required String bio,
    required String profileImageUrl,
  }) {
    return User();
  }

  @override
  User createFromModel(UserResponse response) {
    return User();
  }
}

