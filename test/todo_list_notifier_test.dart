import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_advanced_playground/features/optimistic_mutation/application/todo_list_notifier.dart';
import 'package:riverpod_advanced_playground/features/optimistic_mutation/data/todo_model.dart';
import 'package:riverpod_advanced_playground/features/optimistic_mutation/data/todo_repository.dart';

class MockTodoRepository extends TodoRepository {
  bool failNextAdd = false;
  bool failNextDelete = false;

  @override
  Future<List<Todo>> fetchTodos() async {
    return [Todo(id: '1', title: 'Test 1'), Todo(id: '2', title: 'Test 2')];
  }

  @override
  Future<void> addTodo(Todo todo, {bool fail = false}) async {
    if (failNextAdd || fail) throw Exception('Mock Add Error');
  }

  @override
  Future<void> deleteTodo(String id, {bool fail = false}) async {
    if (failNextDelete || fail) throw Exception('Mock Delete Error');
  }
}

void main() {
  test('addTodo success and optimistic update', () async {
    final mockRepo = MockTodoRepository();
    final container = ProviderContainer(
      overrides: [todoRepositoryProvider.overrideWithValue(mockRepo)],
    );
    addTearDown(container.dispose);

    // Tunggu initial fetch
    await container.read(todoListProvider.future);

    expect(container.read(todoListProvider).value!.length, 2);

    // Tambah Todo
    await container.read(todoListProvider.notifier).addTodo('Tugas Baru');

    // Karena optimis, length langsung 3
    expect(container.read(todoListProvider).value!.length, 3);
    expect(container.read(todoListProvider).value!.last.title, 'Tugas Baru');
  });

  test('addTodo failure and rollback', () async {
    final mockRepo = MockTodoRepository();
    final container = ProviderContainer(
      overrides: [todoRepositoryProvider.overrideWithValue(mockRepo)],
    );
    addTearDown(container.dispose);

    await container.read(todoListProvider.future);
    expect(container.read(todoListProvider).value!.length, 2);

    // Tambah Todo dengan error
    try {
      await container
          .read(todoListProvider.notifier)
          .addTodo('Tugas Gagal', fail: true);
    } catch (e) {
      // expected error
    }

    // State harusnya rollback kembali ke 2
    expect(container.read(todoListProvider).value!.length, 2);
    // Tidak ada "Tugas Gagal"
    expect(
      container
          .read(todoListProvider)
          .value!
          .any((e) => e.title == 'Tugas Gagal'),
      isFalse,
    );
  });
}
