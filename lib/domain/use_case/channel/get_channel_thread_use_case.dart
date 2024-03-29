import 'package:injectable/injectable.dart';
import 'package:mirc_chat/domain/failure/message_failure.dart';
import 'package:mirc_chat/domain/model/channel_thread.dart';
import 'package:mirc_chat/domain/repository/channel_repository.dart';
import 'package:mirc_chat/domain/result_wrapper/result.dart';
import 'package:mirc_chat/domain/result_wrapper/result_wrapper.dart';
import 'package:mirc_chat/domain/use_case/profile/get_profile_use_case.dart';

@injectable
class GetChannelThreadUseCase {
  final ChannelRepository _channelRepository;
  final GetProfileUseCase _getProfileUseCase;

  const GetChannelThreadUseCase(
    this._channelRepository,
    this._getProfileUseCase,
  );

  Stream<Result<ChannelThread?>> call({required String channelName}) {
    return wrapStreamToResult(() async* {
      await for (final profileResult in _getProfileUseCase()) {
        final profile = profileResult.getOrCrash();

        if (profile == null) {
          throw MessageFailure.currentUserNotFound;
        } else {
          yield* _channelRepository.getChannelThread(
            channelName: channelName,
            username: profile.username,
          );
        }
      }
    });
  }
}
