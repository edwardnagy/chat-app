import 'package:flutter/material.dart';
import 'package:mirc_chat/core/model/profile.dart';
import 'package:mirc_chat/core/use_case/profile/create_profile_use_case.dart';
import 'package:mirc_chat/di_config.dart';

class SetUsernameScreen extends StatefulWidget {
  const SetUsernameScreen({Key? key}) : super(key: key);

  @override
  State<SetUsernameScreen> createState() => _SetUsernameScreenState();
}

class _SetUsernameScreenState extends State<SetUsernameScreen> {
  final _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Username'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(
                hintText: 'Username',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                locator<CreateProfileUseCase>().call(
                  Profile(_usernameController.text),
                );
              },
              child: const Text('Set Username'),
            ),
          ],
        ),
      ),
    );
  }
}
