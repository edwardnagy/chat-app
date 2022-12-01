import 'package:mirc_chat/domain/model/direct_message_thread.dart';
import 'package:mirc_chat/domain/model/message.dart';

abstract class DirectMessageRepository {
  Stream<List<DirectMessageThread>> getAllMessages(String username);

  Stream<DirectMessageThread?> getMessagesWithUser(
    String username, {
    required String recipientUsername,
  });

  Future<void> sendMessageToUser(
    String username, {
    required String recipientUsername,
    required Message message,
  });
}
