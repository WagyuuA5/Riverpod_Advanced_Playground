# Riverpod Advanced Playground

[![Flutter CI](https://github.com/WagyuuA5/Riverpod_Advanced_Playground/actions/workflows/ci.yml/badge.svg)](https://github.com/WagyuuA5/Riverpod_Advanced_Playground/actions/workflows/ci.yml)

Project ini bertujuan mendemonstrasikan penggunaan Riverpod versi modern (dengan code generation via `riverpod_generator`) secara mendalam, bukan sekadar aplikasi counter sederhana.

## ?? Cara Menjalankan Project

Ikuti langkah-langkah berikut untuk menjalankan aplikasi di mesin lokal Anda:

1. Dapatkan semua *dependencies*:
   ```bash
   flutter pub get
   ```
2. Generate file `.g.dart` untuk Riverpod:
   ```bash
   dart run build_runner build -d
   ```
3. Jalankan aplikasi:
   ```bash
   flutter run
   ```

---

## ??? Panduan Konsep & File Pendukung

Project ini terbagi dalam 5 layar (Layar A - E) ditambah dengan layar khusus Rebuild Counter.

| Konsep Riverpod | File Utama | Kenapa Dipakai? |
| --- | --- | --- |
| **Auto Dispose Default** (Layar A) | `random_number_provider.dart`, `layar_a_screen.dart` | Menunjukkan bahwa *code generation* Riverpod membekali provider dengan *autoDispose* secara otomatis (menghemat memori). |
| **Async Fetch & Pull-to-Refresh** (Layar B) | `post_list_notifier.dart`, `layar_b_screen.dart` | Mengambil data dari internet (API) via Dio. Menangani *loading*, *error*, dan *data* menggunakan `AsyncValue.when`, serta memuat ulang data dengan `ref.invalidate()`. |
| **Optimistic Mutation** (Layar C) | `todo_list_notifier.dart`, `layar_c_screen.dart` | Mendemonstrasikan pengalaman pengguna (UX) yang sangat cepat karena layar ter-update sebelum *request API* selesai. Jika gagal, provider mendeteksi *exception* dan otomatis mengembalikan data (*rollback*). |
| **Family & KeepAlive** (Layar D) | `item_detail_provider.dart`, `layar_d_screen.dart` | Mengambil data detail dengan mengirim argumen ID (`Family`), lalu mempertahankan memori (mencegah *autoDispose*) menggunakan `ref.keepAlive()` dan dibatasi *timeout timer* 5 menit. |
| **Dependent Providers & Select** (Layar E) | `dependent_providers.dart`, `layar_e_screen.dart` | Mendemonstrasikan satu provider yang memantau (`ref.watch`) provider lainnya untuk membuat filter *list*, serta cara `ref.watch(provider.select())` bekerja untuk mengurangi frekuensi rebuild. |
| **Rebuild Counter** (Spesial) | `rebuild_counter_screen.dart`, `rebuild_counter_provider.dart` | Pembuktian langsung (angka yang tampil) bahwa fungsi `.select()` berhasil mencegah *build()* pada widget ketika properti yang diubah bukan yang dipantau oleh layar. |

---

## ?? Riverpod Lama vs Generator

Berikut adalah sedikit perbandingan bagaimana *Code Generation* (`riverpod_generator`) membuat penulisan *State Management* jauh lebih sederhana dibandingkan Riverpod tanpa generator.

### Contoh 1: Provider Biasa (Sync)
**Sebelum Generator:**
```dart
final randomNumberProvider = Provider.autoDispose<int>((ref) {
  return Random().nextInt(1000);
});
```
**Sesudah Generator:**
```dart
@riverpod
int randomNumber(RandomNumberRef ref) {
  return Random().nextInt(1000);
}
```

### Contoh 2: Async Notifier
**Sebelum Generator (`StateNotifierProvider` lama):**
```dart
class PostListNotifier extends StateNotifier<AsyncValue<List<Post>>> {
  PostListNotifier(this.ref) : super(const AsyncValue.loading()) {
    fetch();
  }
  final Ref ref;

  Future<void> fetch() async {
    try {
      final repo = ref.read(postRepositoryProvider);
      final data = await repo.fetchPosts();
      state = AsyncValue.data(data);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final postListProvider = StateNotifierProvider.autoDispose<PostListNotifier, AsyncValue<List<Post>>>((ref) {
  return PostListNotifier(ref);
});
```
**Sesudah Generator (`AsyncNotifier`):**
```dart
@riverpod
class PostList extends _$PostList {
  @override
  Future<List<Post>> build() async {
    final repo = ref.watch(postRepositoryProvider);
    return repo.fetchPosts();
  }
  // Tidak perlu boilerplate penangkapan error try-catch!
}
```

---

## ?? Screenshots / Demo Layar

*(Catatan: Silakan ganti placeholder berikut dengan screenshot hasil run Anda di perangkat/simulator)*

1. **Layar A: Auto Dispose Default**
   ![Layar A Screenshot](docs/screenshots/layar_a.png)
2. **Layar B: Async Fetch & Refresh**
   ![Layar B Screenshot](docs/screenshots/layar_b.png)
3. **Layar C: Optimistic Mutation**
   ![Layar C Screenshot](docs/screenshots/layar_c.png)
4. **Layar D: Family & KeepAlive**
   ![Layar D Screenshot](docs/screenshots/layar_d.png)
5. **Layar E: Dependent & Select**
   ![Layar E Screenshot](docs/screenshots/layar_e.png)
6. **Halaman Rebuild Counter**
   ![Rebuild Counter Screenshot](docs/screenshots/rebuild_counter.png)

