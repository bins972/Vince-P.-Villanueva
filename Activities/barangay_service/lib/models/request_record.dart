import 'package:flutter/material.dart';

class RequestItem {
  final String id;
  final String serviceId;
  final String name;
  final String notes;
  final DateTime createdAt;

  RequestItem({
    required this.id,
    required this.serviceId,
    required this.name,
    required this.notes,
    required this.createdAt,
  });
}

class RequestStore extends ChangeNotifier {
  RequestStore._();
  static final RequestStore instance = RequestStore._();

  final List<RequestItem> _items = [];

  List<RequestItem> get items => List.unmodifiable(_items);

  void add(
      {required String serviceId, required String name, String notes = ''}) {
    _items.insert(
      0,
      RequestItem(
        id: UniqueKey().toString(),
        serviceId: serviceId,
        name: name,
        notes: notes,
        createdAt: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  void remove(String id) {
    _items.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
