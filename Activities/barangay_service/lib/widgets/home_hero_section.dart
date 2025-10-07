import 'package:flutter/material.dart';

class HomeHeroSection extends StatelessWidget {
  final TextEditingController searchController;
  final VoidCallback onSearchSubmitted;
  final VoidCallback onRequestService;
  final VoidCallback onOpenServices;

  const HomeHeroSection({
    super.key,
    required this.searchController,
    required this.onSearchSubmitted,
    required this.onRequestService,
    required this.onOpenServices,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [cs.primary, cs.primaryContainer],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Barangay Service',
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: cs.onPrimary),
          ),
          const SizedBox(height: 6),
          Text(
            'Request documents, view announcements, and manage your records in one place.',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: cs.onPrimary.withValues(alpha: 0.90)),
          ),
          const SizedBox(height: 16),
          _buildSearchField(context, cs),
          const SizedBox(height: 12),
          _buildActionButtons(context, cs),
        ],
      ),
    );
  }

  Widget _buildSearchField(BuildContext context, ColorScheme cs) {
    return Container(
      decoration: BoxDecoration(
        color: cs.onPrimary.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextField(
        controller: searchController,
        style: TextStyle(color: cs.onPrimary),
        cursorColor: cs.onPrimary,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          icon: Icon(Icons.search_rounded, color: cs.onPrimary),
          hintText: 'Search services (e.g. clearance)',
          hintStyle: TextStyle(color: cs.onPrimary.withValues(alpha: 0.85)),
          border: InputBorder.none,
        ),
        onSubmitted: (_) => onSearchSubmitted(),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, ColorScheme cs) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 48,
            child: FilledButton.icon(
              onPressed: onRequestService,
              icon: const Icon(Icons.edit_document),
              label: const Text('Request a Service'),
              style: FilledButton.styleFrom(
                backgroundColor: cs.onPrimary,
                foregroundColor: cs.primary,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: SizedBox(
            height: 48,
            child: ElevatedButton.icon(
              onPressed: onOpenServices,
              icon: const Icon(Icons.apps_rounded),
              label: const Text('Open Services'),
            ),
          ),
        ),
      ],
    );
  }
}