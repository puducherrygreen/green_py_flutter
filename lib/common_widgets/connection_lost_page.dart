import 'package:flutter/material.dart';

class ConnectionLostPage extends StatelessWidget {
  const ConnectionLostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Check your Internet connection'),
      ),
    );
  }
}
