// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diary_use_cases.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getDiariesHash() => r'8b5646a7b8407fe67cbf6ace922a4b6b0a0e950e';

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
class GetDiariesFamily extends Family<AsyncValue<DiaryRespons>> {
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
class GetDiariesProvider extends AutoDisposeFutureProvider<DiaryRespons> {
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
    FutureOr<DiaryRespons> Function(GetDiariesRef provider) create,
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
  AutoDisposeFutureProviderElement<DiaryRespons> createElement() {
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

mixin GetDiariesRef on AutoDisposeFutureProviderRef<DiaryRespons> {
  /// The parameter `dateTime` of this provider.
  DateTime get dateTime;
}

class _GetDiariesProviderElement
    extends AutoDisposeFutureProviderElement<DiaryRespons> with GetDiariesRef {
  _GetDiariesProviderElement(super.provider);

  @override
  DateTime get dateTime => (origin as GetDiariesProvider).dateTime;
}

String _$getDiaryHash() => r'cf11033d07b8c8ec829dc272d623c5c0e4f94843';

/// See also [getDiary].
@ProviderFor(getDiary)
const getDiaryProvider = GetDiaryFamily();

/// See also [getDiary].
class GetDiaryFamily extends Family<AsyncValue<MusicDiary?>> {
  /// See also [getDiary].
  const GetDiaryFamily();

  /// See also [getDiary].
  GetDiaryProvider call(
    DateTime dateTime,
  ) {
    return GetDiaryProvider(
      dateTime,
    );
  }

  @override
  GetDiaryProvider getProviderOverride(
    covariant GetDiaryProvider provider,
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
  String? get name => r'getDiaryProvider';
}

/// See also [getDiary].
class GetDiaryProvider extends AutoDisposeFutureProvider<MusicDiary?> {
  /// See also [getDiary].
  GetDiaryProvider(
    DateTime dateTime,
  ) : this._internal(
          (ref) => getDiary(
            ref as GetDiaryRef,
            dateTime,
          ),
          from: getDiaryProvider,
          name: r'getDiaryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getDiaryHash,
          dependencies: GetDiaryFamily._dependencies,
          allTransitiveDependencies: GetDiaryFamily._allTransitiveDependencies,
          dateTime: dateTime,
        );

  GetDiaryProvider._internal(
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
    FutureOr<MusicDiary?> Function(GetDiaryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetDiaryProvider._internal(
        (ref) => create(ref as GetDiaryRef),
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
  AutoDisposeFutureProviderElement<MusicDiary?> createElement() {
    return _GetDiaryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetDiaryProvider && other.dateTime == dateTime;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, dateTime.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetDiaryRef on AutoDisposeFutureProviderRef<MusicDiary?> {
  /// The parameter `dateTime` of this provider.
  DateTime get dateTime;
}

class _GetDiaryProviderElement
    extends AutoDisposeFutureProviderElement<MusicDiary?> with GetDiaryRef {
  _GetDiaryProviderElement(super.provider);

  @override
  DateTime get dateTime => (origin as GetDiaryProvider).dateTime;
}

String _$postDiaryHash() => r'e3c42ebf0e422134564542629e2f509f7834689a';

/// See also [postDiary].
@ProviderFor(postDiary)
const postDiaryProvider = PostDiaryFamily();

/// See also [postDiary].
class PostDiaryFamily extends Family<AsyncValue<void>> {
  /// See also [postDiary].
  const PostDiaryFamily();

  /// See also [postDiary].
  PostDiaryProvider call({
    required Journal journal,
    required ChatsFeedbackResponse chatsFeedbackResponse,
  }) {
    return PostDiaryProvider(
      journal: journal,
      chatsFeedbackResponse: chatsFeedbackResponse,
    );
  }

  @override
  PostDiaryProvider getProviderOverride(
    covariant PostDiaryProvider provider,
  ) {
    return call(
      journal: provider.journal,
      chatsFeedbackResponse: provider.chatsFeedbackResponse,
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
  String? get name => r'postDiaryProvider';
}

/// See also [postDiary].
class PostDiaryProvider extends AutoDisposeFutureProvider<void> {
  /// See also [postDiary].
  PostDiaryProvider({
    required Journal journal,
    required ChatsFeedbackResponse chatsFeedbackResponse,
  }) : this._internal(
          (ref) => postDiary(
            ref as PostDiaryRef,
            journal: journal,
            chatsFeedbackResponse: chatsFeedbackResponse,
          ),
          from: postDiaryProvider,
          name: r'postDiaryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$postDiaryHash,
          dependencies: PostDiaryFamily._dependencies,
          allTransitiveDependencies: PostDiaryFamily._allTransitiveDependencies,
          journal: journal,
          chatsFeedbackResponse: chatsFeedbackResponse,
        );

  PostDiaryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.journal,
    required this.chatsFeedbackResponse,
  }) : super.internal();

  final Journal journal;
  final ChatsFeedbackResponse chatsFeedbackResponse;

  @override
  Override overrideWith(
    FutureOr<void> Function(PostDiaryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PostDiaryProvider._internal(
        (ref) => create(ref as PostDiaryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        journal: journal,
        chatsFeedbackResponse: chatsFeedbackResponse,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _PostDiaryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PostDiaryProvider &&
        other.journal == journal &&
        other.chatsFeedbackResponse == chatsFeedbackResponse;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, journal.hashCode);
    hash = _SystemHash.combine(hash, chatsFeedbackResponse.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PostDiaryRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `journal` of this provider.
  Journal get journal;

  /// The parameter `chatsFeedbackResponse` of this provider.
  ChatsFeedbackResponse get chatsFeedbackResponse;
}

class _PostDiaryProviderElement extends AutoDisposeFutureProviderElement<void>
    with PostDiaryRef {
  _PostDiaryProviderElement(super.provider);

  @override
  Journal get journal => (origin as PostDiaryProvider).journal;
  @override
  ChatsFeedbackResponse get chatsFeedbackResponse =>
      (origin as PostDiaryProvider).chatsFeedbackResponse;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
