import 'package:flutter/material.dart';

class PushAScreen extends StatelessWidget {
  const PushAScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Push A')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Screen A'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/pushB'),
              child: const Text('Go to B (push)'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => Navigator.pushReplacementNamed(context, '/pushB'),
              child: const Text('Go to B (pushReplacement)'),
            ),
          ],
        ),
      ),
    );
  }
}