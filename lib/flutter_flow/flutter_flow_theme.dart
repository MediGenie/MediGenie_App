// ignore_for_file: overridden_fields, annotate_overrides

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:shared_preferences/shared_preferences.dart';

const kThemeModeKey = '__theme_mode__';
SharedPreferences? _prefs;

abstract class FlutterFlowTheme {
  late AlertStyle alertStyle;

  static Future initialize() async => _prefs = await SharedPreferences.getInstance();
  static ThemeMode get themeMode {
    final darkMode = _prefs?.getBool(kThemeModeKey);
    return darkMode == null
        ? ThemeMode.system
        : darkMode
            ? ThemeMode.dark
            : ThemeMode.light;
  }

  static void saveThemeMode(ThemeMode mode) =>
      mode == ThemeMode.system ? _prefs?.remove(kThemeModeKey) : _prefs?.setBool(kThemeModeKey, mode == ThemeMode.dark);

  static FlutterFlowTheme of(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? DarkModeTheme() : LightModeTheme();
  }

  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary;
  late Color secondary;
  late Color tertiary;
  late Color alternate;
  late Color primaryText;
  late Color secondaryText;
  late Color primaryBackground;
  late Color secondaryBackground;
  late Color accent1;
  late Color accent2;
  late Color accent3;
  late Color accent4;
  late Color success;
  late Color warning;
  late Color error;
  late Color info;

  late Color divider;
  late Color tertiaryText;
  late Color disabledText;
  late Color disabledBackground;
  late Color grey900;

  late Color successBackground;
  late Color warningBackground;
  late Color errorBackground;

  @Deprecated('Use displaySmallFamily instead')
  String get title1Family => displaySmallFamily;
  @Deprecated('Use displaySmall instead')
  TextStyle get title1 => typography.displaySmall;
  @Deprecated('Use headlineMediumFamily instead')
  String get title2Family => typography.headlineMediumFamily;
  @Deprecated('Use headlineMedium instead')
  TextStyle get title2 => typography.headlineMedium;
  @Deprecated('Use headlineSmallFamily instead')
  String get title3Family => typography.headlineSmallFamily;
  @Deprecated('Use headlineSmall instead')
  TextStyle get title3 => typography.headlineSmall;
  @Deprecated('Use titleMediumFamily instead')
  String get subtitle1Family => typography.titleMediumFamily;
  @Deprecated('Use titleMedium instead')
  TextStyle get subtitle1 => typography.titleMedium;
  @Deprecated('Use titleSmallFamily instead')
  String get subtitle2Family => typography.titleSmallFamily;
  @Deprecated('Use titleSmall instead')
  TextStyle get subtitle2 => typography.titleSmall;
  @Deprecated('Use bodyMediumFamily instead')
  String get bodyText1Family => typography.bodyMediumFamily;
  @Deprecated('Use bodyMedium instead')
  TextStyle get bodyText1 => typography.bodyMedium;
  @Deprecated('Use bodySmallFamily instead')
  String get bodyText2Family => typography.bodySmallFamily;
  @Deprecated('Use bodySmall instead')
  TextStyle get bodyText2 => typography.bodySmall;

  String get displayLargeFamily => typography.displayLargeFamily;
  TextStyle get displayLarge => typography.displayLarge;
  String get displayMediumFamily => typography.displayMediumFamily;
  TextStyle get displayMedium => typography.displayMedium;
  String get displaySmallFamily => typography.displaySmallFamily;
  TextStyle get displaySmall => typography.displaySmall;
  String get headlineLargeFamily => typography.headlineLargeFamily;
  TextStyle get headlineLarge => typography.headlineLarge;
  String get headlineMediumFamily => typography.headlineMediumFamily;
  TextStyle get headlineMedium => typography.headlineMedium;
  String get headlineSmallFamily => typography.headlineSmallFamily;
  TextStyle get headlineSmall => typography.headlineSmall;
  String get titleLargeFamily => typography.titleLargeFamily;
  TextStyle get titleLarge => typography.titleLarge;
  String get titleMediumFamily => typography.titleMediumFamily;
  TextStyle get titleMedium => typography.titleMedium;
  String get titleSmallFamily => typography.titleSmallFamily;
  TextStyle get titleSmall => typography.titleSmall;
  String get labelLargeFamily => typography.labelLargeFamily;
  TextStyle get labelLarge => typography.labelLarge;
  String get labelMediumFamily => typography.labelMediumFamily;
  TextStyle get labelMedium => typography.labelMedium;
  String get labelSmallFamily => typography.labelSmallFamily;
  TextStyle get labelSmall => typography.labelSmall;
  String get bodyLargeFamily => typography.bodyLargeFamily;
  TextStyle get bodyLarge => typography.bodyLarge;
  String get bodyMediumFamily => typography.bodyMediumFamily;
  TextStyle get bodyMedium => typography.bodyMedium;
  String get bodySmallFamily => typography.bodySmallFamily;
  TextStyle get bodySmall => typography.bodySmall;
  String get captionLargeFamily => typography.captionLargeFamily;
  TextStyle get captionLarge => typography.captionLarge;

