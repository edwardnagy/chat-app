import 'package:injectable/injectable.dart';
import 'package:mirc_chat/domain/repository/channel_repository.dart';
import 'package:mirc_chat/domain/result_wrapper/result.dart';
import 'package:mirc_chat/domain/result_wrapper/result_wrapper.dart';

@injectable
class DeleteChannelUseCase {
  final ChannelRepository _channelRepository;

  const DeleteChannelUseCase(this._channelRepository);

  Future<Result<void>> call({required String channelName}) {
    return wrapFutureToResult(() {
      return _channelRepository.deleteChannel(channelName);
    });
  }
}
