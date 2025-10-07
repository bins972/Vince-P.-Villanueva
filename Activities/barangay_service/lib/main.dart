import 'package:flutter/material.dart';

import 'widgets/adaptive_scaffold.dart';
import 'views/home_page.dart';
import 'views/services_page.dart';
import 'views/announcements_page.dart';
import 'views/requests_page.dart';
import 'views/request_form_page.dart';
import 'views/settings_page.dart';
import 'views/services_list_page.dart';
import 'views/notifications_page.dart'; // 🔔 NEW

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const BarangayApp());
}

class BarangayApp extends StatelessWidget {
  const BarangayApp({super.key});

  @override
  Widget build(BuildContext context) {
    final light = ColorScheme.fromSeed(seedColor: const Color(0xFF2563EB));
    final dark = ColorScheme.fromSeed(
      seedColor: const Color(0xFF2563EB),
      brightness: Brightness.dark,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Barangay Service',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: light,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: dark,
      ),
      routes: {
        '/': (_) => const Shell(),
        '/request': (_) => const RequestFormPage(),
        '/all-services': (_) => const ServicesListPage(),
        '/notifications': (_) => const NotificationsPage(), // 🔔
      },
    );
  }
}

class Shell extends StatefulWidget {
  const Shell({super.key});
  @override
  State<Shell> createState() => _ShellState();
}

class _ShellState extends State<Shell> {
  final _pages = const [
    HomePage(),
    ServicesPage(),
    AnnouncementsPage(),
    RequestsPage(),
    SettingsPage(),
  ];

  final _items = const [
    BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.apps_rounded), label: 'Services'),
    BottomNavigationBarItem(icon: Icon(Icons.campaign_rounded), label: 'News'),
    BottomNavigationBarItem(
        icon: Icon(Icons.history_rounded), label: 'Requests'),
    BottomNavigationBarItem(
        icon: Icon(Icons.settings_rounded), label: 'Settings'),
  ];

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      title: 'Barangay Service',
      pages: _pages,
      items: _items,
      initialIndex: 0,
    );
  }
}
