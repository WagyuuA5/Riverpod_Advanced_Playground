import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_advanced_playground/features/async_fetch/application/post_list_notifier.dart';
import 'package:riverpod_advanced_playground/features/async_fetch/data/post_model.dart';
import 'package:riverpod_advanced_playground/features/async_fetch/data/post_repository.dart';
import 'package:dio/dio.dart';

// Manual mock
class MockPostRepository extends PostRepository {
  final bool shouldFail;
  
  MockPostRepository({this.shouldFail = false}) : super(Dio());

  @override
  Future<List<Post>> fetchPosts() async {
    if (shouldFail) {
      throw Exception('Failed to fetch from Mock');
    }
    return [
      Post(id: 1, title: 'Mock Title 1', body: 'Mock Body 1'),
      Post(id: 2, title: 'Mock Title 2', body: 'Mock Body 2'),
    ];
  }
}

void main() {
  test('fetchPosts success state', () async {
    final container = ProviderContainer(
      overrides: [
        postRepositoryProvider.overrideWithValue(MockPostRepository(shouldFail: false)),
      ],
    );
    addTearDown(container.dispose);

    // Initial state is loading
    expect(
      container.read(postListProvider),
      const AsyncValue<List<Post>>.loading(),
    );

    // Await for data
    final data = await container.read(postListProvider.future);
    expect(data.length, 2);
    expect(data.first.title, 'Mock Title 1');
  });

  test('fetchPosts error state', () async {
    final container = ProviderContainer(
      overrides: [
        postRepositoryProvider.overrideWithValue(MockPostRepository(shouldFail: true)),
      ],
    );
    addTearDown(container.dispose);

    await expectLater(
      container.read(postListProvider.future),
      throwsA(isA<Exception>()),
    );
    
    expect(
      container.read(postListProvider).hasError,
      isTrue,
    );
  });
}
