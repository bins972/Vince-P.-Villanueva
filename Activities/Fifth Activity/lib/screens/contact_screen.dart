import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contact')),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('Contact us at support@example.com.'),
        ),
      ),
    );
  }
}