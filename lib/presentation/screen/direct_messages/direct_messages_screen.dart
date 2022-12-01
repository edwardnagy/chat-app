import 'package:flutter/material.dart';
import 'package:mirc_chat/di_config.dart';
import 'package:mirc_chat/domain/model/profile.dart';
import 'package:mirc_chat/domain/result_wrapper/result.dart';
import 'package:mirc_chat/domain/use_case/direct_messages/get_friends_use_case.dart';
import 'package:mirc_chat/presentation/screen/direct_messages/direct_message_thread_screen.dart';
import 'package:mirc_chat/presentation/shared/app_error_widget.dart';

class DirectMessagesScreen extends StatefulWidget {
  const DirectMessagesScreen({Key? key}) : super(key: key);

  @override
  State<DirectMessagesScreen> createState() => _DirectMessagesScreenState();
}

class _DirectMessagesScreenState extends State<DirectMessagesScreen> {
  final GetFriendsUseCase _getFriends = locator();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Direct Messages'),
      ),
      body: StreamBuilder<Result<List<Profile>>>(
        stream: _getFriends(),
        builder: (context, snapshot) {
          final result = snapshot.data;

          if (result == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return result.map(
            data: (result) {
              final profiles = result.data;

              if (profiles.isEmpty) {
                return const Center(
                  child: Text('No conversations yet'),
                );
              }

              return Scrollbar(
                child: ListView.separated(
                  itemCount: profiles.length,
                  itemBuilder: (context, index) {
                    final profile = profiles[index];

                    return ListTile(
                      title: Row(
                        children: [
                          const CircleAvatar(
                            backgroundColor: Colors.green,
                            radius: 6,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(profile.username),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DirectMessageThreadScreen(
                              recipientUsername: profile.username,
                            ),
                          ),
                        );
                      },
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                ),
              );
            },
            failure: (result) {
              return AppErrorWidget(error: result.failure);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'create_direct_message',
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const DirectMessageThreadScreen(
                recipientUsername: null,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
