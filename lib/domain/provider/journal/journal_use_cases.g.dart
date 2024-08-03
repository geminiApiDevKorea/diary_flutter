// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_use_cases.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getMyLatestJournalHash() =>
    r'e715af8355f1037609b96a70f7a1d8c8fdd32c4b';

/// 1. 내 최신 저널 얻기
///
/// Copied from [getMyLatestJournal].
@ProviderFor(getMyLatestJournal)
final getMyLatestJournalProvider = AutoDisposeProvider<Journal?>.internal(
  getMyLatestJournal,
  name: r'getMyLatestJournalProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getMyLatestJournalHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetMyLatestJournalRef = AutoDisposeProviderRef<Journal?>;
String _$getAllMyJournalsHash() => r'19028bb2924c8857c617f1b01fec7a06c3da8ea7';

/// 2. 내 저널 전부 얻기
///
/// Copied from [getAllMyJournals].
@ProviderFor(getAllMyJournals)
final getAllMyJournalsProvider = AutoDisposeProvider<List<Journal>>.internal(
  getAllMyJournals,
  name: r'getAllMyJournalsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getAllMyJournalsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetAllMyJournalsRef = AutoDisposeProviderRef<List<Journal>>;
String _$getMyJournalByDateHash() =>
    r'5a3a668f0a73439af9cfa99646b9efed0ccd72bc';

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

/// 3. 특정 날짜의 내 저널 얻기
///
/// Copied from [getMyJournalByDate].
@ProviderFor(getMyJournalByDate)
const getMyJournalByDateProvider = GetMyJournalByDateFamily();

/// 3. 특정 날짜의 내 저널 얻기
///
/// Copied from [getMyJournalByDate].
class GetMyJournalByDateFamily extends Family<Journal?> {
  /// 3. 특정 날짜의 내 저널 얻기
  ///
  /// Copied from [getMyJournalByDate].
  const GetMyJournalByDateFamily();

  /// 3. 특정 날짜의 내 저널 얻기
  ///
  /// Copied from [getMyJournalByDate].
  GetMyJournalByDateProvider call(
    DateTime date,
  ) {
    return GetMyJournalByDateProvider(
      date,
    );
  }

  @override
  GetMyJournalByDateProvider getProviderOverride(
    covariant GetMyJournalByDateProvider provider,
  ) {
    return call(
      provider.date,
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
  String? get name => r'getMyJournalByDateProvider';
}

/// 3. 특정 날짜의 내 저널 얻기
///
/// Copied from [getMyJournalByDate].
class GetMyJournalByDateProvider extends AutoDisposeProvider<Journal?> {
  /// 3. 특정 날짜의 내 저널 얻기
  ///
  /// Copied from [getMyJournalByDate].
  GetMyJournalByDateProvider(
    DateTime date,
  ) : this._internal(
          (ref) => getMyJournalByDate(
            ref as GetMyJournalByDateRef,
            date,
          ),
          from: getMyJournalByDateProvider,
          name: r'getMyJournalByDateProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getMyJournalByDateHash,
          dependencies: GetMyJournalByDateFamily._dependencies,
          allTransitiveDependencies:
              GetMyJournalByDateFamily._allTransitiveDependencies,
          date: date,
        );

  GetMyJournalByDateProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.date,
  }) : super.internal();

  final DateTime date;

  @override
  Override overrideWith(
    Journal? Function(GetMyJournalByDateRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetMyJournalByDateProvider._internal(
        (ref) => create(ref as GetMyJournalByDateRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        date: date,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<Journal?> createElement() {
    return _GetMyJournalByDateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetMyJournalByDateProvider && other.date == date;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, date.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetMyJournalByDateRef on AutoDisposeProviderRef<Journal?> {
  /// The parameter `date` of this provider.
  DateTime get date;
}

class _GetMyJournalByDateProviderElement
    extends AutoDisposeProviderElement<Journal?> with GetMyJournalByDateRef {
  _GetMyJournalByDateProviderElement(super.provider);

  @override
  DateTime get date => (origin as GetMyJournalByDateProvider).date;
}

String _$getMyJournalCountHash() => r'10b5025918c69b04a4dc7f9491ae2f9481e45929';

/// 4. 내 저널의 길이 알기
///
/// Copied from [getMyJournalCount].
@ProviderFor(getMyJournalCount)
final getMyJournalCountProvider = AutoDisposeProvider<int>.internal(
  getMyJournalCount,
  name: r'getMyJournalCountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getMyJournalCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetMyJournalCountRef = AutoDisposeProviderRef<int>;
String _$getMyJournalHistoryByDateHash() =>
    r'134f733462a1a0c43fa526643af7cf367b8e7a82';

/// 5. 특정 날짜의 내 저널 내 히스토리 알기
///
/// Copied from [getMyJournalHistoryByDate].
@ProviderFor(getMyJournalHistoryByDate)
const getMyJournalHistoryByDateProvider = GetMyJournalHistoryByDateFamily();

/// 5. 특정 날짜의 내 저널 내 히스토리 알기
///
/// Copied from [getMyJournalHistoryByDate].
class GetMyJournalHistoryByDateFamily extends Family<List<History>?> {
  /// 5. 특정 날짜의 내 저널 내 히스토리 알기
  ///
  /// Copied from [getMyJournalHistoryByDate].
  const GetMyJournalHistoryByDateFamily();

  /// 5. 특정 날짜의 내 저널 내 히스토리 알기
  ///
  /// Copied from [getMyJournalHistoryByDate].
  GetMyJournalHistoryByDateProvider call(
    DateTime date,
  ) {
    return GetMyJournalHistoryByDateProvider(
      date,
    );
  }

  @override
  GetMyJournalHistoryByDateProvider getProviderOverride(
    covariant GetMyJournalHistoryByDateProvider provider,
  ) {
    return call(
      provider.date,
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
  String? get name => r'getMyJournalHistoryByDateProvider';
}

/// 5. 특정 날짜의 내 저널 내 히스토리 알기
///
/// Copied from [getMyJournalHistoryByDate].
class GetMyJournalHistoryByDateProvider
    extends AutoDisposeProvider<List<History>?> {
  /// 5. 특정 날짜의 내 저널 내 히스토리 알기
  ///
  /// Copied from [getMyJournalHistoryByDate].
  GetMyJournalHistoryByDateProvider(
    DateTime date,
  ) : this._internal(
          (ref) => getMyJournalHistoryByDate(
            ref as GetMyJournalHistoryByDateRef,
            date,
          ),
          from: getMyJournalHistoryByDateProvider,
          name: r'getMyJournalHistoryByDateProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getMyJournalHistoryByDateHash,
          dependencies: GetMyJournalHistoryByDateFamily._dependencies,
          allTransitiveDependencies:
              GetMyJournalHistoryByDateFamily._allTransitiveDependencies,
          date: date,
        );

  GetMyJournalHistoryByDateProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.date,
  }) : super.internal();

  final DateTime date;

  @override
  Override overrideWith(
    List<History>? Function(GetMyJournalHistoryByDateRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetMyJournalHistoryByDateProvider._internal(
        (ref) => create(ref as GetMyJournalHistoryByDateRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        date: date,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<History>?> createElement() {
    return _GetMyJournalHistoryByDateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetMyJournalHistoryByDateProvider && other.date == date;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, date.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetMyJournalHistoryByDateRef on AutoDisposeProviderRef<List<History>?> {
  /// The parameter `date` of this provider.
  DateTime get date;
}

class _GetMyJournalHistoryByDateProviderElement
    extends AutoDisposeProviderElement<List<History>?>
    with GetMyJournalHistoryByDateRef {
  _GetMyJournalHistoryByDateProviderElement(super.provider);

  @override
  DateTime get date => (origin as GetMyJournalHistoryByDateProvider).date;
}

String _$getJournalsWithMusicAndSongHash() =>
    r'967f6cbd208fcd576fa2b19d639ad9df49e9347c';

/// 6. music과 Song이 있는 내 저널 모두 받기
///
/// Copied from [getJournalsWithMusicAndSong].
@ProviderFor(getJournalsWithMusicAndSong)
final getJournalsWithMusicAndSongProvider =
    AutoDisposeProvider<List<Journal>>.internal(
  getJournalsWithMusicAndSong,
  name: r'getJournalsWithMusicAndSongProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getJournalsWithMusicAndSongHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetJournalsWithMusicAndSongRef = AutoDisposeProviderRef<List<Journal>>;
String _$getJournalsWithMusicAndSongCountHash() =>
    r'3dc459e51d82961092ade64d47b0681327de9c2e';

/// 7. music과 Song이 있는 내 저널 갯수 받기
///
/// Copied from [getJournalsWithMusicAndSongCount].
@ProviderFor(getJournalsWithMusicAndSongCount)
final getJournalsWithMusicAndSongCountProvider =
    AutoDisposeProvider<int>.internal(
  getJournalsWithMusicAndSongCount,
  name: r'getJournalsWithMusicAndSongCountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getJournalsWithMusicAndSongCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetJournalsWithMusicAndSongCountRef = AutoDisposeProviderRef<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
