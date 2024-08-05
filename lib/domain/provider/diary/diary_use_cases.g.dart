// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diary_use_cases.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getDiariesHash() => r'7b12024e9e7c5a2272cdc13f3c1bb85d2e432f6f';

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

/// See also [getDiaries].
@ProviderFor(getDiaries)
const getDiariesProvider = GetDiariesFamily();

/// See also [getDiaries].
class GetDiariesFamily extends Family<AsyncValue<List<MusicDiary>>> {
  /// See also [getDiaries].
  const GetDiariesFamily();

  /// See also [getDiaries].
  GetDiariesProvider call(
    DateTime dateTime,
  ) {
    return GetDiariesProvider(
      dateTime,
    );
  }

  @override
  GetDiariesProvider getProviderOverride(
    covariant GetDiariesProvider provider,
  ) {
    return call(
      provider.dateTime,
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
  String? get name => r'getDiariesProvider';
}

/// See also [getDiaries].
class GetDiariesProvider extends AutoDisposeFutureProvider<List<MusicDiary>> {
  /// See also [getDiaries].
  GetDiariesProvider(
    DateTime dateTime,
  ) : this._internal(
          (ref) => getDiaries(
            ref as GetDiariesRef,
            dateTime,
          ),
          from: getDiariesProvider,
          name: r'getDiariesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getDiariesHash,
          dependencies: GetDiariesFamily._dependencies,
          allTransitiveDependencies:
              GetDiariesFamily._allTransitiveDependencies,
          dateTime: dateTime,
        );

  GetDiariesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.dateTime,
  }) : super.internal();

  final DateTime dateTime;

  @override
  Override overrideWith(
    FutureOr<List<MusicDiary>> Function(GetDiariesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetDiariesProvider._internal(
        (ref) => create(ref as GetDiariesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        dateTime: dateTime,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<MusicDiary>> createElement() {
    return _GetDiariesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetDiariesProvider && other.dateTime == dateTime;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, dateTime.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetDiariesRef on AutoDisposeFutureProviderRef<List<MusicDiary>> {
  /// The parameter `dateTime` of this provider.
  DateTime get dateTime;
}

class _GetDiariesProviderElement
    extends AutoDisposeFutureProviderElement<List<MusicDiary>>
    with GetDiariesRef {
  _GetDiariesProviderElement(super.provider);

  @override
  DateTime get dateTime => (origin as GetDiariesProvider).dateTime;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
