// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gem_theme_notifier_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$gemColorsHash() => r'5c9417a682a40a5b9d32024dcaec52934896d2e1';

/// See also [gemColors].
@ProviderFor(gemColors)
final gemColorsProvider = AutoDisposeProvider<GemColors>.internal(
  gemColors,
  name: r'gemColorsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$gemColorsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GemColorsRef = AutoDisposeProviderRef<GemColors>;
String _$gemThemeNotifierHash() => r'12329954af8cace94a2a6d4cec288729ee16145c';

/// See also [GemThemeNotifier].
@ProviderFor(GemThemeNotifier)
final gemThemeNotifierProvider =
    AutoDisposeNotifierProvider<GemThemeNotifier, GemTheme>.internal(
  GemThemeNotifier.new,
  name: r'gemThemeNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$gemThemeNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$GemThemeNotifier = AutoDisposeNotifier<GemTheme>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
