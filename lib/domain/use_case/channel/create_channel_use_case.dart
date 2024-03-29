import 'package:injectable/injectable.dart';
import 'package:mirc_chat/domain/failure/message_failure.dart';
import 'package:mirc_chat/domain/model/channel.dart';
import 'package:mirc_chat/domain/repository/channel_repository.dart';
import 'package:mirc_chat/domain/result_wrapper/result.dart';
import 'package:mirc_chat/domain/result_wrapper/result_wrapper.dart';
import 'package:mirc_chat/domain/use_case/profile/get_profile_use_case.dart';

@injectable
class CreateChannelUseCase {
  final ChannelRepository _channelRepository;
  final GetProfileUseCase _getProfileUseCase;

  const CreateChannelUseCase(this._channelRepository, this._getProfileUseCase);

  Future<Result<void>> call({
    required String channelName,
    required String password,
  }) {
    return wrapFutureToResult(() async {
      final profileResult = await _getProfileUseCase().first;

      final profile = profileResult.getOrCrash();
      if (profile == null) {
        throw MessageFailure.currentUserNotFound;
      }

      await _channelRepository.createChannel(
        Channel(
          name: channelName,
          ownerUsername: profile.username,
        ),
        password: password,
      );
    });
  }
}
