import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mirc_chat/ui/screen/profile_screen.dart';
import 'package:mirc_chat/ui/screen/sign_in_screen.dart';

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
          return const ProfileScreen();
        }
      },
    );
  }
}
