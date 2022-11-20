import 'package:flutter/material.dart';

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({
    Key? key,
    required this.error,
  }) : super(key: key);

  final Object? error;

  @override
  Widget build(BuildContext context) {
    // TODO: Show user-friendly message
    return Text(
      error.toString(),
    );
  }
}
