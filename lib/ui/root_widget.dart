import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mirc_chat/core/model/profile.dart';
import 'package:mirc_chat/core/result_wrapper/result.dart';
import 'package:mirc_chat/core/use_case/profile/get_profile_use_case.dart';
import 'package:mirc_chat/di_config.dart';
import 'package:mirc_chat/ui/screen/direct_messages_screen.dart';
import 'package:mirc_chat/ui/screen/loading_screen.dart';
import 'package:mirc_chat/ui/screen/set_username_screen.dart';
import 'package:mirc_chat/ui/screen/sign_in_screen.dart';
import 'package:mirc_chat/ui/shared/app_error_widget.dart';

class RootWidget extends StatelessWidget {
  const RootWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        final user = snapshot.data ?? FirebaseAuth.instance.currentUser;
        if (user == null) {
          return const SignInScreen();
        } else {
          return StreamBuilder<Result<Profile?>>(
            stream: locator<GetProfileUseCase>().call(),
            builder: (context, snapshot) {
              final profileResult = snapshot.data;
              if (profileResult == null) {
                return const LoadingScreen();
              } else {
                return profileResult.map(
                  data: (result) {
                    final profile = result.data;
                    if (profile == null) {
                      return const SetUsernameScreen();
                    } else {
                      return const DirectMessagesScreen();
                    }
                  },
                  failure: (error) {
                    return Scaffold(
                      body: Center(
                        child: AppErrorWidget(error: error),
                      ),
                    );
                  },
                );
              }
            },
          );
        }
      },
    );
  }
}
