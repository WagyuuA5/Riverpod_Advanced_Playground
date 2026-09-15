import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'post_model.dart';

part 'post_repository.g.dart';

class PostRepository {
  final Dio _dio;

  PostRepository(this._dio);

  Future<List<Post>> fetchPosts() async {
    // Simulasi network delay
    await Future.delayed(const Duration(seconds: 1));
    
    final response = await _dio.get('https://jsonplaceholder.typicode.com/posts');
    
    if (response.statusCode == 200) {
      final List data = response.data;
      return data.map((e) => Post.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch posts');
    }
  }
}

@riverpod
Dio dio(DioRef ref) {
  return Dio();
}

@riverpod
PostRepository postRepository(PostRepositoryRef ref) {
  return PostRepository(ref.watch(dioProvider));
}
