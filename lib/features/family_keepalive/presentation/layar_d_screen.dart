import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../application/item_detail_provider.dart';

class LayarDScreen extends StatelessWidget {
  const LayarDScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final itemIds = ['101', '102', '103'];

    return Scaffold(
      appBar: AppBar(title: const Text('Layar D: Family & KeepAlive')),
      body: ListView.builder(
        itemCount: itemIds.length,
        itemBuilder: (context, index) {
          final id = itemIds[index];
          return ListTile(
            title: Text('Item $id'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ItemDetailScreen(id: id)),
              );
            },
          );
        },
      ),
    );
  }
}

class ItemDetailScreen extends ConsumerWidget {
  final String id;
  const ItemDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(itemDetailProvider(id));
    final remainingSeconds = ref.watch(cacheTimerProvider(id));

    return Scaffold(
      appBar: AppBar(title: Text('Detail Item $id')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (remainingSeconds > 0)
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.green.shade100,
                  child: Text('Cache aktif! Sisa waktu: $remainingSeconds detik', style: const TextStyle(fontWeight: FontWeight.bold)),
                )
              else if (remainingSeconds == 0)
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.red.shade100,
                  child: const Text('Cache expired, jika ditutup akan fetching ulang.', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              const SizedBox(height: 24),
              detailAsync.when(
                data: (data) => Text(data, textAlign: TextAlign.center, style: const TextStyle(fontSize: 18)),
                loading: () => const CircularProgressIndicator(),
                error: (err, stack) => Text('Error: $err'),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => ref.invalidate(itemDetailProvider(id)),
                child: const Text('Invalidate Cache Secara Manual'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
