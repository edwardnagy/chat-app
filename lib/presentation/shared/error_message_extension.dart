import 'package:mirc_chat/domain/failure/auth_failure.dart';
import 'package:mirc_chat/domain/failure/message_failure.dart';
import 'package:mirc_chat/domain/failure/profile_failure.dart';

extension ErrorMessageExtension on Object? {
  String toUserFriendlyErrorMessage() {
    final thisObject = this;

    if (thisObject is AuthFailure) {
      switch (thisObject) {
        case AuthFailure.notAuthenticated:
          return 'You are not authenticated';
      }
    }

    if (thisObject is MessageFailure) {
      switch (thisObject) {
        case MessageFailure.currentUserNotFound:
          return 'User not found';
      }
    }

    if (thisObject is ProfileFailure) {
      switch (thisObject) {
        case ProfileFailure.usernameAlreadyInUse:
          return 'Username already in use';
        case ProfileFailure.usernameWrongFormat:
          return 'Username wrong format';
      }
    }

    return 'Something went wrong';
  }
}
