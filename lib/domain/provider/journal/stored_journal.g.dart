// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stored_journal.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$storedJournalHash() => r'09106021083ca2b5c568a2981d57aaa4ee88edfb';

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

abstract class _$StoredJournal
    extends BuildlessAutoDisposeNotifier<List<Journal>> {
  late final String idToken;

  List<Journal> build(
    String idToken,
  );
}

/// 영구 저장소에 저널 데이터를 저장하고 관리하는 클래스입니다.
///
/// Copied from [StoredJournal].
@ProviderFor(StoredJournal)
const storedJournalProvider = StoredJournalFamily();

/// 영구 저장소에 저널 데이터를 저장하고 관리하는 클래스입니다.
///
/// Copied from [StoredJournal].
class StoredJournalFamily extends Family<List<Journal>> {
  /// 영구 저장소에 저널 데이터를 저장하고 관리하는 클래스입니다.
  ///
  /// Copied from [StoredJournal].
  const StoredJournalFamily();

  /// 영구 저장소에 저널 데이터를 저장하고 관리하는 클래스입니다.
  ///
  /// Copied from [StoredJournal].
  StoredJournalProvider call(
    String idToken,
  ) {
    return StoredJournalProvider(
      idToken,
    );
  }

  @override
  StoredJournalProvider getProviderOverride(
    covariant StoredJournalProvider provider,
  ) {
    return call(
      provider.idToken,
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
  String? get name => r'storedJournalProvider';
}

/// 영구 저장소에 저널 데이터를 저장하고 관리하는 클래스입니다.
///
/// Copied from [StoredJournal].
class StoredJournalProvider
    extends AutoDisposeNotifierProviderImpl<StoredJournal, List<Journal>> {
  /// 영구 저장소에 저널 데이터를 저장하고 관리하는 클래스입니다.
  ///
  /// Copied from [StoredJournal].
  StoredJournalProvider(
    String idToken,
  ) : this._internal(
          () => StoredJournal()..idToken = idToken,
          from: storedJournalProvider,
          name: r'storedJournalProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$storedJournalHash,
          dependencies: StoredJournalFamily._dependencies,
          allTransitiveDependencies:
              StoredJournalFamily._allTransitiveDependencies,
          idToken: idToken,
        );

  StoredJournalProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.idToken,
  }) : super.internal();

  final String idToken;

  @override
  List<Journal> runNotifierBuild(
    covariant StoredJournal notifier,
  ) {
    return notifier.build(
      idToken,
    );
  }

  @override
  Override overrideWith(StoredJournal Function() create) {
    return ProviderOverride(
      origin: this,
      override: StoredJournalProvider._internal(
        () => create()..idToken = idToken,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        idToken: idToken,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<StoredJournal, List<Journal>>
      createElement() {
    return _StoredJournalProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StoredJournalProvider && other.idToken == idToken;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, idToken.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin StoredJournalRef on AutoDisposeNotifierProviderRef<List<Journal>> {
  /// The parameter `idToken` of this provider.
  String get idToken;
}

class _StoredJournalProviderElement
    extends AutoDisposeNotifierProviderElement<StoredJournal, List<Journal>>
    with StoredJournalRef {
  _StoredJournalProviderElement(super.provider);

  @override
  String get idToken => (origin as StoredJournalProvider).idToken;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
