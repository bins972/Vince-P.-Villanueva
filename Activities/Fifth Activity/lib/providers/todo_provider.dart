import 'package:flutter/material.dart';

class TodoItem {
  final String id;
  final String title;
  bool done;

  TodoItem({required this.id, required this.title, this.done = false});
}

class ToDoProvider extends ChangeNotifier {
  final List<TodoItem> _items = [];

  List<TodoItem> get items => List.unmodifiable(_items);

  void add(String title) {
    _items.add(TodoItem(id: DateTime.now().millisecondsSinceEpoch.toString(), title: title));
    notifyListeners();
  }

  void toggle(String id) {
    final idx = _items.indexWhere((e) => e.id == id);
    if (idx != -1) {
      _items[idx].done = !_items[idx].done;
      notifyListeners();
    }
  }

  void remove(String id) {
    _items.removeWhere((e) => e.id == id);
    notifyListeners();
  }
}