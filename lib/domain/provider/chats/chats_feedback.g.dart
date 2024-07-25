// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chats_feedback.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatsFeedbackHash() => r'c15e6914b59ce1bebf84ce11cac87bfc37552385';

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

/// See also [chatsFeedback].
@ProviderFor(chatsFeedback)
const chatsFeedbackProvider = ChatsFeedbackFamily();

/// See also [chatsFeedback].
class ChatsFeedbackFamily extends Family<AsyncValue<dynamic>> {
  /// See also [chatsFeedback].
  const ChatsFeedbackFamily();

  /// See also [chatsFeedback].
  ChatsFeedbackProvider call(
    List<Chat> chats,
  ) {
    return ChatsFeedbackProvider(
      chats,
    );
  }

  @override
  ChatsFeedbackProvider getProviderOverride(
    covariant ChatsFeedbackProvider provider,
  ) {
    return call(
      provider.chats,
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
  String? get name => r'chatsFeedbackProvider';
}

/// See also [chatsFeedback].
class ChatsFeedbackProvider extends AutoDisposeFutureProvider<dynamic> {
  /// See also [chatsFeedback].
  ChatsFeedbackProvider(
    List<Chat> chats,
  ) : this._internal(
          (ref) => chatsFeedback(
            ref as ChatsFeedbackRef,
            chats,
          ),
          from: chatsFeedbackProvider,
          name: r'chatsFeedbackProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$chatsFeedbackHash,
          dependencies: ChatsFeedbackFamily._dependencies,
          allTransitiveDependencies:
              ChatsFeedbackFamily._allTransitiveDependencies,
          chats: chats,
        );

  ChatsFeedbackProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.chats,
  }) : super.internal();

  final List<Chat> chats;

  @override
  Override overrideWith(
    FutureOr<dynamic> Function(ChatsFeedbackRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ChatsFeedbackProvider._internal(
        (ref) => create(ref as ChatsFeedbackRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        chats: chats,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<dynamic> createElement() {
    return _ChatsFeedbackProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChatsFeedbackProvider && other.chats == chats;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, chats.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ChatsFeedbackRef on AutoDisposeFutureProviderRef<dynamic> {
  /// The parameter `chats` of this provider.
  List<Chat> get chats;
}

class _ChatsFeedbackProviderElement
    extends AutoDisposeFutureProviderElement<dynamic> with ChatsFeedbackRef {
  _ChatsFeedbackProviderElement(super.provider);

  @override
  List<Chat> get chats => (origin as ChatsFeedbackProvider).chats;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
