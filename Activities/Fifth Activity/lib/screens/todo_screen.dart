import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todo_provider.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<ToDoProvider>().items;
    return Scaffold(
      appBar: AppBar(title: const Text('Customer To-Do')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(hintText: 'Add a task...'),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    final text = _controller.text.trim();
                    if (text.isNotEmpty) {
                      context.read<ToDoProvider>().add(text);
                      _controller.clear();
                    }
                  },
                  child: const Text('Add'),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final item = todos[index];
                return ListTile(
                  leading: Icon(item.done ? Icons.check_circle : Icons.circle_outlined, color: item.done ? Colors.green : null),
                  title: Text(
                    item.title,
                    style: TextStyle(decoration: item.done ? TextDecoration.lineThrough : TextDecoration.none),
                  ),
                  onTap: () => context.read<ToDoProvider>().toggle(item.id),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () => context.read<ToDoProvider>().remove(item.id),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}