import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import 'counter_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  void _logout(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Logged out (demo only, no login yet)')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: ListTile(
            leading: const Icon(Icons.person_rounded),
            title: const Text('Profile'),
            subtitle: const Text('Demo user'),
            onTap: () {},
          ),
        ),
        const SizedBox(height: 8),
        Card(
          child: ListTile(
            leading: const Icon(Icons.help_center_rounded),
            title: const Text('About'),
            onTap: () => showAboutDialog(
              context: context,
              applicationName: 'Barangay Service',
              applicationVersion: '1.0.0',
            ),
          ),
        ),
        const SizedBox(height: 8),
        Card(
          child: ListTile(
            leading: const Icon(Icons.logout_rounded),
            title: const Text('Log out'),
            onTap: () => _logout(context),
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: CustomButton(
            text: 'Demo Counter',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CounterPage(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
