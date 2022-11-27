import 'package:flutter/material.dart';
import 'package:mirc_chat/core/result_wrapper/result.dart';
import 'package:mirc_chat/core/use_case/channel/delete_channel_use_case.dart';
import 'package:mirc_chat/core/use_case/channel/get_channel_thread_use_case.dart';
import 'package:mirc_chat/core/use_case/channel/quit_channel_use_case.dart';
import 'package:mirc_chat/core/use_case/channel/send_message_to_channel_use_case.dart';
import 'package:mirc_chat/di_config.dart';
import 'package:mirc_chat/ui/shared/error_message_extension.dart';
import 'package:mirc_chat/ui/shared/thread_content.dart';

class ChannelThreadScreen extends StatefulWidget {
  final String channelName;
  final bool isOwnedByCurrentUser;

  const ChannelThreadScreen({
    Key? key,
    required this.channelName,
    required this.isOwnedByCurrentUser,
  }) : super(key: key);

  @override
  State<ChannelThreadScreen> createState() => _ChannelThreadScreenState();
}

class _ChannelThreadScreenState extends State<ChannelThreadScreen> {
  final GetChannelThreadUseCase _getChannelThread = locator();
  final SendMessageToChannelUseCase _sendMessageToChannel = locator();
  final QuitChannelUseCase _quitChannel = locator();
  final DeleteChannelUseCase _deleteChannel = locator();

  void _handleActionResult(Result result) {
    result.when(
      data: (_) {
        if (!mounted) return;
        Navigator.pop(context);
      },
      failure: (failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(failure.toUserFriendlyErrorMessage()),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.channelName),
        actions: [
          if (widget.isOwnedByCurrentUser)
            IconButton(
              onPressed: () async {
                final result =
                    await _deleteChannel(channelName: widget.channelName);
                _handleActionResult(result);
              },
              icon: const Icon(Icons.delete),
            )
          else
            IconButton(
              onPressed: () async {
                final result =
                    await _quitChannel(channelName: widget.channelName);
                _handleActionResult(result);
              },
              icon: const Icon(Icons.exit_to_app),
            ),
        ],
      ),
      body: ThreadContent(
        threadStream: _getChannelThread(channelName: widget.channelName),
        onSendMessage: (messageText) {
          return _sendMessageToChannel(
            channelName: widget.channelName,
            messageText: messageText,
          );
        },
      ),
    );
  }
}
