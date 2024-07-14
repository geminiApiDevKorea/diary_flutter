// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_chat.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getChatHash() => r'06726ae18937c70e4ff88555ee101fc637faaf16';

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

/// See also [getChat].
@ProviderFor(getChat)
const getChatProvider = GetChatFamily();

/// See also [getChat].
class GetChatFamily extends Family<Chat> {
  /// See also [getChat].
  const GetChatFamily();

  /// See also [getChat].
  GetChatProvider call(
    int index,
  ) {
    return GetChatProvider(
      index,
    );
  }

  @override
  GetChatProvider getProviderOverride(
    covariant GetChatProvider provider,
  ) {
    return call(
      provider.index,
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
  String? get name => r'getChatProvider';
}

/// See also [getChat].
class GetChatProvider extends AutoDisposeProvider<Chat> {
  /// See also [getChat].
  GetChatProvider(
    int index,
  ) : this._internal(
          (ref) => getChat(
            ref as GetChatRef,
            index,
          ),
          from: getChatProvider,
          name: r'getChatProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getChatHash,
          dependencies: GetChatFamily._dependencies,
          allTransitiveDependencies: GetChatFamily._allTransitiveDependencies,
          index: index,
        );

  GetChatProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.index,
  }) : super.internal();

  final int index;

  @override
  Override overrideWith(
    Chat Function(GetChatRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetChatProvider._internal(
        (ref) => create(ref as GetChatRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        index: index,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<Chat> createElement() {
    return _GetChatProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetChatProvider && other.index == index;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, index.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetChatRef on AutoDisposeProviderRef<Chat> {
  /// The parameter `index` of this provider.
  int get index;
}

class _GetChatProviderElement extends AutoDisposeProviderElement<Chat>
    with GetChatRef {
  _GetChatProviderElement(super.provider);

  @override
  int get index => (origin as GetChatProvider).index;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
