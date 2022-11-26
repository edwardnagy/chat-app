import 'package:injectable/injectable.dart';
import 'package:mirc_chat/core/failure/message_failure.dart';
import 'package:mirc_chat/core/model/message.dart';
import 'package:mirc_chat/core/repository/direct_message_repository.dart';
import 'package:mirc_chat/core/result_wrapper/result.dart';
import 'package:mirc_chat/core/result_wrapper/result_wrapper.dart';
import 'package:mirc_chat/core/use_case/profile/get_profile_use_case.dart';
import 'package:uuid/uuid.dart';

@injectable
class SendMessageToUserUseCase {
  final DirectMessageRepository _directMessageRepository;
  final GetProfileUseCase _getProfileUseCase;

  const SendMessageToUserUseCase(
    this._directMessageRepository,
    this._getProfileUseCase,
  );

  Future<Result<void>> call({
    required String recipientUsername,
    required String messageText,
  }) {
    return wrapFutureToResult(() async {
      final profileResult = await _getProfileUseCase().first;
      final username = profileResult.getOrCrash()?.username;
      if (username == null) {
        throw MessageFailure.currentUserNotFound;
      }

      await _directMessageRepository.sendMessageToUser(
        username,
        recipientUsername: recipientUsername,
        message: Message(
          id: const Uuid().v1(),
          senderUsername: username,
          text: messageText,
          creationDate: DateTime.now(),
        ),
      );
    });
  }
}
