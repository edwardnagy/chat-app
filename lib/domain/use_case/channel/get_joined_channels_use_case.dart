import 'package:injectable/injectable.dart';
import 'package:mirc_chat/domain/failure/message_failure.dart';
import 'package:mirc_chat/domain/model/channel.dart';
import 'package:mirc_chat/domain/repository/channel_repository.dart';
import 'package:mirc_chat/domain/result_wrapper/result.dart';
import 'package:mirc_chat/domain/result_wrapper/result_wrapper.dart';
import 'package:mirc_chat/domain/use_case/profile/get_profile_use_case.dart';

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
