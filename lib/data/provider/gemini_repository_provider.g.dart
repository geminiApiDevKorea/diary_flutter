// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gemini_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$geminiRepositoryHash() => r'53f4c5224c947b4ed707b78adce6b63b44385b64';

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

/// See also [geminiRepository].
@ProviderFor(geminiRepository)
const geminiRepositoryProvider = GeminiRepositoryFamily();

/// See also [geminiRepository].
class GeminiRepositoryFamily extends Family<GeminiRepository> {
  /// See also [geminiRepository].
  const GeminiRepositoryFamily();

  /// See also [geminiRepository].
  GeminiRepositoryProvider call({
    required GeminiModels model,
    required String apiKey,
    required String systemPrompt,
    GeminiResponseMimeTypes responseMimeType = GeminiResponseMimeTypes.text,
  }) {
    return GeminiRepositoryProvider(
      model: model,
      apiKey: apiKey,
      systemPrompt: systemPrompt,
      responseMimeType: responseMimeType,
    );
  }

  @override
  GeminiRepositoryProvider getProviderOverride(
    covariant GeminiRepositoryProvider provider,
  ) {
    return call(
      model: provider.model,
      apiKey: provider.apiKey,
      systemPrompt: provider.systemPrompt,
      responseMimeType: provider.responseMimeType,
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
  String? get name => r'geminiRepositoryProvider';
}

/// See also [geminiRepository].
class GeminiRepositoryProvider extends AutoDisposeProvider<GeminiRepository> {
  /// See also [geminiRepository].
  GeminiRepositoryProvider({
    required GeminiModels model,
    required String apiKey,
    required String systemPrompt,
    GeminiResponseMimeTypes responseMimeType = GeminiResponseMimeTypes.text,
  }) : this._internal(
          (ref) => geminiRepository(
            ref as GeminiRepositoryRef,
            model: model,
            apiKey: apiKey,
            systemPrompt: systemPrompt,
            responseMimeType: responseMimeType,
          ),
          from: geminiRepositoryProvider,
          name: r'geminiRepositoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$geminiRepositoryHash,
          dependencies: GeminiRepositoryFamily._dependencies,
          allTransitiveDependencies:
              GeminiRepositoryFamily._allTransitiveDependencies,
          model: model,
          apiKey: apiKey,
          systemPrompt: systemPrompt,
          responseMimeType: responseMimeType,
        );

  GeminiRepositoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.model,
    required this.apiKey,
    required this.systemPrompt,
    required this.responseMimeType,
  }) : super.internal();

  final GeminiModels model;
  final String apiKey;
  final String systemPrompt;
  final GeminiResponseMimeTypes responseMimeType;

  @override
  Override overrideWith(
    GeminiRepository Function(GeminiRepositoryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GeminiRepositoryProvider._internal(
        (ref) => create(ref as GeminiRepositoryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        model: model,
        apiKey: apiKey,
        systemPrompt: systemPrompt,
        responseMimeType: responseMimeType,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<GeminiRepository> createElement() {
    return _GeminiRepositoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GeminiRepositoryProvider &&
        other.model == model &&
        other.apiKey == apiKey &&
        other.systemPrompt == systemPrompt &&
        other.responseMimeType == responseMimeType;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, model.hashCode);
    hash = _SystemHash.combine(hash, apiKey.hashCode);
    hash = _SystemHash.combine(hash, systemPrompt.hashCode);
    hash = _SystemHash.combine(hash, responseMimeType.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GeminiRepositoryRef on AutoDisposeProviderRef<GeminiRepository> {
  /// The parameter `model` of this provider.
  GeminiModels get model;

  /// The parameter `apiKey` of this provider.
  String get apiKey;

  /// The parameter `systemPrompt` of this provider.
  String get systemPrompt;

  /// The parameter `responseMimeType` of this provider.
  GeminiResponseMimeTypes get responseMimeType;
}

class _GeminiRepositoryProviderElement
    extends AutoDisposeProviderElement<GeminiRepository>
    with GeminiRepositoryRef {
  _GeminiRepositoryProviderElement(super.provider);

  @override
  GeminiModels get model => (origin as GeminiRepositoryProvider).model;
  @override
  String get apiKey => (origin as GeminiRepositoryProvider).apiKey;
  @override
  String get systemPrompt => (origin as GeminiRepositoryProvider).systemPrompt;
  @override
  GeminiResponseMimeTypes get responseMimeType =>
      (origin as GeminiRepositoryProvider).responseMimeType;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
