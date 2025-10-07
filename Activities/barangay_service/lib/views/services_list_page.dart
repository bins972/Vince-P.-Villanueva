import 'package:flutter/material.dart';
import '../services/data_service.dart';
import '../widgets/service_card.dart';
import '../models/service.dart';

class ServicesListPage extends StatefulWidget {
  const ServicesListPage({super.key});

  @override
  State<ServicesListPage> createState() => _ServicesListPageState();
}

class _ServicesListPageState extends State<ServicesListPage> {
  late final List<Service> _all;

  @override
  void initState() {
    super.initState();
    _all = DataService.getServices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Services')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemBuilder: (_, i) => ServiceCard(
          s: _all[i],
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Selected: ${_all[i].title}')),
            );
          },
        ),
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemCount: _all.length,
      ),
    );
  }
}
