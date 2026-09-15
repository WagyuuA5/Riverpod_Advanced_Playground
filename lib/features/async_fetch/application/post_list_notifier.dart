import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/post_model.dart';
import '../data/post_repository.dart';

part 'post_list_notifier.g.dart';

@riverpod
class PostList extends _$PostList {
  @override
  Future<List<Post>> build() async {
    final repository = ref.watch(postRepositoryProvider);
    return repository.fetchPosts();
  }
}
