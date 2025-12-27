import 'package:flutter/material.dart';

class RecentPlaysScreen extends StatelessWidget {
  const RecentPlaysScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recent Plays')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('No recent plays found.'),
            Text('Start listening to build your history!'),
          ],
        ),
      ),
    );
  }
}
