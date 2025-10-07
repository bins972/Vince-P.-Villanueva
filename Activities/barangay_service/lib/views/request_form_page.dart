import 'package:flutter/material.dart';
import '../services/request_store.dart';
import '../services/data_service.dart';
import '../models/service.dart';

class RequestFormPage extends StatefulWidget {
  const RequestFormPage({super.key});

  @override
  State<RequestFormPage> createState() => _RequestFormPageState();
}

class _RequestFormPageState extends State<RequestFormPage> {
  final _name = TextEditingController();
  final _notes = TextEditingController();
  String? _serviceId;

  late final List<Service> _services;

  @override
  void initState() {
    super.initState();
    _services = DataService.getServices();
    _serviceId = _services.first.id;
  }

  @override
  void dispose() {
    _name.dispose();
    _notes.dispose();
    super.dispose();
  }

  void _submit() {
    if ((_name.text.trim()).isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Enter your name')));
      return;
    }
    RequestStore.instance.add(
      serviceId: _serviceId!,
      name: _name.text.trim(),
      notes: _notes.text.trim(),
    );
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Request submitted')));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Request a Service')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: 'Service'),
            value: _serviceId,
            items: _services
                .map((s) => DropdownMenuItem(value: s.id, child: Text(s.title)))
                .toList(),
            onChanged: (v) => setState(() => _serviceId = v),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _name,
            decoration: const InputDecoration(labelText: 'Your Name'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _notes,
            decoration: const InputDecoration(labelText: 'Notes (optional)'),
            minLines: 3,
            maxLines: 5,
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 48,
            child: ElevatedButton.icon(
              onPressed: _submit,
              icon: const Icon(Icons.send_rounded),
              label: const Text('Submit Request'),
              style: ElevatedButton.styleFrom(
                backgroundColor: cs.primary,
                foregroundColor: cs.onPrimary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
