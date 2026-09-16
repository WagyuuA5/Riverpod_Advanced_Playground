import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'item_repository.g.dart';

class ItemRepository {
  Future<String> fetchItemDetail(String id) async {
    // Simulasi loading
    await Future.delayed(const Duration(seconds: 2));
    return 'Detail lengkap untuk item $id (Diambil pada ${DateTime.now().toLocal()})';
  }
}

@riverpod
ItemRepository itemRepository(ItemRepositoryRef ref) {
  return ItemRepository();
}
