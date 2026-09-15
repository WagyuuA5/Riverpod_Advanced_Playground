import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../application/random_number_provider.dart';

class LayarAScreen extends ConsumerWidget {
  const LayarAScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final randomNumber = ref.watch(randomNumberProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Layar A: Auto Dispose'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Angka random di bawah dibuat saat provider diinisialisasi.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              '$randomNumber',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                'Coba kembali ke layar sebelumnya, lalu buka layar ini lagi. Angka akan berubah karena provider di-dispose dan diinisialisasi ulang.',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
