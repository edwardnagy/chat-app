import 'package:injectable/injectable.dart';
import 'package:mirc_chat/domain/failure/message_failure.dart';
import 'package:mirc_chat/domain/model/profile.dart';
import 'package:mirc_chat/domain/repository/direct_message_repository.dart';
import 'package:mirc_chat/domain/result_wrapper/result.dart';
import 'package:mirc_chat/domain/result_wrapper/result_wrapper.dart';
import 'package:mirc_chat/domain/use_case/profile/get_profile_use_case.dart';

@injectable
class GetFriendsUseCase {
  final DirectMessageRepository _directMessageRepository;
  final GetProfileUseCase _getProfileUseCase;

  GetFriendsUseCase(
    this._directMessageRepository,
    this._getProfileUseCase,
  );

  Stream<Result<List<Profile>>> call() {
    return wrapStreamToResult(() async* {
      await for (final profileResult in _getProfileUseCase()) {
        final username = profileResult.getOrCrash()?.username;
        if (username == null) {
          throw MessageFailure.currentUserNotFound;
        }
        yield* _directMessageRepository
            .getAllMessages(username)
            .map((threads) => threads
                .map(
                  (thread) => Profile(
                    thread.participants.keys.firstWhere(
                      (participantUsername) => participantUsername != username,
                    ),
                  ),
                )
                .toList());
      }
    });
  }
}
