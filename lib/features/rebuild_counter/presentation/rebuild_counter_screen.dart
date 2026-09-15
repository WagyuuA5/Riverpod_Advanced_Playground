import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../application/rebuild_counter_provider.dart';

class RebuildCounterScreen extends ConsumerWidget {
  const RebuildCounterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rebuild Counter Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Tekan tombol di bawah untuk mengubah State A atau State B.\nPerhatikan widget mana yang ikut ter-rebuild!',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => ref.read(counterDataNotifierProvider.notifier).incrementA(),
                  child: const Text('Tambah A'),
                ),
                ElevatedButton(
                  onPressed: () => ref.read(counterDataNotifierProvider.notifier).incrementB(),
                  child: const Text('Tambah B'),
                ),
              ],
            ),
            const Divider(height: 32),
            const Expanded(
              child: Row(
                children: [
                  Expanded(child: FullWatchWidget()),
                  SizedBox(width: 8),
                  Expanded(child: SelectAWatchWidget()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FullWatchWidget extends ConsumerStatefulWidget {
  const FullWatchWidget({super.key});
  @override
  ConsumerState<FullWatchWidget> createState() => _FullWatchWidgetState();
}

class _FullWatchWidgetState extends ConsumerState<FullWatchWidget> {
  int _buildCount = 0;

  @override
  Widget build(BuildContext context) {
    _buildCount++;
    // Mengamati seluruh perubahan state (A dan B)
    final state = ref.watch(counterDataNotifierProvider);

    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.red.shade100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('ref.watch(provider)', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('Build count:\n$_buildCount', textAlign: TextAlign.center, style: const TextStyle(fontSize: 24, color: Colors.red)),
          const SizedBox(height: 16),
          Text('State A: ${state.countA}'),
          Text('State B: ${state.countB}'),
        ],
      ),
    );
  }
}

class SelectAWatchWidget extends ConsumerStatefulWidget {
  const SelectAWatchWidget({super.key});
  @override
  ConsumerState<SelectAWatchWidget> createState() => _SelectAWatchWidgetState();
}

class _SelectAWatchWidgetState extends ConsumerState<SelectAWatchWidget> {
  int _buildCount = 0;

  @override
  Widget build(BuildContext context) {
    _buildCount++;
    // HANYA mengamati perubahan pada State A
    final countA = ref.watch(counterDataNotifierProvider.select((s) => s.countA));

    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.green.shade100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('select((s) => s.A)', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('Build count:\n$_buildCount', textAlign: TextAlign.center, style: const TextStyle(fontSize: 24, color: Colors.green)),
          const SizedBox(height: 16),
          Text('State A: $countA'),
          const Text('State B: (diabaikan)'),
        ],
      ),
    );
  }
}
