import 'package:flutter/material.dart';

/// Scope that lets child pages switch the bottom-nav tab.
class AdaptiveNavScope extends InheritedWidget {
  final void Function(int index) goToTab;

  const AdaptiveNavScope({
    super.key,
    required this.goToTab,
    required Widget child,
  }) : super(child: child);

  static AdaptiveNavScope? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AdaptiveNavScope>();
  }

  @override
  bool updateShouldNotify(covariant AdaptiveNavScope oldWidget) =>
      oldWidget.goToTab != goToTab;
}

class AdaptiveScaffold extends StatefulWidget {
  final String title;
  final List<Widget> pages;
  final List<BottomNavigationBarItem> items;
  final int initialIndex;

  const AdaptiveScaffold({
    super.key,
    required this.title,
    required this.pages,
    required this.items,
    this.initialIndex = 0,
  });

  @override
  State<AdaptiveScaffold> createState() => _AdaptiveScaffoldState();
}

class _AdaptiveScaffoldState extends State<AdaptiveScaffold> {
  late int _index;

  @override
  void initState() {
    super.initState();
    _index = widget.initialIndex;
  }

  void _goTab(int i) => setState(() => _index = i);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      // Drawer: NAV ONLY (no Home/Services/Announcements duplicates)
      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [cs.primary, cs.primaryContainer],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Barangay Service',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: cs.onPrimary),
                  ),
                ),
              ),

              // keep only these items to avoid duplicating bottom nav:
              ListTile(
                leading: const Icon(Icons.history_rounded),
                title: const Text('My Requests'),
                onTap: () {
                  Navigator.pop(context);
                  _goTab(3);
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings_rounded),
                title: const Text('Settings'),
                onTap: () {
                  Navigator.pop(context);
                  _goTab(4);
                },
              ),
              ListTile(
                leading: const Icon(Icons.notifications_active_rounded),
                title: const Text('Notifications'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).pushNamed('/notifications');
                },
              ),
              ListTile(
                leading: const Icon(Icons.info_outline_rounded),
                title: const Text('About'),
                onTap: () {
                  Navigator.pop(context);
                  showAboutDialog(
                    context: context,
                    applicationName: 'Barangay Service',
                    applicationVersion: '1.0.0',
                  );
                },
              ),
            ],
          ),
        ),
      ),

      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: cs.surface,
        foregroundColor: cs.onSurface,
        actions: [
          // bell icon also goes to notifications
          IconButton(
            tooltip: 'Notifications',
            icon: const Icon(Icons.notifications_rounded),
            onPressed: () => Navigator.of(context).pushNamed('/notifications'),
          ),
        ],
      ),

      body: AdaptiveNavScope(
        goToTab: _goTab,
        child: SafeArea(child: widget.pages[_index]),
      ),

      // use Material 3 NavigationBar mapped from the provided items
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: _goTab,
        destinations: widget.items
            .map((e) =>
                NavigationDestination(icon: e.icon, label: e.label ?? ''))
            .toList(),
      ),
    );
  }
}
