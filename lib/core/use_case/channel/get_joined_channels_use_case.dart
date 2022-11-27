import 'package:injectable/injectable.dart';
import 'package:mirc_chat/core/failure/message_failure.dart';
import 'package:mirc_chat/core/model/channel.dart';
import 'package:mirc_chat/core/repository/channel_repository.dart';
import 'package:mirc_chat/core/result_wrapper/result.dart';
import 'package:mirc_chat/core/result_wrapper/result_wrapper.dart';
import 'package:mirc_chat/core/use_case/profile/get_profile_use_case.dart';

@injectable
class GetJoinedChannelsUseCase {
  final ChannelRepository _channelRepository;
  final GetProfileUseCase _getProfileUseCase;

  const GetJoinedChannelsUseCase(
    this._channelRepository,
    this._getProfileUseCase,
  );

  Stream<Result<List<Channel>>> call() {
    return wrapStreamToResult(() async* {
      await for (final profileResult in _getProfileUseCase()) {
        final profile = profileResult.getOrCrash();

        if (profile == null) {
          throw MessageFailure.currentUserNotFound;
        } else {
          yield* _channelRepository
              .getJoinedChannelThreads(username: profile.username)
              .map(
                (threads) => threads
                    .map(
                      (thread) => Channel(
                          name: thread.channelName,
                          ownerUsername: thread.ownerUsername),
                    )
                    .toList(),
              );
        }
      }
    });
  }
}
