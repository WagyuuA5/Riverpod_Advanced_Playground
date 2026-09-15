import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../application/post_list_notifier.dart';

class LayarBScreen extends ConsumerWidget {
  const LayarBScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsAsync = ref.watch(postListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Layar B: Async Fetch'),
      ),
      body: postsAsync.when(
        data: (posts) {
          return RefreshIndicator(
            onRefresh: () async {
              // ref.invalidate memaksa provider untuk dibuang dan di-build ulang
              ref.invalidate(postListProvider);
            },
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return ListTile(
                  leading: CircleAvatar(child: Text('${post.id}')),
                  title: Text(post.title),
                  subtitle: Text(post.body, maxLines: 1, overflow: TextOverflow.ellipsis),
                );
              },
            ),
          );
        },
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Terjadi error:\n$error', textAlign: TextAlign.center),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.invalidate(postListProvider),
                child: const Text('Coba Lagi'),
              ),
            ],
          ),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
