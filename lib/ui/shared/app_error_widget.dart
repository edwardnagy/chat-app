import 'package:flutter/material.dart';
import 'package:mirc_chat/ui/shared/error_message_extension.dart';

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({
    Key? key,
    required this.error,
  }) : super(key: key);

  final Object? error;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Icon(
            Icons.warning_outlined,
            size: 64,
          ),
          const SizedBox(height: 16),
          Text(
            error.toUserFriendlyErrorMessage(),
          ),
        ],
      ),
    );
  }
}
