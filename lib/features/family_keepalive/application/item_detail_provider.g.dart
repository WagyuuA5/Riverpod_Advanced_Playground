// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$itemDetailHash() => r'b718f0efe10edc7eb137b20827332a3df598f6d5';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [itemDetail].
@ProviderFor(itemDetail)
const itemDetailProvider = ItemDetailFamily();

/// See also [itemDetail].
class ItemDetailFamily extends Family<AsyncValue<String>> {
  /// See also [itemDetail].
  const ItemDetailFamily();

  /// See also [itemDetail].
  ItemDetailProvider call(
    String id,
  ) {
    return ItemDetailProvider(
      id,
    );
  }

  @override
  ItemDetailProvider getProviderOverride(
    covariant ItemDetailProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'itemDetailProvider';
}

/// See also [itemDetail].
class ItemDetailProvider extends AutoDisposeFutureProvider<String> {
  /// See also [itemDetail].
  ItemDetailProvider(
    String id,
  ) : this._internal(
          (ref) => itemDetail(
            ref as ItemDetailRef,
            id,
          ),
          from: itemDetailProvider,
          name: r'itemDetailProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$itemDetailHash,
          dependencies: ItemDetailFamily._dependencies,
          allTransitiveDependencies:
              ItemDetailFamily._allTransitiveDependencies,
          id: id,
        );

  ItemDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<String> Function(ItemDetailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ItemDetailProvider._internal(
        (ref) => create(ref as ItemDetailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<String> createElement() {
    return _ItemDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ItemDetailProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ItemDetailRef on AutoDisposeFutureProviderRef<String> {
  /// The parameter `id` of this provider.
  String get id;
}

class _ItemDetailProviderElement
    extends AutoDisposeFutureProviderElement<String> with ItemDetailRef {
  _ItemDetailProviderElement(super.provider);

  @override
  String get id => (origin as ItemDetailProvider).id;
}

String _$cacheTimerHash() => r'18e1c6645f7991f16e36bfc66808439b0feabba9';

abstract class _$CacheTimer extends BuildlessAutoDisposeNotifier<int> {
  late final String id;

  int build(
    String id,
  );
}

/// See also [CacheTimer].
@ProviderFor(CacheTimer)
const cacheTimerProvider = CacheTimerFamily();

/// See also [CacheTimer].
class CacheTimerFamily extends Family<int> {
  /// See also [CacheTimer].
  const CacheTimerFamily();

  /// See also [CacheTimer].
  CacheTimerProvider call(
    String id,
  ) {
    return CacheTimerProvider(
      id,
    );
  }

  @override
  CacheTimerProvider getProviderOverride(
    covariant CacheTimerProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'cacheTimerProvider';
}

/// See also [CacheTimer].
class CacheTimerProvider
    extends AutoDisposeNotifierProviderImpl<CacheTimer, int> {
  /// See also [CacheTimer].
  CacheTimerProvider(
    String id,
  ) : this._internal(
          () => CacheTimer()..id = id,
          from: cacheTimerProvider,
          name: r'cacheTimerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$cacheTimerHash,
          dependencies: CacheTimerFamily._dependencies,
          allTransitiveDependencies:
              CacheTimerFamily._allTransitiveDependencies,
          id: id,
        );

  CacheTimerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  int runNotifierBuild(
    covariant CacheTimer notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(CacheTimer Function() create) {
    return ProviderOverride(
      origin: this,
      override: CacheTimerProvider._internal(
        () => create()..id = id,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<CacheTimer, int> createElement() {
    return _CacheTimerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CacheTimerProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CacheTimerRef on AutoDisposeNotifierProviderRef<int> {
  /// The parameter `id` of this provider.
  String get id;
}

class _CacheTimerProviderElement
    extends AutoDisposeNotifierProviderElement<CacheTimer, int>
    with CacheTimerRef {
  _CacheTimerProviderElement(super.provider);

  @override
  String get id => (origin as CacheTimerProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
