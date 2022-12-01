import 'package:flutter/material.dart';
import 'package:mirc_chat/core/use_case/direct_messages/get_messages_with_user_use_case.dart';
import 'package:mirc_chat/core/use_case/direct_messages/send_message_to_user_use_case.dart';
import 'package:mirc_chat/di_config.dart';
import 'package:mirc_chat/ui/shared/thread_content.dart';

class DirectMessageThreadScreen extends StatefulWidget {
  final String? recipientUsername;

  const DirectMessageThreadScreen({
    Key? key,
    required this.recipientUsername,
  }) : super(key: key);

  @override
  State<DirectMessageThreadScreen> createState() =>
      _DirectMessageThreadScreenState();
}

class _DirectMessageThreadScreenState extends State<DirectMessageThreadScreen> {
  final GetMessagesWithUserUseCase _getMessagesWithUser = locator();
  final SendMessageToUserUseCase _sendMessageToUser = locator();

  final _usernameController = TextEditingController();
  final _messageTextController = TextEditingController();

  late String? recipientUsername = widget.recipientUsername;

  void _setUsername() {
    setState(() {
      recipientUsername = _usernameController.text;
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _messageTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final recipientUsername = this.recipientUsername;

    return Scaffold(
      appBar: AppBar(
        title: Text(recipientUsername ?? 'New message'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (recipientUsername == null) ...[
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 16.0,
              ),
              child: TextField(
                controller: _usernameController,
                decoration: const InputDecoration(hintText: 'Enter username'),
                autofocus: true,
                onSubmitted: (_) => _setUsername(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ElevatedButton(
                onPressed: () => _setUsername(),
                child: const Text('Send message'),
              ),
            ),
          ] else ...[
            Expanded(
              child: ThreadContent(
                threadStream:
                    _getMessagesWithUser(recipientUsername: recipientUsername),
                onSendMessage: (messageText) {
                  return _sendMessageToUser(
                    recipientUsername: recipientUsername,
                    messageText: messageText,
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}
