import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mirc_chat/di_config.dart';
import 'package:mirc_chat/ui/root_widget.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        dividerTheme: const DividerThemeData(space: 1),
      ),
      home: const RootWidget(),
    );
  }
}
