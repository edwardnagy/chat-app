import 'package:flutter/material.dart';
import 'package:mirc_chat/core/model/direct_messages_holder.dart';
import 'package:mirc_chat/core/model/message.dart';
import 'package:mirc_chat/core/result_wrapper/result.dart';
import 'package:mirc_chat/core/use_case/direct_messages/get_messages_with_user_use_case.dart';
import 'package:mirc_chat/core/use_case/direct_messages/send_message_to_user_use_case.dart';
import 'package:mirc_chat/di_config.dart';
import 'package:mirc_chat/ui/shared/app_error_widget.dart';

class MessageUserScreen extends StatefulWidget {
  final String? recipientUsername;

  const MessageUserScreen({
    Key? key,
    required this.recipientUsername,
  }) : super(key: key);

  @override
  State<MessageUserScreen> createState() => _MessageUserScreenState();
}

class _MessageUserScreenState extends State<MessageUserScreen> {
  final GetMessagesWithUserUseCase _getMessagesWithUser = locator();
  final SendMessageToUserUseCase _sendMessageToUser = locator();

  final TextEditingController _messageTextController = TextEditingController();

  late String? recipientUsername = widget.recipientUsername;

  Future<void> _sendMessage(String recipientUsername) async {
    final messageText = _messageTextController.text;
    if (messageText.isNotEmpty) {
      await _sendMessageToUser(
        recipientUsername: recipientUsername,
        messageText: messageText,
      );
      _messageTextController.clear();
    }
  }

  Widget _messagesResultView(Result<DirectMessagesHolder?>? result) {
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
              return _messageBubble(message);
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

  Widget _messageBubble(Message message) {
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

  @override
  Widget build(BuildContext context) {
    final recipientUsername = this.recipientUsername;

    return Scaffold(
      appBar: AppBar(
        title: Text(recipientUsername ?? 'New message'),
      ),
      body: Column(
        children: [
          if (recipientUsername == null) ...[
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 16.0,
              ),
              child: TextField(
                decoration: const InputDecoration(hintText: 'Enter username'),
                autofocus: true,
                onSubmitted: (value) {
                  setState(() {
                    this.recipientUsername = value;
                  });
                },
              ),
            ),
          ] else ...[
            Expanded(
              child: StreamBuilder<Result<DirectMessagesHolder?>>(
                stream: _getMessagesWithUser(
                  recipientUsername: recipientUsername,
                ),
                builder: (context, snapshot) {
                  return _messagesResultView(snapshot.data);
                },
              ),
            ),
            const Divider(),
            Row(
              children: [
                const SizedBox(width: 12.0),
                Expanded(
                  child: TextField(
                    controller: _messageTextController,
                    decoration: const InputDecoration.collapsed(
                      hintText: 'Send a message',
                    ),
                    autofocus: true,
                    onSubmitted: (_) => _sendMessage(recipientUsername),
                  ),
                ),
                const SizedBox(width: 8.0),
                IconButton(
                  icon: Icon(
                    Icons.send,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () => _sendMessage(recipientUsername),
                ),
                const SizedBox(width: 8.0),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
