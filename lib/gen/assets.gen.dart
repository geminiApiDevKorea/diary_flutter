/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

class $AssetsFontsGen {
  const $AssetsFontsGen();

  /// File path: assets/fonts/Adamina-Regular.ttf
  String get adaminaRegular => 'assets/fonts/Adamina-Regular.ttf';

  /// File path: assets/fonts/texgyreheros-bold.otf
  String get texgyreherosBold => 'assets/fonts/texgyreheros-bold.otf';

  /// File path: assets/fonts/texgyreheros-bolditalic.otf
  String get texgyreherosBolditalic =>
      'assets/fonts/texgyreheros-bolditalic.otf';

  /// File path: assets/fonts/texgyreheros-italic.otf
  String get texgyreherosItalic => 'assets/fonts/texgyreheros-italic.otf';

  /// File path: assets/fonts/texgyreheros-regular.otf
  String get texgyreherosRegular => 'assets/fonts/texgyreheros-regular.otf';

  /// File path: assets/fonts/texgyreheroscn-bold.otf
  String get texgyreheroscnBold => 'assets/fonts/texgyreheroscn-bold.otf';

  /// File path: assets/fonts/texgyreheroscn-bolditalic.otf
  String get texgyreheroscnBolditalic =>
      'assets/fonts/texgyreheroscn-bolditalic.otf';

  /// File path: assets/fonts/texgyreheroscn-italic.otf
  String get texgyreheroscnItalic => 'assets/fonts/texgyreheroscn-italic.otf';

  /// File path: assets/fonts/texgyreheroscn-regular.otf
  String get texgyreheroscnRegular => 'assets/fonts/texgyreheroscn-regular.otf';

  /// List of all assets
  List<String> get values => [
        adaminaRegular,
        texgyreherosBold,
        texgyreherosBolditalic,
        texgyreherosItalic,
        texgyreherosRegular,
        texgyreheroscnBold,
        texgyreheroscnBolditalic,
        texgyreheroscnItalic,
        texgyreheroscnRegular
      ];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/blankicon.png
  AssetGenImage get blankicon =>
      const AssetGenImage('assets/icons/blankicon.png');

  /// File path: assets/icons/icon_1024.png
  AssetGenImage get icon1024 =>
      const AssetGenImage('assets/icons/icon_1024.png');

  /// List of all assets
  List<AssetGenImage> get values => [blankicon, icon1024];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/back_button.png
  AssetGenImage get backButton =>
      const AssetGenImage('assets/images/back_button.png');

  /// File path: assets/images/checked.png
  AssetGenImage get checked => const AssetGenImage('assets/images/checked.png');

  /// File path: assets/images/icon_action_right.png
  AssetGenImage get iconActionRight =>
      const AssetGenImage('assets/images/icon_action_right.png');

  /// File path: assets/images/icon_google.png
  AssetGenImage get iconGoogle =>
      const AssetGenImage('assets/images/icon_google.png');

  /// File path: assets/images/icon_my_info.png
  AssetGenImage get iconMyInfo =>
      const AssetGenImage('assets/images/icon_my_info.png');

  /// File path: assets/images/icon_my_info_detail.png
  AssetGenImage get iconMyInfoDetail =>
      const AssetGenImage('assets/images/icon_my_info_detail.png');

  /// File path: assets/images/left_arrow.png
  AssetGenImage get leftArrow =>
      const AssetGenImage('assets/images/left_arrow.png');

  /// File path: assets/images/lock.png
  AssetGenImage get lock => const AssetGenImage('assets/images/lock.png');

  /// File path: assets/images/music.png
  AssetGenImage get music => const AssetGenImage('assets/images/music.png');

  /// File path: assets/images/newjeans.png
  AssetGenImage get newjeans =>
      const AssetGenImage('assets/images/newjeans.png');

  /// File path: assets/images/unchecked.png
  AssetGenImage get unchecked =>
      const AssetGenImage('assets/images/unchecked.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        backButton,
        checked,
        iconActionRight,
        iconGoogle,
        iconMyInfo,
        iconMyInfoDetail,
        leftArrow,
        lock,
        music,
        newjeans,
        unchecked
      ];
}

class $AssetsLottiesGen {
  const $AssetsLottiesGen();

  /// File path: assets/lotties/typing_indicator.json
  LottieGenImage get typingIndicator =>
      const LottieGenImage('assets/lotties/typing_indicator.json');

  /// List of all assets
  List<LottieGenImage> get values => [typingIndicator];
}

class Assets {
  Assets._();

  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsLottiesGen lotties = $AssetsLottiesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class LottieGenImage {
  const LottieGenImage(
    this._assetName, {
    this.flavors = const {},
  });

  final String _assetName;
  final Set<String> flavors;

  LottieBuilder lottie({
    Animation<double>? controller,
    bool? animate,
    FrameRate? frameRate,
    bool? repeat,
    bool? reverse,
    LottieDelegates? delegates,
    LottieOptions? options,
    void Function(LottieComposition)? onLoaded,
    LottieImageProviderFactory? imageProviderFactory,
    Key? key,
    AssetBundle? bundle,
    Widget Function(BuildContext, Widget, LottieComposition?)? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    double? width,
    double? height,
    BoxFit? fit,
    AlignmentGeometry? alignment,
    String? package,
    bool? addRepaintBoundary,
    FilterQuality? filterQuality,
    void Function(String)? onWarning,
  }) {
    return Lottie.asset(
      _assetName,
      controller: controller,
      animate: animate,
      frameRate: frameRate,
      repeat: repeat,
      reverse: reverse,
      delegates: delegates,
      options: options,
      onLoaded: onLoaded,
      imageProviderFactory: imageProviderFactory,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      package: package,
      addRepaintBoundary: addRepaintBoundary,
      filterQuality: filterQuality,
      onWarning: onWarning,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
