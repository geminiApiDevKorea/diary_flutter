// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$journalServiceHash() => r'b4ccb5607bbc46f5d1e04c2b5a232efc9e0358b1';

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

abstract class _$JournalService
    extends BuildlessAutoDisposeNotifier<JournalState> {
  late final JournalType journalType;
  late final DateTime focusedDate;

  JournalState build({
    required JournalType journalType,
    required DateTime focusedDate,
  });
}

/// See also [JournalService].
@ProviderFor(JournalService)
const journalServiceProvider = JournalServiceFamily();

/// See also [JournalService].
class JournalServiceFamily extends Family<JournalState> {
  /// See also [JournalService].
  const JournalServiceFamily();

  /// See also [JournalService].
  JournalServiceProvider call({
    required JournalType journalType,
    required DateTime focusedDate,
  }) {
    return JournalServiceProvider(
      journalType: journalType,
      focusedDate: focusedDate,
    );
  }

  @override
  JournalServiceProvider getProviderOverride(
    covariant JournalServiceProvider provider,
  ) {
    return call(
      journalType: provider.journalType,
      focusedDate: provider.focusedDate,
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
  String? get name => r'journalServiceProvider';
}

/// See also [JournalService].
class JournalServiceProvider
    extends AutoDisposeNotifierProviderImpl<JournalService, JournalState> {
  /// See also [JournalService].
  JournalServiceProvider({
    required JournalType journalType,
    required DateTime focusedDate,
  }) : this._internal(
          () => JournalService()
            ..journalType = journalType
            ..focusedDate = focusedDate,
          from: journalServiceProvider,
          name: r'journalServiceProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$journalServiceHash,
          dependencies: JournalServiceFamily._dependencies,
          allTransitiveDependencies:
              JournalServiceFamily._allTransitiveDependencies,
          journalType: journalType,
          focusedDate: focusedDate,
        );

  JournalServiceProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.journalType,
    required this.focusedDate,
  }) : super.internal();

  final JournalType journalType;
  final DateTime focusedDate;

  @override
  JournalState runNotifierBuild(
    covariant JournalService notifier,
  ) {
    return notifier.build(
      journalType: journalType,
      focusedDate: focusedDate,
    );
  }

  @override
  Override overrideWith(JournalService Function() create) {
    return ProviderOverride(
      origin: this,
      override: JournalServiceProvider._internal(
        () => create()
          ..journalType = journalType
          ..focusedDate = focusedDate,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        journalType: journalType,
        focusedDate: focusedDate,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<JournalService, JournalState>
      createElement() {
    return _JournalServiceProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is JournalServiceProvider &&
        other.journalType == journalType &&
        other.focusedDate == focusedDate;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, journalType.hashCode);
    hash = _SystemHash.combine(hash, focusedDate.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin JournalServiceRef on AutoDisposeNotifierProviderRef<JournalState> {
  /// The parameter `journalType` of this provider.
  JournalType get journalType;

  /// The parameter `focusedDate` of this provider.
  DateTime get focusedDate;
}

class _JournalServiceProviderElement
    extends AutoDisposeNotifierProviderElement<JournalService, JournalState>
    with JournalServiceRef {
  _JournalServiceProviderElement(super.provider);

  @override
  JournalType get journalType => (origin as JournalServiceProvider).journalType;
  @override
  DateTime get focusedDate => (origin as JournalServiceProvider).focusedDate;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
