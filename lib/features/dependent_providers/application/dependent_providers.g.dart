// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dependent_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productsHash() => r'9da8e8571383b49565e0a4bd33454ad45a2ff6d7';

/// See also [products].
@ProviderFor(products)
final productsProvider = AutoDisposeProvider<List<Product>>.internal(
  products,
  name: r'productsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$productsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ProductsRef = AutoDisposeProviderRef<List<Product>>;
String _$filteredProductsHash() => r'8382a5013fa3b2dce720b583e2372354dd416ede';

/// See also [filteredProducts].
@ProviderFor(filteredProducts)
final filteredProductsProvider = AutoDisposeProvider<List<Product>>.internal(
  filteredProducts,
  name: r'filteredProductsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$filteredProductsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FilteredProductsRef = AutoDisposeProviderRef<List<Product>>;
String _$productFilterHash() => r'6ed09e70e69929e3747600594c93bb9537e1facd';

/// See also [ProductFilter].
@ProviderFor(ProductFilter)
final productFilterProvider =
    AutoDisposeNotifierProvider<ProductFilter, String>.internal(
  ProductFilter.new,
  name: r'productFilterProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$productFilterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ProductFilter = AutoDisposeNotifier<String>;
String _$userProfileHash() => r'11c109689c636cc290b073802d15fcf84ec202f5';

/// See also [UserProfile].
@ProviderFor(UserProfile)
final userProfileProvider =
    AutoDisposeNotifierProvider<UserProfile, User>.internal(
  UserProfile.new,
  name: r'userProfileProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userProfileHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UserProfile = AutoDisposeNotifier<User>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
