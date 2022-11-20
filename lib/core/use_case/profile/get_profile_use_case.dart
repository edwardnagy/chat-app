import 'package:injectable/injectable.dart';
import 'package:mirc_chat/core/model/profile.dart';
import 'package:mirc_chat/core/repository/auth_repository.dart';
import 'package:mirc_chat/core/repository/profile_repository.dart';
import 'package:mirc_chat/core/repository/user_repository.dart';
import 'package:mirc_chat/core/result_wrapper/result.dart';
import 'package:mirc_chat/core/result_wrapper/result_wrapper.dart';

@injectable
class GetProfileUseCase {
  final ProfileRepository _profileRepository;
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  const GetProfileUseCase(
    this._profileRepository,
    this._authRepository,
    this._userRepository,
  );

  Stream<Result<Profile?>> call() {
    return wrapStreamToResult(() async* {
      final userId = _authRepository.getUserId();

      await for (final user in _userRepository.getUser(uid: userId)) {
        if (user == null) {
          yield null;
        } else {
          yield* _profileRepository.getProfile(username: user.username);
        }
      }
    });
  }
}
