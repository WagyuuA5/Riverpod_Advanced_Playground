import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../application/todo_list_notifier.dart';

class LayarCScreen extends ConsumerWidget {
  const LayarCScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todosAsync = ref.watch(todoListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Layar C: Optimistic Mutation'),
      ),
      body: todosAsync.when(
        data: (todos) {
          if (todos.isEmpty) {
            return const Center(child: Text('Tidak ada tugas.'));
          }
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return ListTile(
                title: Text(todo.title),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        try {
                          // Hapus dengan status sukses
                          await ref.read(todoListProvider.notifier).deleteTodo(todo.id, fail: false);
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                          }
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.error_outline, color: Colors.orange),
                      tooltip: 'Simulasi Gagal Hapus',
                      onPressed: () async {
                        try {
                          // Simulasi gagal
                          await ref.read(todoListProvider.notifier).deleteTodo(todo.id, fail: true);
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                          }
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'btn1',
            onPressed: () async {
              try {
                await ref.read(todoListProvider.notifier).addTodo('Tugas Baru', fail: false);
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                }
              }
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            heroTag: 'btn2',
            backgroundColor: Colors.orange,
            tooltip: 'Tambah (Gagal)',
            onPressed: () async {
              try {
                await ref.read(todoListProvider.notifier).addTodo('Tugas Gagal', fail: true);
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                }
              }
            },
            child: const Icon(Icons.warning_amber),
          ),
        ],
      ),
    );
  }
}