  Typography get typography => ThemeTypography(this);
}

class LightModeTheme extends FlutterFlowTheme {
  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary = const Color(0xFF017BFF);
  late Color secondary = const Color(0xFFCCE973);
  late Color tertiary = const Color(0xFFFFC96F);
  late Color alternate = const Color(0xFFFF6871);
  late Color primaryText = const Color(0xFF111314);
  late Color secondaryText = const Color(0xFF495057);
  late Color primaryBackground = const Color(0xFFECEEF0);
  late Color secondaryBackground = const Color(0xFFFAFAFA);
  late Color accent1 = const Color(0xFFCCE4FF);
  late Color accent2 = const Color(0xFFE5F2FF);
  late Color accent3 = const Color(0xFFE0E0E0);
  late Color accent4 = const Color(0xFFEEEEEE);
  late Color success = const Color(0xFF35CB00);
  late Color warning = const Color(0xFFFCBA10);
  late Color error = const Color(0xFFDE1936);
  late Color info = const Color(0xFF1A3C89);

  late Color divider = const Color(0xFFDCDFE3);
  late Color tertiaryText = const Color(0xFFF8F9FA);
  late Color disabledText = const Color(0xFFADB5BD);
  late Color disabledBackground = const Color(0xFFDEE2E6);
  late Color grey900 = const Color(0xFF212529);
  late Color successBackground = const Color(0xFF89E768);
  late Color warningBackground = const Color(0xFFFFD159);
  late Color errorBackground = const Color(0xFFFF7387);

  late AlertStyle alertStyle = AlertStyle(
    animationType: AnimationType.fromTop,
    isCloseButton: false,
    isOverlayTapDismiss: true,
    descStyle: typography.bodyMedium,
    descTextAlign: TextAlign.start,
    animationDuration: const Duration(milliseconds: 300),
    backgroundColor: secondaryBackground,
    alertPadding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
    descPadding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 0.0),
    buttonAreaPadding: const EdgeInsets.fromLTRB(14.0, 14.0, 14.0, 20.0),
    titlePadding: const EdgeInsets.fromLTRB(14.0, 14.0, 14.0, 14.0),
    alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
      side: const BorderSide(
        color: Colors.grey,
      ),
    ),
    titleStyle: typography.headlineLarge,
    titleTextAlign: TextAlign.start,
    alertAlignment: Alignment.center,
  );
}

abstract class Typography {
  String get displayLargeFamily;
  TextStyle get displayLarge;
  String get displayMediumFamily;
  TextStyle get displayMedium;
  String get displaySmallFamily;
  TextStyle get displaySmall;
  String get headlineLargeFamily;
  TextStyle get headlineLarge;
  String get headlineMediumFamily;
  TextStyle get headlineMedium;
  String get headlineSmallFamily;
  TextStyle get headlineSmall;
  String get titleLargeFamily;
  TextStyle get titleLarge;
  String get titleMediumFamily;
  TextStyle get titleMedium;
  String get titleSmallFamily;
  TextStyle get titleSmall;
  String get labelLargeFamily;
  TextStyle get labelLarge;
  String get labelMediumFamily;
  TextStyle get labelMedium;
  String get labelSmallFamily;
  TextStyle get labelSmall;
  String get bodyLargeFamily;
  TextStyle get bodyLarge;
  String get bodyMediumFamily;
  TextStyle get bodyMedium;
  String get bodySmallFamily;
  TextStyle get bodySmall;
  String get captionLargeFamily;
  TextStyle get captionLarge;
}

class ThemeTypography extends Typography {
  ThemeTypography(this.theme);

  final FlutterFlowTheme theme;

