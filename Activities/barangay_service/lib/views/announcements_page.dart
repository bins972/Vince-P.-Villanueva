import 'package:flutter/material.dart';
import '../services/data_service.dart';
import '../widgets/announcement_tile.dart';
import '../models/announcement.dart';

class AnnouncementsPage extends StatelessWidget {
  const AnnouncementsPage({Key? key});

  @override
  Widget build(BuildContext context) {
    final List<Announcement> list = DataService.getAnnouncements();

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemBuilder: (_, i) => AnnouncementTile(announcement: list[i]),
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemCount: list.length,
    );
  }
}
