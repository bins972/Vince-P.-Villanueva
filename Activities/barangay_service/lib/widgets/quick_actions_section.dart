import 'package:flutter/material.dart';
import 'k_app_button.dart';
import 'custom_button.dart';
import '../views/gallery_page.dart';

class QuickActionsSection extends StatelessWidget {
  final VoidCallback onViewRequests;
  final VoidCallback onOpenServices;

  const QuickActionsSection({
    super.key,
    required this.onViewRequests,
    required this.onOpenServices,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        KAppButton(
          label: 'View My Requests',
          icon: Icons.history_rounded,
          onPressed: onViewRequests,
        ),
        KAppButton(
          label: 'Open Services',
          icon: Icons.apps_rounded,
          onPressed: onOpenServices,
        ),
        const SizedBox(height: 12),
        CustomButton(
          text: 'View Gallery',
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const GalleryPage(),
              ),
            );
          },
        ),
      ],
    );
  }
}