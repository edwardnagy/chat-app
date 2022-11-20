import 'package:injectable/injectable.dart';
import 'package:mirc_chat/core/model/profile.dart';
import 'package:mirc_chat/core/model/user.dart';
import 'package:mirc_chat/core/repository/auth_repository.dart';
import 'package:mirc_chat/core/repository/profile_repository.dart';
import 'package:mirc_chat/core/repository/user_repository.dart';
import 'package:mirc_chat/core/result_wrapper/result.dart';
import 'package:mirc_chat/core/result_wrapper/result_wrapper.dart';

@injectable
class CreateProfileUseCase {
  final ProfileRepository _profileRepository;
  final UserRepository _userRepository;
  final AuthRepository _authRepository;

  const CreateProfileUseCase(
    this._profileRepository,
    this._userRepository,
    this._authRepository,
  );

  Future<Result<void>> call(Profile profile) {
    return wrapFutureToResult(
      () async {
        await _profileRepository.createProfile(profile);
        await Future.wait([
          _createUser(profile),
          _authRepository.updateProfile(profile),
        ]);
      },
    );
  }

  Future<void> _createUser(Profile profile) {
    final userId = _authRepository.getUserId();

    return _userRepository.createUser(
      User(
        uid: userId,
        username: profile.username,
      ),
    );
  }
}
