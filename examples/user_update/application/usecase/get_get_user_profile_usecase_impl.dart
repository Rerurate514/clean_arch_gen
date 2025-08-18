import '../../domain/entity/user.dart';
import '../../domain/repository/user_repository.dart';
import '../../domain/usecase/get_get_user_profile_usecase.dart';
import '../../infrastructure/repository/user_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_get_user_profile_usecase_impl.g.dart';

@riverpod
GetGetUserProfileUsecaseImpl getGetUserProfileUsecaseImpl(Ref ref){
  return GetGetUserProfileUsecaseImpl(
    userRepository: ref.watch(userRepositoryImplProvider)
  );
}

class GetGetUserProfileUsecaseImpl implements GetGetUserProfileUsecase {
  final UserRepository _userRepository;

  GetGetUserProfileUsecaseImpl({
    required UserRepository userRepository
  }): _userRepository = userRepository;
  
  Future<User> execute(String userId) async {
    
  }
}

