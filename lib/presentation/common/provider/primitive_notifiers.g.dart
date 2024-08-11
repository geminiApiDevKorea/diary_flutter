// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'primitive_notifiers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$stringNotifierHash() => r'4598b632037f2429a2c10036bec3a88904ab6fe4';

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

abstract class _$StringNotifier extends BuildlessAutoDisposeNotifier<String> {
  late final String key;

  String build({
    required String key,
  });
}

/// See also [StringNotifier].
@ProviderFor(StringNotifier)
const stringNotifierProvider = StringNotifierFamily();

/// See also [StringNotifier].
class StringNotifierFamily extends Family<String> {
  /// See also [StringNotifier].
  const StringNotifierFamily();

  /// See also [StringNotifier].
  StringNotifierProvider call({
    required String key,
  }) {
    return StringNotifierProvider(
      key: key,
    );
  }

  @override
  StringNotifierProvider getProviderOverride(
    covariant StringNotifierProvider provider,
  ) {
    return call(
      key: provider.key,
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
  String? get name => r'stringNotifierProvider';
}

/// See also [StringNotifier].
class StringNotifierProvider
    extends AutoDisposeNotifierProviderImpl<StringNotifier, String> {
  /// See also [StringNotifier].
  StringNotifierProvider({
    required String key,
  }) : this._internal(
          () => StringNotifier()..key = key,
          from: stringNotifierProvider,
          name: r'stringNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$stringNotifierHash,
          dependencies: StringNotifierFamily._dependencies,
          allTransitiveDependencies:
              StringNotifierFamily._allTransitiveDependencies,
          key: key,
        );

  StringNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.key,
  }) : super.internal();

  final String key;

  @override
  String runNotifierBuild(
    covariant StringNotifier notifier,
  ) {
    return notifier.build(
      key: key,
    );
  }

  @override
  Override overrideWith(StringNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: StringNotifierProvider._internal(
        () => create()..key = key,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        key: key,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<StringNotifier, String> createElement() {
    return _StringNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StringNotifierProvider && other.key == key;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, key.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin StringNotifierRef on AutoDisposeNotifierProviderRef<String> {
  /// The parameter `key` of this provider.
  String get key;
}

class _StringNotifierProviderElement
    extends AutoDisposeNotifierProviderElement<StringNotifier, String>
    with StringNotifierRef {
  _StringNotifierProviderElement(super.provider);

  @override
  String get key => (origin as StringNotifierProvider).key;
}

String _$doubleNotifierHash() => r'238d24a057c16ff6dc6be540917ed51fa5d01365';

abstract class _$DoubleNotifier extends BuildlessAutoDisposeNotifier<double> {
  late final String key;

  double build({
    required String key,
  });
}

/// See also [DoubleNotifier].
@ProviderFor(DoubleNotifier)
const doubleNotifierProvider = DoubleNotifierFamily();

/// See also [DoubleNotifier].
class DoubleNotifierFamily extends Family<double> {
  /// See also [DoubleNotifier].
  const DoubleNotifierFamily();

  /// See also [DoubleNotifier].
  DoubleNotifierProvider call({
    required String key,
  }) {
    return DoubleNotifierProvider(
      key: key,
    );
  }

  @override
  DoubleNotifierProvider getProviderOverride(
    covariant DoubleNotifierProvider provider,
  ) {
    return call(
      key: provider.key,
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
  String? get name => r'doubleNotifierProvider';
}

/// See also [DoubleNotifier].
class DoubleNotifierProvider
    extends AutoDisposeNotifierProviderImpl<DoubleNotifier, double> {
  /// See also [DoubleNotifier].
  DoubleNotifierProvider({
    required String key,
  }) : this._internal(
          () => DoubleNotifier()..key = key,
          from: doubleNotifierProvider,
          name: r'doubleNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$doubleNotifierHash,
          dependencies: DoubleNotifierFamily._dependencies,
          allTransitiveDependencies:
              DoubleNotifierFamily._allTransitiveDependencies,
          key: key,
        );

  DoubleNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.key,
  }) : super.internal();

  final String key;

  @override
  double runNotifierBuild(
    covariant DoubleNotifier notifier,
  ) {
    return notifier.build(
      key: key,
    );
  }

  @override
  Override overrideWith(DoubleNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: DoubleNotifierProvider._internal(
        () => create()..key = key,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        key: key,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<DoubleNotifier, double> createElement() {
    return _DoubleNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DoubleNotifierProvider && other.key == key;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, key.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin DoubleNotifierRef on AutoDisposeNotifierProviderRef<double> {
  /// The parameter `key` of this provider.
  String get key;
}

class _DoubleNotifierProviderElement
    extends AutoDisposeNotifierProviderElement<DoubleNotifier, double>
    with DoubleNotifierRef {
  _DoubleNotifierProviderElement(super.provider);

  @override
  String get key => (origin as DoubleNotifierProvider).key;
}

String _$intNotifierHash() => r'3d1a1d65515551e89d6b137035f22253d4572f99';

abstract class _$IntNotifier extends BuildlessAutoDisposeNotifier<int> {
  late final String key;

  int build({
    required String key,
  });
}

/// See also [IntNotifier].
@ProviderFor(IntNotifier)
const intNotifierProvider = IntNotifierFamily();

/// See also [IntNotifier].
class IntNotifierFamily extends Family<int> {
  /// See also [IntNotifier].
  const IntNotifierFamily();

  /// See also [IntNotifier].
  IntNotifierProvider call({
    required String key,
  }) {
    return IntNotifierProvider(
      key: key,
    );
  }

  @override
  IntNotifierProvider getProviderOverride(
    covariant IntNotifierProvider provider,
  ) {
    return call(
      key: provider.key,
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
  String? get name => r'intNotifierProvider';
}

/// See also [IntNotifier].
class IntNotifierProvider
    extends AutoDisposeNotifierProviderImpl<IntNotifier, int> {
  /// See also [IntNotifier].
  IntNotifierProvider({
    required String key,
  }) : this._internal(
          () => IntNotifier()..key = key,
          from: intNotifierProvider,
          name: r'intNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$intNotifierHash,
          dependencies: IntNotifierFamily._dependencies,
          allTransitiveDependencies:
              IntNotifierFamily._allTransitiveDependencies,
          key: key,
        );

  IntNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.key,
  }) : super.internal();

  final String key;

  @override
  int runNotifierBuild(
    covariant IntNotifier notifier,
  ) {
    return notifier.build(
      key: key,
    );
  }

  @override
  Override overrideWith(IntNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: IntNotifierProvider._internal(
        () => create()..key = key,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        key: key,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<IntNotifier, int> createElement() {
    return _IntNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IntNotifierProvider && other.key == key;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, key.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin IntNotifierRef on AutoDisposeNotifierProviderRef<int> {
  /// The parameter `key` of this provider.
  String get key;
}

class _IntNotifierProviderElement
    extends AutoDisposeNotifierProviderElement<IntNotifier, int>
    with IntNotifierRef {
  _IntNotifierProviderElement(super.provider);

  @override
  String get key => (origin as IntNotifierProvider).key;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
