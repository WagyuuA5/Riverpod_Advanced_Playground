import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/models.dart';

part 'dependent_providers.g.dart';

// 1. Data Mentah
@riverpod
List<Product> products(ProductsRef ref) {
  return const [
    Product(id: '1', name: 'Laptop', category: 'Elektronik'),
    Product(id: '2', name: 'Kemeja', category: 'Pakaian'),
    Product(id: '3', name: 'Smartphone', category: 'Elektronik'),
    Product(id: '4', name: 'Celana Jeans', category: 'Pakaian'),
    Product(id: '5', name: 'Sofa', category: 'Perabotan'),
  ];
}

// 2. Filter State
@riverpod
class ProductFilter extends _$ProductFilter {
  @override
  String build() => 'Semua';

  void setFilter(String category) {
    state = category;
  }
}

// 3. Dependent Provider (Bergantung pada products dan productFilter)
@riverpod
List<Product> filteredProducts(FilteredProductsRef ref) {
  final allProducts = ref.watch(productsProvider);
  final filter = ref.watch(productFilterProvider);

  if (filter == 'Semua') return allProducts;

  return allProducts.where((p) => p.category == filter).toList();
}

// ==========================================
// Demo select()
// ==========================================
@riverpod
class UserProfile extends _$UserProfile {
  @override
  User build() => const User(name: 'Budi', viewCount: 0);

  void incrementView() {
    state = state.copyWith(viewCount: state.viewCount + 1);
  }

  void changeName(String newName) {
    state = state.copyWith(name: newName);
  }
}
