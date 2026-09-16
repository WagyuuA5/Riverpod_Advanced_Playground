import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../application/dependent_providers.dart';

class LayarEScreen extends ConsumerWidget {
  const LayarEScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch dependent provider
    final products = ref.watch(filteredProductsProvider);
    final currentFilter = ref.watch(productFilterProvider);

    // Untuk demo select, kita ambil statenya untuk button counter
    final userFull = ref.watch(userProfileProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Layar E: Dependent & Select')),
      body: Column(
        children: [
          // Filter section
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 8.0,
              children: ['Semua', 'Elektronik', 'Pakaian', 'Perabotan'].map((
                cat,
              ) {
                return ChoiceChip(
                  label: Text(cat),
                  selected: currentFilter == cat,
                  onSelected: (selected) {
                    if (selected) {
                      ref.read(productFilterProvider.notifier).setFilter(cat);
                    }
                  },
                );
              }).toList(),
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final p = products[index];
                return ListTile(
                  title: Text(p.name),
                  subtitle: Text(p.category),
                );
              },
            ),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Demo select()',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          const UserNameWidget(), // Widget ini menggunakan select()
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('View Count (full watch): ${userFull.viewCount}'),
                ElevatedButton(
                  onPressed: () =>
                      ref.read(userProfileProvider.notifier).incrementView(),
                  child: const Text('Tambah View'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                final newName = userFull.name == 'Budi' ? 'Andi' : 'Budi';
                ref.read(userProfileProvider.notifier).changeName(newName);
              },
              child: const Text('Ganti Nama'),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget terpisah untuk membuktikan select()
class UserNameWidget extends ConsumerWidget {
  const UserNameWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Menggunakan select agar hanya rebuild saat 'name' berubah,
    // MENGABAIKAN perubahan 'viewCount'.
    final userName = ref.watch(userProfileProvider.select((user) => user.name));

    // Print ini hanya akan terpanggil di console saat widget di-rebuild.
    debugPrint('Building UserNameWidget dengan nama: $userName');

    return Container(
      padding: const EdgeInsets.all(12),
      color: Colors.blue.shade100,
      child: Text(
        'Nama User (Select): $userName\n(Cek console: tidak rebuild jika hanya view yang bertambah)',
        textAlign: TextAlign.center,
      ),
    );
  }
}
