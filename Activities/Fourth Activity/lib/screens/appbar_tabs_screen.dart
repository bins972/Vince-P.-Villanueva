import 'package:flutter/material.dart';

// Activity 9: TabBar inside AppBar with three tabs (Chats, Status, Calls)
class AppBarTabsScreen extends StatelessWidget {
  const AppBarTabsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Messaging'),
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Chats', icon: Icon(Icons.chat_bubble)),
              Tab(text: 'Status', icon: Icon(Icons.circle_notifications)),
              Tab(text: 'Calls', icon: Icon(Icons.call)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(child: Text('Chats list goes here')),
            Center(child: Text('Status updates go here')),
            Center(child: Text('Call history goes here')),
          ],
        ),
      ),
    );
  }
}