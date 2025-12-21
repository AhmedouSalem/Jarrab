import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff6141cb),
      surfaceTint: Color(0xff6444cd),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff7b5ce5),
      onPrimaryContainer: Color(0xfffffbff),
      secondary: Color(0xff00696e),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff51f2fb),
      onSecondaryContainer: Color(0xff006c71),
      tertiary: Color(0xff9e2b86),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffbc46a1),
      onTertiaryContainer: Color(0xfffffbff),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfffdf8f8),
      onSurface: Color(0xff1c1b1b),
      onSurfaceVariant: Color(0xff484554),
      outline: Color(0xff797585),
      outlineVariant: Color(0xffcac4d6),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff313030),
      inversePrimary: Color(0xffccbeff),
      primaryFixed: Color(0xffe7deff),
      onPrimaryFixed: Color(0xff1e0060),
      primaryFixedDim: Color(0xffccbeff),
      onPrimaryFixedVariant: Color(0xff4c26b4),
      secondaryFixed: Color(0xff66f7ff),
      onSecondaryFixed: Color(0xff002021),
      secondaryFixedDim: Color(0xff2bdbe4),
      onSecondaryFixedVariant: Color(0xff004f53),
      tertiaryFixed: Color(0xffffd7ee),
      onTertiaryFixed: Color(0xff3a0030),
      tertiaryFixedDim: Color(0xffffade4),
      onTertiaryFixedVariant: Color(0xff830c6f),
      surfaceDim: Color(0xffddd9d8),
      surfaceBright: Color(0xfffdf8f8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff7f3f2),
      surfaceContainer: Color(0xfff1edec),
      surfaceContainerHigh: Color(0xffebe7e7),
      surfaceContainerHighest: Color(0xffe5e2e1),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff3b04a4),
      surfaceTint: Color(0xff6444cd),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff7354dd),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff003d40),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff00797f),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff690058),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffb33e98),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffdf8f8),
      onSurface: Color(0xff111111),
      onSurfaceVariant: Color(0xff383443),
      outline: Color(0xff545060),
      outlineVariant: Color(0xff6f6b7b),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff313030),
      inversePrimary: Color(0xffccbeff),
      primaryFixed: Color(0xff7354dd),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff5a39c3),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff00797f),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff005f63),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xffb33e98),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff95227e),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc9c6c5),
      surfaceBright: Color(0xfffdf8f8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff7f3f2),
      surfaceContainer: Color(0xffebe7e7),
      surfaceContainerHigh: Color(0xffe0dcdb),
      surfaceContainerHighest: Color(0xffd4d1d0),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff30008c),
      surfaceTint: Color(0xff6444cd),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff4e2ab7),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff003234),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff005256),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff570049),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff861171),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffdf8f8),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff2d2a38),
      outlineVariant: Color(0xff4b4756),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff313030),
      inversePrimary: Color(0xffccbeff),
      primaryFixed: Color(0xff4e2ab7),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff37009d),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff005256),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff00393c),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff861171),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff630053),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffbbb8b7),
      surfaceBright: Color(0xfffdf8f8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff4f0ef),
      surfaceContainer: Color(0xffe5e2e1),
      surfaceContainerHigh: Color(0xffd7d4d3),
      surfaceContainerHighest: Color(0xffc9c6c5),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffccbeff),
      surfaceTint: Color(0xffccbeff),
      onPrimary: Color(0xff340097),
      primaryContainer: Color(0xff977cff),
      onPrimaryContainer: Color(0xff0b0031),
      secondary: Color(0xffe7feff),
      onSecondary: Color(0xff003739),
      secondaryContainer: Color(0xff51f2fb),
      onSecondaryContainer: Color(0xff006c71),
      tertiary: Color(0xffffade4),
      onTertiary: Color(0xff5f0050),
      tertiaryContainer: Color(0xffde63bf),
      onTertiaryContainer: Color(0xff1a0015),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff141313),
      onSurface: Color(0xffe5e2e1),
      onSurfaceVariant: Color(0xffcac4d6),
      outline: Color(0xff938e9f),
      outlineVariant: Color(0xff484554),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e2e1),
      inversePrimary: Color(0xff6444cd),
      primaryFixed: Color(0xffe7deff),
      onPrimaryFixed: Color(0xff1e0060),
      primaryFixedDim: Color(0xffccbeff),
      onPrimaryFixedVariant: Color(0xff4c26b4),
      secondaryFixed: Color(0xff66f7ff),
      onSecondaryFixed: Color(0xff002021),
      secondaryFixedDim: Color(0xff2bdbe4),
      onSecondaryFixedVariant: Color(0xff004f53),
      tertiaryFixed: Color(0xffffd7ee),
      onTertiaryFixed: Color(0xff3a0030),
      tertiaryFixedDim: Color(0xffffade4),
      onTertiaryFixedVariant: Color(0xff830c6f),
      surfaceDim: Color(0xff141313),
      surfaceBright: Color(0xff3a3939),
      surfaceContainerLowest: Color(0xff0e0e0e),
      surfaceContainerLow: Color(0xff1c1b1b),
      surfaceContainer: Color(0xff201f1f),
      surfaceContainerHigh: Color(0xff2b2a2a),
      surfaceContainerHighest: Color(0xff353434),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffe1d7ff),
      surfaceTint: Color(0xffccbeff),
      onPrimary: Color(0xff29007b),
      primaryContainer: Color(0xff977cff),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffe7feff),
      onSecondary: Color(0xff003739),
      secondaryContainer: Color(0xff51f2fb),
      onSecondaryContainer: Color(0xff004d50),
      tertiary: Color(0xffffcfec),
      onTertiary: Color(0xff4c003f),
      tertiaryContainer: Color(0xffde63bf),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff141313),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffe0d9ec),
      outline: Color(0xffb5afc1),
      outlineVariant: Color(0xff938e9f),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e2e1),
      inversePrimary: Color(0xff4d28b6),
      primaryFixed: Color(0xffe7deff),
      onPrimaryFixed: Color(0xff130044),
      primaryFixedDim: Color(0xffccbeff),
      onPrimaryFixedVariant: Color(0xff3b04a4),
      secondaryFixed: Color(0xff66f7ff),
      onSecondaryFixed: Color(0xff001416),
      secondaryFixedDim: Color(0xff2bdbe4),
      onSecondaryFixedVariant: Color(0xff003d40),
      tertiaryFixed: Color(0xffffd7ee),
      onTertiaryFixed: Color(0xff280021),
      tertiaryFixedDim: Color(0xffffade4),
      onTertiaryFixedVariant: Color(0xff690058),
      surfaceDim: Color(0xff141313),
      surfaceBright: Color(0xff454444),
      surfaceContainerLowest: Color(0xff070707),
      surfaceContainerLow: Color(0xff1e1d1d),
      surfaceContainer: Color(0xff282827),
      surfaceContainerHigh: Color(0xff333232),
      surfaceContainerHighest: Color(0xff3e3d3d),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfff4edff),
      surfaceTint: Color(0xffccbeff),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffc8b9ff),
      onPrimaryContainer: Color(0xff0b0031),
      secondary: Color(0xffe7feff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xff51f2fb),
      onSecondaryContainer: Color(0xff002b2e),
      tertiary: Color(0xffffebf4),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffffa6e2),
      onTertiaryContainer: Color(0xff1a0015),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff141313),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xfff4edff),
      outlineVariant: Color(0xffc6c0d2),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e2e1),
      inversePrimary: Color(0xff4d28b6),
      primaryFixed: Color(0xffe7deff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffccbeff),
      onPrimaryFixedVariant: Color(0xff130044),
      secondaryFixed: Color(0xff66f7ff),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xff2bdbe4),
      onSecondaryFixedVariant: Color(0xff001416),
      tertiaryFixed: Color(0xffffd7ee),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffffade4),
      onTertiaryFixedVariant: Color(0xff280021),
      surfaceDim: Color(0xff141313),
      surfaceBright: Color(0xff51504f),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff201f1f),
      surfaceContainer: Color(0xff313030),
      surfaceContainerHigh: Color(0xff3c3b3b),
      surfaceContainerHighest: Color(0xff484646),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textTheme: textTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    ),
    scaffoldBackgroundColor: colorScheme.surface,
    canvasColor: colorScheme.surface,
  );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
