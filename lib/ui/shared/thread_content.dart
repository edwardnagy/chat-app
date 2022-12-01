import 'package:flutter/material.dart';
import 'package:mirc_chat/core/model/message.dart';
import 'package:mirc_chat/core/model/thread.dart';
import 'package:mirc_chat/core/result_wrapper/result.dart';
import 'package:mirc_chat/ui/shared/app_error_widget.dart';
import 'package:mirc_chat/ui/shared/error_message_extension.dart';

class ThreadContent extends StatefulWidget {
  final Stream<Result<Thread?>> threadStream;
  final Future<Result> Function(String) onSendMessage;

  const ThreadContent({
    Key? key,
    required this.threadStream,
    required this.onSendMessage,
  }) : super(key: key);

  @override
  State<ThreadContent> createState() => _ThreadContentState();
}

class _ThreadContentState extends State<ThreadContent> {
  final _messageController = TextEditingController();

  Future<void> _onSendMessage() async {
    final messageText = _messageController.text;
    if (messageText.isNotEmpty) {
      final result = await widget.onSendMessage(messageText);
      result.when(
        data: (_) {
          _messageController.clear();
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
  }

  Widget _messageBubble(BuildContext context, Message message) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '<${message.senderUsername}>',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(message.text),
          ),
        ],
      ),
    );
  }

  Widget _messageResultView(BuildContext context, Result<Thread?>? result) {
    if (result == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return result.map(
      data: (result) {
        final messages = result.data?.messages.reversed.toList() ?? [];

        return Scrollbar(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            reverse: true,
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final message = messages[index];
              return _messageBubble(context, message);
            },
            separatorBuilder: (_, __) => const SizedBox(height: 12.0),
          ),
        );
      },
      failure: (error) {
        return AppErrorWidget(error: error);
      },
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder<Result<Thread?>>(
            stream: widget.threadStream,
            builder: (context, snapshot) {
              return _messageResultView(context, snapshot.data);
            },
          ),
        ),
        const Divider(),
        Row(
          children: [
            const SizedBox(width: 12.0),
            Expanded(
              child: TextField(
                controller: _messageController,
                decoration: const InputDecoration.collapsed(
                  hintText: 'Send a message',
                ),
                autofocus: true,
                onSubmitted: (_) => _onSendMessage(),
              ),
            ),
            const SizedBox(width: 8.0),
            IconButton(
              icon: Icon(
                Icons.send,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: _onSendMessage,
            ),
            const SizedBox(width: 8.0),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).padding.bottom),
      ],
    );
  }
}
