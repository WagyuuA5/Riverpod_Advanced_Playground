import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/todo_model.dart';
import '../data/todo_repository.dart';

part 'todo_list_notifier.g.dart';

@riverpod
class TodoList extends _$TodoList {
  @override
  Future<List<Todo>> build() async {
    final repo = ref.watch(todoRepositoryProvider);
    return repo.fetchTodos();
  }

  Future<void> addTodo(String title, {bool fail = false}) async {
    final repo = ref.read(todoRepositoryProvider);
    final newTodo = Todo(id: DateTime.now().millisecondsSinceEpoch.toString(), title: title);
    
    // Backup state sebelum optimis update
    final previousState = state;
    
    // Optimistic Update: Langsung tambahkan ke list UI
    if (state.value != null) {
      state = AsyncData([...state.value!, newTodo]);
    }

    try {
      await repo.addTodo(newTodo, fail: fail);
    } catch (e) {
      // Rollback jika terjadi error
      state = previousState;
      // Re-throw untuk ditangkap oleh UI (SnackBar)
      throw Exception('Rollback terjadi: $e');
    }
  }

  Future<void> deleteTodo(String id, {bool fail = false}) async {
    final repo = ref.read(todoRepositoryProvider);
    
    // Backup state sebelum optimis update
    final previousState = state;
    
    // Optimistic Update: Langsung hapus dari list UI
    if (state.value != null) {
      state = AsyncData(state.value!.where((todo) => todo.id != id).toList());
    }

    try {
      await repo.deleteTodo(id, fail: fail);
    } catch (e) {
      // Rollback
      state = previousState;
      throw Exception('Rollback terjadi: $e');
    }
  }
}
