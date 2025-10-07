import 'package:flutter/material.dart';

// Activity 1 and 8: Two screens demonstrating push() vs pushReplacement()

class PushDemoFirstScreen extends StatelessWidget {
  const PushDemoFirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Push Demo – First'),
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Navigate to the second screen using push() or pushReplacement().'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PushDemoSecondScreen()),
                );
              },
              child: const Text('Go to Second (push)'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const PushDemoSecondScreen()),
                );
              },
              child: const Text('Go to Second (pushReplacement)'),
            ),
          ],
        ),
      ),
    );
  }
}

class PushDemoSecondScreen extends StatelessWidget {
  const PushDemoSecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Push Demo – Second'),
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('This is the second screen.'),
            const SizedBox(height: 8),
            const Text(
              'Tip: If you arrived here via pushReplacement(), pressing back will not return to the first screen.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Activity 1: Demonstrate Navigator.pop()
                Navigator.pop(context);
              },
              child: const Text('Go Back (pop)'),
            ),
          ],
        ),
      ),
    );
  }
}