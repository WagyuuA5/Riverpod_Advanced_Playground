import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'todo_model.dart';

part 'todo_repository.g.dart';

class TodoRepository {
  Future<List<Todo>> fetchTodos() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      Todo(id: '1', title: 'Belajar Riverpod'),
      Todo(id: '2', title: 'Buat UI Optimistic'),
    ];
  }

  Future<void> addTodo(Todo todo, {bool fail = false}) async {
    await Future.delayed(const Duration(seconds: 1));
    if (fail) {
      throw Exception('Gagal menambahkan data ke server!');
    }
    // Success simulation
  }

  Future<void> deleteTodo(String id, {bool fail = false}) async {
    await Future.delayed(const Duration(seconds: 1));
    if (fail) {
      throw Exception('Gagal menghapus data dari server!');
    }
  }
}

@riverpod
TodoRepository todoRepository(TodoRepositoryRef ref) {
  return TodoRepository();
}
