import 'package:firebase_ui_auth/firebase_ui_auth.dart' as firebase_ui;
import 'package:flutter/material.dart';
import 'package:mirc_chat/presentation/screen/main_screen.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return firebase_ui.SignInScreen(
      providers: [firebase_ui.EmailAuthProvider()],
      actions: [
        firebase_ui.AuthStateChangeAction<firebase_ui.SignedIn>(
            (context, state) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const MainScreen(),
            ),
          );
        }),
      ],
    );
  }
}
