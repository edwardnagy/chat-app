import 'package:injectable/injectable.dart';
import 'package:mirc_chat/domain/model/channel.dart';
import 'package:mirc_chat/domain/result_wrapper/result.dart';
import 'package:mirc_chat/domain/result_wrapper/result_wrapper.dart';
import 'package:mirc_chat/domain/use_case/channel/get_all_channels_use_case.dart';
import 'package:mirc_chat/domain/use_case/channel/get_joined_channels_use_case.dart';
import 'package:mirc_chat/domain/use_case/channel/get_owned_channels_use_case.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class GetChannelsToJoinUseCase {
  final GetAllChannelsUseCase _getAllChannelsUseCase;
  final GetJoinedChannelsUseCase _getJoinedChannelsUseCase;
  final GetOwnedChannelsUseCase _getOwnedChannelsUseCase;

  const GetChannelsToJoinUseCase(
    this._getAllChannelsUseCase,
    this._getJoinedChannelsUseCase,
    this._getOwnedChannelsUseCase,
  );

  Stream<Result<List<Channel>>> call() {
    return wrapStreamToResult(() {
      return CombineLatestStream.combine3(
        _getAllChannelsUseCase(),
        _getJoinedChannelsUseCase(),
        _getOwnedChannelsUseCase(),
        (allChannelsResult, joinedChannelsResult, ownedChannelsResult) {
          final allChannels = allChannelsResult.getOrCrash();
          final joinedChannels = joinedChannelsResult.getOrCrash();
          final ownedChannels = ownedChannelsResult.getOrCrash();

          return allChannels
              .where(
                (channel) =>
                    !joinedChannels.contains(channel) &&
                    !ownedChannels.contains(channel),
              )
              .toList();
        },
      );
    });
  }
}
