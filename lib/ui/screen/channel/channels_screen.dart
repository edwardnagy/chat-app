import 'package:flutter/material.dart';
import 'package:mirc_chat/core/model/channel.dart';
import 'package:mirc_chat/core/result_wrapper/result.dart';
import 'package:mirc_chat/core/use_case/channel/get_channels_to_join_use_case.dart';
import 'package:mirc_chat/core/use_case/channel/get_joined_channels_use_case.dart';
import 'package:mirc_chat/core/use_case/channel/get_owned_channels_use_case.dart';
import 'package:mirc_chat/di_config.dart';
import 'package:mirc_chat/ui/screen/channel/channel_thread_screen.dart';
import 'package:mirc_chat/ui/screen/channel/create_channel_screen.dart';
import 'package:mirc_chat/ui/screen/channel/join_channel_screen.dart';
import 'package:mirc_chat/ui/shared/app_error_widget.dart';

class ChannelsScreen extends StatefulWidget {
  const ChannelsScreen({Key? key}) : super(key: key);

  @override
  State<ChannelsScreen> createState() => _ChannelsScreenState();
}

class _ChannelsScreenState extends State<ChannelsScreen> {
  final GetOwnedChannelsUseCase _getOwnedChannels = locator();
  final GetJoinedChannelsUseCase _getJoinedChannels = locator();
  final GetChannelsToJoinUseCase _getChannelsToJoin = locator();

  Widget _buildChannelsResult({
    required String title,
    required Result<List<Channel>>? channelsResult,
    required Function(String name) onChannelTap,
  }) {
    if (channelsResult == null) {
      return const SizedBox();
    }

    return channelsResult.map(data: (result) {
      final channels = result.data;

      if (channels.isEmpty) {
        return const SizedBox();
      }

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: 12),
            ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: channels.length,
              itemBuilder: (context, index) {
                final channel = channels[index];
                return ListTile(
                  title: Text(channel.name),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => onChannelTap(channel.name),
                );
              },
            ),
          ],
        ),
      );
    }, failure: (result) {
      return AppErrorWidget(error: result.failure);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Channels'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: [
          StreamBuilder<Result<List<Channel>>>(
            stream: _getOwnedChannels(),
            builder: (context, snapshot) {
              return _buildChannelsResult(
                title: 'My channels',
                channelsResult: snapshot.data,
                onChannelTap: (name) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChannelThreadScreen(
                        channelName: name,
                        isOwnedByCurrentUser: true,
                      ),
                    ),
                  );
                },
              );
            },
          ),
          StreamBuilder<Result<List<Channel>>>(
            stream: _getJoinedChannels(),
            builder: (context, snapshot) {
              return _buildChannelsResult(
                title: 'Joined channels',
                channelsResult: snapshot.data,
                onChannelTap: (name) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChannelThreadScreen(
                        channelName: name,
                        isOwnedByCurrentUser: false,
                      ),
                    ),
                  );
                },
              );
            },
          ),
          StreamBuilder<Result<List<Channel>>>(
            stream: _getChannelsToJoin(),
            builder: (context, snapshot) {
              return _buildChannelsResult(
                title: 'Other channels',
                channelsResult: snapshot.data,
                onChannelTap: (name) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => JoinChannelScreen(
                        channelName: name,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'create_channel',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateChannelScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
