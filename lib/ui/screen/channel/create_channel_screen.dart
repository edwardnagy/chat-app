import 'package:flutter/material.dart';
import 'package:mirc_chat/core/use_case/channel/create_channel_use_case.dart';
import 'package:mirc_chat/di_config.dart';
import 'package:mirc_chat/ui/screen/channel/channel_thread_screen.dart';
import 'package:mirc_chat/ui/shared/error_message_extension.dart';

class CreateChannelScreen extends StatefulWidget {
  const CreateChannelScreen({Key? key}) : super(key: key);

  @override
  State<CreateChannelScreen> createState() => _CreateChannelScreenState();
}

class _CreateChannelScreenState extends State<CreateChannelScreen> {
  final CreateChannelUseCase _createChannel = locator();

  final _channelNameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _channelNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Channel'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              autofocus: true,
              controller: _channelNameController,
              decoration: const InputDecoration(
                labelText: 'Channel Name',
              ),
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final channelName = _channelNameController.text;
                final result = await _createChannel(
                  channelName: channelName,
                  password: _passwordController.text,
                );

                result.map(
                  data: (_) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChannelThreadScreen(
                          channelName: channelName,
                          isOwnedByCurrentUser: true,
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
              child: const Text('Create'),
            ),
          ],
        ),
      ),
    );
  }
}
