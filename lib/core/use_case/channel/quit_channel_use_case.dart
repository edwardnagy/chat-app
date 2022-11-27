import 'package:injectable/injectable.dart';
import 'package:mirc_chat/core/failure/message_failure.dart';
import 'package:mirc_chat/core/repository/channel_repository.dart';
import 'package:mirc_chat/core/result_wrapper/result.dart';
import 'package:mirc_chat/core/result_wrapper/result_wrapper.dart';
import 'package:mirc_chat/core/use_case/profile/get_profile_use_case.dart';

@injectable
class QuitChannelUseCase {
  final ChannelRepository _channelRepository;
  final GetProfileUseCase _getProfileUseCase;

  const QuitChannelUseCase(this._channelRepository, this._getProfileUseCase);

  Future<Result<void>> call({required String channelName}) {
    return wrapFutureToResult(() async {
      final profileResult = await _getProfileUseCase().first;
      final profile = profileResult.getOrCrash();

      if (profile == null) {
        throw MessageFailure.currentUserNotFound;
      }

      await _channelRepository.quitChannel(
        username: profile.username,
        channelName: channelName,
      );
    });
  }
}