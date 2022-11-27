import 'package:flutter/material.dart';
import 'package:mirc_chat/core/use_case/channel/join_channel_use_case.dart';
import 'package:mirc_chat/di_config.dart';
import 'package:mirc_chat/ui/screen/channel/channel_thread_screen.dart';
import 'package:mirc_chat/ui/shared/error_message_extension.dart';

class JoinChannelScreen extends StatefulWidget {
  final String channelName;

  const JoinChannelScreen({Key? key, required this.channelName})
      : super(key: key);

  @override
  State<JoinChannelScreen> createState() => _JoinChannelScreenState();
}

class _JoinChannelScreenState extends State<JoinChannelScreen> {
  final JoinChannelUseCase _joinChannel = locator();

  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Join Channel'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              autofocus: true,
              obscureText: true,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final result = await _joinChannel(
                  channelName: widget.channelName,
                  password: _passwordController.text,
                );

                result.map(
                  data: (_) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChannelThreadScreen(
                          channelName: widget.channelName,
                          isOwnedByCurrentUser: false,
                        ),
                      ),
                    );
                  },
                  failure: (error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(error.toUserFriendlyErrorMessage()),
                      ),
                    );
                  },
                );
              },
              child: const Text('Join'),
            ),
          ],
        ),
      ),
    );
  }
}
