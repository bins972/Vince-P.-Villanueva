import 'package:flutter/material.dart';
import '../widgets/adaptive_scaffold.dart';
import '../widgets/home_hero_section.dart';
import '../widgets/quick_actions_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _homeSearch = TextEditingController();

  @override
  void dispose() {
    _homeSearch.dispose();
    super.dispose();
  }

  void _openAllServicesDirect() {
    Navigator.of(context).pushNamed('/all-services');
  }

  void _viewMyRequests() {
    // Switch to the Requests tab (index 3) using the scope.
    AdaptiveNavScope.of(context)?.goToTab(3);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return SafeArea(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // HERO
          HomeHeroSection(
            searchController: _homeSearch,
            onSearchSubmitted: _openAllServicesDirect,
            onRequestService: () => Navigator.of(context).pushNamed('/request'),
            onOpenServices: _openAllServicesDirect,
          ),

          // CONTENT
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _StatRow(),
                const SizedBox(height: 16),
                QuickActionsSection(
                  onViewRequests: _viewMyRequests,
                  onOpenServices: _openAllServicesDirect,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
            child: _StatCard(
                icon: Icons.verified_user_rounded,
                label: 'Trusted',
                value: 'Official')),
        SizedBox(width: 12),
        Expanded(
            child: _StatCard(
                icon: Icons.timer_rounded,
                label: 'Avg. time',
                value: '~15 min')),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StatCard(
      {required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.4)),
        boxShadow: [
          BoxShadow(
              color: cs.shadow.withValues(alpha: 0.04),
              blurRadius: 16,
              offset: const Offset(0, 8))
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
                color: cs.primaryContainer,
                borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: cs.onPrimaryContainer),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: cs.onSurfaceVariant)),
              Text(value, style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ],
      ),
    );
  }
}
