/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AssetsFontsGen {
  const $AssetsFontsGen();
}

class $AssetsJpgGen {
  const $AssetsJpgGen();

  /// File path: assets/jpg/auth.jpg
  AssetGenImage get auth => const AssetGenImage('assets/jpg/auth.jpg');

  /// File path: assets/jpg/auth_header.jpeg
  AssetGenImage get authHeader =>
      const AssetGenImage('assets/jpg/auth_header.jpeg');

  /// File path: assets/jpg/user.jpg
  AssetGenImage get user => const AssetGenImage('assets/jpg/user.jpg');

  /// List of all assets
  List<AssetGenImage> get values => [auth, authHeader, user];
}

class $AssetsPngGen {
  const $AssetsPngGen();

  /// File path: assets/png/user.png
  AssetGenImage get user => const AssetGenImage('assets/png/user.png');

  /// List of all assets
  List<AssetGenImage> get values => [user];
}

class $AssetsSvgGen {
  const $AssetsSvgGen();

  /// File path: assets/svg/Filter.svg
  SvgGenImage get filter => const SvgGenImage('assets/svg/Filter.svg');

  /// File path: assets/svg/Home.svg
  SvgGenImage get home => const SvgGenImage('assets/svg/Home.svg');

  /// File path: assets/svg/Notification.svg
  SvgGenImage get notification =>
      const SvgGenImage('assets/svg/Notification.svg');

  /// File path: assets/svg/Profile.svg
  SvgGenImage get profile => const SvgGenImage('assets/svg/Profile.svg');

  /// File path: assets/svg/Search.svg
  SvgGenImage get search => const SvgGenImage('assets/svg/Search.svg');

  /// File path: assets/svg/add_new.svg
  SvgGenImage get addNew => const SvgGenImage('assets/svg/add_new.svg');

  /// File path: assets/svg/arrowup.svg
  SvgGenImage get arrowup => const SvgGenImage('assets/svg/arrowup.svg');

  /// File path: assets/svg/chart.svg
  SvgGenImage get chart => const SvgGenImage('assets/svg/chart.svg');

  /// File path: assets/svg/deposit.svg
  SvgGenImage get deposit => const SvgGenImage('assets/svg/deposit.svg');

  /// File path: assets/svg/email.svg
  SvgGenImage get email => const SvgGenImage('assets/svg/email.svg');

  /// File path: assets/svg/error.svg
  SvgGenImage get error => const SvgGenImage('assets/svg/error.svg');

  /// File path: assets/svg/faceId.svg
  SvgGenImage get faceId => const SvgGenImage('assets/svg/faceId.svg');

  /// File path: assets/svg/google.svg
  SvgGenImage get google => const SvgGenImage('assets/svg/google.svg');

  /// File path: assets/svg/insights.svg
  SvgGenImage get insights => const SvgGenImage('assets/svg/insights.svg');

  /// File path: assets/svg/investments.svg
  SvgGenImage get investments =>
      const SvgGenImage('assets/svg/investments.svg');

  /// File path: assets/svg/logo.svg
  SvgGenImage get logo => const SvgGenImage('assets/svg/logo.svg');

  /// File path: assets/svg/pin.svg
  SvgGenImage get pin => const SvgGenImage('assets/svg/pin.svg');

  /// File path: assets/svg/settings.svg
  SvgGenImage get settings => const SvgGenImage('assets/svg/settings.svg');

  /// File path: assets/svg/withdraw.svg
  SvgGenImage get withdraw => const SvgGenImage('assets/svg/withdraw.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
        filter,
        home,
        notification,
        profile,
        search,
        addNew,
        arrowup,
        chart,
        deposit,
        email,
        error,
        faceId,
        google,
        insights,
        investments,
        logo,
        pin,
        settings,
        withdraw
      ];
}

class Assets {
  const Assets._();

  static const String aEnv = '.env';
  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsJpgGen jpg = $AssetsJpgGen();
  static const $AssetsPngGen png = $AssetsPngGen();
  static const $AssetsSvgGen svg = $AssetsSvgGen();

  /// List of all assets
  static List<String> get values => [aEnv];
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
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
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

class SvgGenImage {
  const SvgGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = false;

  const SvgGenImage.vec(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter: colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
