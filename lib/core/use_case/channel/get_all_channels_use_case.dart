import 'package:injectable/injectable.dart';
import 'package:mirc_chat/core/model/channel.dart';
import 'package:mirc_chat/core/repository/channel_repository.dart';
import 'package:mirc_chat/core/result_wrapper/result.dart';
import 'package:mirc_chat/core/result_wrapper/result_wrapper.dart';

@injectable
class GetAllChannelsUseCase {
  final ChannelRepository _channelRepository;

  const GetAllChannelsUseCase(this._channelRepository);

  Stream<Result<List<Channel>>> call() {
    return wrapStreamToResult(() => _channelRepository.getChannels());
  }
}
