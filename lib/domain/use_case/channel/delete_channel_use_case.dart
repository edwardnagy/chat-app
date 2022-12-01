import 'package:injectable/injectable.dart';
import 'package:mirc_chat/domain/failure/message_failure.dart';
import 'package:mirc_chat/domain/repository/channel_repository.dart';
import 'package:mirc_chat/domain/result_wrapper/result.dart';
import 'package:mirc_chat/domain/result_wrapper/result_wrapper.dart';
import 'package:mirc_chat/domain/use_case/profile/get_profile_use_case.dart';

@injectable
class DeleteChannelUseCase {
  final ChannelRepository _channelRepository;
  final GetProfileUseCase _getProfileUseCase;

  const DeleteChannelUseCase(this._channelRepository, this._getProfileUseCase);

  Future<Result<void>> call({
    required String channelName,
  }) {
    return wrapFutureToResult(() async {
      final profileResult = await _getProfileUseCase().first;
      final profile = profileResult.getOrCrash();
      if (profile == null) {
        throw MessageFailure.currentUserNotFound;
      }

      await _channelRepository.deleteChannel(
        username: profile.username,
        channelName: channelName,
      );
    });
  }
}
