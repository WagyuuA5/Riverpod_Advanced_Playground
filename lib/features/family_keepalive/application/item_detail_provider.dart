import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/item_repository.dart';

part 'item_detail_provider.g.dart';

// Waktu cache dalam detik (5 menit = 300 detik, tapi kita pakai konstanta agar mudah diubah)
const cacheDurationSeconds = 300; 

@riverpod
class CacheTimer extends _$CacheTimer {
  Timer? _timer;

  @override
  int build(String id) {
    ref.onDispose(() {
      _timer?.cancel();
    });
    return -1; // -1 berarti belum dimulai / tidak aktif
  }

  void start(KeepAliveLink link) {
    state = cacheDurationSeconds;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state > 0) {
        state = state - 1;
      } else {
        timer.cancel();
        // Tutup keepAlive link agar data terhapus (ter-dispose)
        link.close();
      }
    });
  }
}

@riverpod
Future<String> itemDetail(ItemDetailRef ref, String id) async {
  // Tetap hidupkan state dari provider ini (jangan langsung auto-dispose)
  final link = ref.keepAlive();
  
  // Mulai hitung mundur (kombinasi Timer dan ref.keepAlive)
  ref.read(cacheTimerProvider(id).notifier).start(link);
  
  // Jika provider ini dihancurkan (misal waktu habis), batalkan timer
  ref.onDispose(() {
    ref.invalidate(cacheTimerProvider(id));
  });

  final repository = ref.watch(itemRepositoryProvider);
  return repository.fetchItemDetail(id);
}
