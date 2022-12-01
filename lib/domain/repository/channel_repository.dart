import 'package:mirc_chat/domain/model/channel.dart';
import 'package:mirc_chat/domain/model/channel_thread.dart';
import 'package:mirc_chat/domain/model/message.dart';

abstract class ChannelRepository {
  Stream<List<Channel>> getChannels({String? ownerUsername});

  Future<void> createChannel(
    Channel channel, {
    required String password,
  });

  Future<void> deleteChannel(String channelName);

  Future<void> joinChannel({
    required String username,
    required String channelName,
    required String password,
  });

  Future<void> quitChannel({
    required String username,
    required String channelName,
  });

  Stream<List<ChannelThread>> getJoinedChannelThreads({
    required String username,
  });

  Stream<ChannelThread?> getChannelThread({
    required String channelName,
    required String username,
  });

  Future<void> sendMessage({
    required String channelName,
    required Message message,
  });
}