  String get displayLargeFamily => 'Plus Jakarta Sans';
  TextStyle get displayLarge => GoogleFonts.getFont(
        'Plus Jakarta Sans',
        color: theme.primaryText,
        fontWeight: FontWeight.w700,
        fontSize: 28.0,
      );
  String get displayMediumFamily => 'Plus Jakarta Sans';
  TextStyle get displayMedium => GoogleFonts.getFont(
        'Plus Jakarta Sans',
        color: theme.primaryText,
        fontWeight: FontWeight.w700,
        fontSize: 24.0,
      );
  String get displaySmallFamily => 'Plus Jakarta Sans';
  TextStyle get displaySmall => GoogleFonts.getFont(
        'Plus Jakarta Sans',
        color: theme.primaryText,
        fontWeight: FontWeight.bold,
        fontSize: 22.0,
      );
  String get headlineLargeFamily => 'Plus Jakarta Sans';
  TextStyle get headlineLarge => GoogleFonts.getFont(
        'Plus Jakarta Sans',
        color: theme.primaryText,
        fontWeight: FontWeight.bold,
        fontSize: 18.0,
      );
  String get headlineMediumFamily => 'Plus Jakarta Sans';
  TextStyle get headlineMedium => GoogleFonts.getFont(
        'Plus Jakarta Sans',
        color: theme.primaryText,
        fontWeight: FontWeight.bold,
        fontSize: 16.0,
      );
  String get headlineSmallFamily => 'Plus Jakarta Sans';
  TextStyle get headlineSmall => GoogleFonts.getFont(
        'Plus Jakarta Sans',
        color: theme.primaryText,
        fontWeight: FontWeight.bold,
        fontSize: 14.0,
      );
  String get titleLargeFamily => 'Plus Jakarta Sans';
  TextStyle get titleLarge => GoogleFonts.getFont(
        'Plus Jakarta Sans',
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 18.0,
      );
  String get titleMediumFamily => 'Plus Jakarta Sans';
  TextStyle get titleMedium => GoogleFonts.getFont(
        'Plus Jakarta Sans',
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 16.0,
      );
  String get titleSmallFamily => 'Plus Jakarta Sans';
  TextStyle get titleSmall => GoogleFonts.getFont(
        'Plus Jakarta Sans',
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 14.0,
      );
  String get labelLargeFamily => 'Plus Jakarta Sans';
  TextStyle get labelLarge => GoogleFonts.getFont(
        'Plus Jakarta Sans',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
      );
  String get labelMediumFamily => 'Plus Jakarta Sans';
  TextStyle get labelMedium => GoogleFonts.getFont(
        'Plus Jakarta Sans',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 14.0,
      );
  String get labelSmallFamily => 'Plus Jakarta Sans';
  TextStyle get labelSmall => GoogleFonts.getFont(
        'Plus Jakarta Sans',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 12.0,
      );
  String get bodyLargeFamily => 'Plus Jakarta Sans';
  TextStyle get bodyLarge => GoogleFonts.getFont(
        'Plus Jakarta Sans',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 16.0,
      );
  String get bodyMediumFamily => 'Plus Jakarta Sans';
  TextStyle get bodyMedium => GoogleFonts.getFont(
        'Plus Jakarta Sans',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 14.0,
      );
  String get bodySmallFamily => 'Plus Jakarta Sans';
  TextStyle get bodySmall => GoogleFonts.getFont(
        'Plus Jakarta Sans',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 12.0,
      );
  String get captionLargeFamily => 'Plus Jakarta Sans';
  TextStyle get captionLarge => GoogleFonts.getFont(
        'Plus Jakarta Sans',
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 10.0,
      );
}

class DarkModeTheme extends FlutterFlowTheme {
  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary = const Color(0xFF4B39EF);
  late Color secondary = const Color(0xFF39D2C0);
  late Color tertiary = const Color(0xFFEE8B60);
  late Color alternate = const Color(0xFFFF5963);
  late Color primaryText = const Color(0xFFFFFFFF);
  late Color secondaryText = const Color(0xFF95A1AC);
  late Color primaryBackground = const Color(0xFF101213);
  late Color secondaryBackground = const Color(0xFF1A1F24);
  late Color accent1 = const Color(0xFFEEEEEE);
  late Color accent2 = const Color(0xFFE0E0E0);
  late Color accent3 = const Color(0xFF757575);
  late Color accent4 = const Color(0xFF616161);
  late Color success = const Color(0xFF04A24C);
  late Color warning = const Color(0xFFFCDC0C);
  late Color error = const Color(0xFFE21C3D);
  late Color info = const Color(0xFF1C4494);

  late Color divider = const Color(0xFF3D323B);
  late Color tertiaryText = const Color(0xFFA33B68);
  late Color disabledText = const Color(0xFF58D1A1);
  late Color disabledBackground = const Color(0xFF29746E);
  late Color grey900 = const Color(0xFF212529);
  late Color successBackground = const Color(0xFF89E768);
  late Color warningBackground = const Color(0xFFFFD159);
  late Color errorBackground = const Color(0xFFFF7387);
}

extension TextStyleHelper on TextStyle {
  TextStyle override({
    String? fontFamily,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    FontStyle? fontStyle,
    bool useGoogleFonts = true,
    TextDecoration? decoration,
    double? lineHeight,
  }) =>
      useGoogleFonts
          ? GoogleFonts.getFont(
              fontFamily!,
              color: color ?? this.color,
              fontSize: fontSize ?? this.fontSize,
              letterSpacing: letterSpacing ?? this.letterSpacing,
              fontWeight: fontWeight ?? this.fontWeight,
              fontStyle: fontStyle ?? this.fontStyle,
              decoration: decoration,
              height: lineHeight,
            )
          : copyWith(
              fontFamily: fontFamily,
              color: color,
              fontSize: fontSize,
              letterSpacing: letterSpacing,
              fontWeight: fontWeight,
              fontStyle: fontStyle,
              decoration: decoration,
              height: lineHeight,
            );
}
