import 'package:cirilla/constants/strings.dart';
import 'package:cirilla/models/setting/setting.dart';
import 'package:cirilla/store/setting/setting_store.dart';
import 'package:cirilla/utils/convert_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'utility_mixin.dart' show get;

class ThemeMixin {
  Color _cv(Map<String, dynamic>? color, [defaultColor]) => ConvertData.fromRGBA(color, defaultColor);

  ThemeData buildTheme(SettingStore store) {
    final ThemeData base = store.darkMode ? ThemeData.dark() : ThemeData.light();

    if (store.data == null) return base;

    final WidgetConfig widgetConfig = store.data!.settings!['theme']!.widgets!['theme']!;
    final Map<String, dynamic>? fields = widgetConfig.fields;

    dynamic card = fields?["cardColor"] ?? {
      "value": {
        "r": 255,
        "g": 255,
        "b": 255,
        "a": 1,
      },
      "dark": {
        "r": 49,
        "g": 49,
        "b": 49,
        "a": 1,
      },
    };

    // Typography
    String fontFamily = get(fields, ['fontFamily'], Strings.fontFamily);
    String fontFamilyBody = get(fields, ['fontFamilyBody'], Strings.fontFamily);
    Color displayColor = _cv(get(fields, ['displayColor', store.themeModeKey]), Colors.black);
    Color bodyColor = _cv(get(fields, ['bodyColor', store.themeModeKey]), Colors.black);
    Color? cardColor = _cv(get(card, [store.themeModeKey]), Colors.white);

    // Text theme body
    TextTheme textTheme = GoogleFonts.getTextTheme(fontFamilyBody);

    // Colors Schema
    ColorScheme baseSchema = base.colorScheme;

    Color primary = _cv(get(fields, ['primary', store.themeModeKey]), baseSchema.primary);

    ColorScheme newCirillaColorScheme = ColorScheme(
      primary: primary,
      primaryContainer: _cv(get(fields, ['primaryVariant', store.themeModeKey]), baseSchema.primaryContainer),
      secondary: _cv(get(fields, ['secondary', store.themeModeKey]), baseSchema.secondary),
      secondaryContainer: _cv(get(fields, ['secondaryVariant', store.themeModeKey]), baseSchema.secondaryContainer),
      surface: _cv(get(fields, ['surface', store.themeModeKey]), baseSchema.surface),
      error: _cv(get(fields, ['error', store.themeModeKey]), baseSchema.error),
      onPrimary: _cv(get(fields, ['onPrimary', store.themeModeKey]), baseSchema.onPrimary),
      onSecondary: _cv(get(fields, ['onSecondary', store.themeModeKey]), baseSchema.onSecondary),
      onSurface: _cv(get(fields, ['onSurface', store.themeModeKey]), baseSchema.onSurface),
      onError: _cv(get(fields, ['onError', store.themeModeKey]), baseSchema.onError),
      brightness: store.darkMode ? Brightness.dark : Brightness.light,
    );

    // Appbar
    Color appbarBackgroundColor = _cv(get(fields, ['appBarBackgroundColor', store.themeModeKey]), Colors.black);
    Color appBarIconColor = _cv(get(fields, ['appBarIconColor', store.themeModeKey]), Colors.white);

    Color appBarTextColor = _cv(get(fields, ['appBarTextColor', store.themeModeKey]), Colors.black);

    Color appBarShadowColor = _cv(get(fields, ['appBarShadowColor', store.themeModeKey]), Colors.black);

    double? appBarElevation = ConvertData.stringToDouble(get(fields, ['appBarElevation'], 4));

    // Scaffold
    Color scaffoldBackgroundColor = _cv(get(fields, ['scaffoldBackgroundColor', store.themeModeKey]), Colors.black);

    // Text Fields
    String? textFieldsType = get(fields, ['textFieldsType'], 'filled');
    double? textFieldsBorderRadius = ConvertData.stringToDouble(get(fields, ['textFieldsBorderRadius'], 8));
    double? textFieldsBorderWidth = ConvertData.stringToDouble(get(fields, ['textFieldsBorderWidth'], 1));
    Color textFieldsBorderColor = _cv(get(fields, ['textFieldsBorderColor', store.themeModeKey]), Colors.black);
    Color textFieldsLabelColor = _cv(get(fields, ['textFieldsLabelColor', store.themeModeKey]), displayColor);

    double? textFieldsLabelFontSize = ConvertData.stringToDouble(get(fields, ['textFieldsLabelFontSize'], 14));
    int textFieldsLabelFontWeight = ConvertData.stringToInt(get(fields, ['textFieldsLabelFontWeight'], 3));

    double textFieldsPaddingLeft =
        ConvertData.stringToDouble(get(fields, ['textFieldsPadding', 'textFieldsPaddingLeft'], 0), 0);
    double textFieldsPaddingRight =
        ConvertData.stringToDouble(get(fields, ['textFieldsPadding', 'textFieldsPaddingRight'], 0), 0);
    double textFieldsPaddingBottom =
        ConvertData.stringToDouble(get(fields, ['textFieldsPadding', 'textFieldsPaddingBottom'], 0), 0);
    double textFieldsPaddingTop =
        ConvertData.stringToDouble(get(fields, ['textFieldsPadding', 'textFieldsPaddingTop'], 0), 0);

    // Button
    double buttonBorderRadius = ConvertData.stringToDouble(get(fields, ['buttonBorderRadius'], 8));

    // Divider
    Color dividerColor = _cv(get(fields, ['dividerColor', store.themeModeKey]), Colors.black);

    // Full theme all app
    TextTheme newTextTheme = _buildTextTheme(textTheme, fontFamily, fontFamilyBody, displayColor, bodyColor);

    // Status bar
    int brightnessLight = ConvertData.stringToInt(get(fields, ['brightnessLight'], 1), 1);
    int brightnessDark = ConvertData.stringToInt(get(fields, ['brightnessDark'], 0), 0);

    SystemUiOverlayStyle newLight = brightnessLight == 1 ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light;
    SystemUiOverlayStyle newDark = brightnessDark == 0 ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark;

    return base.copyWith(
      useMaterial3: false, // ignore: deprecated_member_use
      cardColor: cardColor,
      colorScheme: newCirillaColorScheme,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      textTheme: newTextTheme,
      iconTheme: _customIconTheme(base.iconTheme, bodyColor),
      bottomSheetTheme: BottomSheetThemeData(backgroundColor: scaffoldBackgroundColor),
      appBarTheme: AppBarTheme(
        backgroundColor: appbarBackgroundColor,
        iconTheme: _customIconTheme(base.iconTheme, appBarIconColor),
        systemOverlayStyle: store.darkMode
            ? newDark.copyWith(statusBarColor: Colors.transparent)
            : newLight.copyWith(statusBarColor: Colors.transparent),
        titleTextStyle:
            newTextTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500, fontSize: 16, color: appBarTextColor),
        shadowColor: appBarShadowColor,
        elevation: appBarElevation,
      ),
      inputDecorationTheme: base.inputDecorationTheme.copyWith(
        enabledBorder: _buildInputBorder(
          textFieldsType,
          textFieldsBorderRadius,
          textFieldsBorderColor,
          textFieldsBorderWidth,
        ),
        border: _buildInputBorder(
          textFieldsType,
          textFieldsBorderRadius,
          textFieldsBorderColor,
          textFieldsBorderWidth,
        ),
        focusedBorder: _buildInputBorder(
          textFieldsType,
          textFieldsBorderRadius,
          textFieldsBorderColor,
          textFieldsBorderWidth,
        ),
        errorBorder: _buildInputBorder(
          textFieldsType,
          textFieldsBorderRadius,
          textFieldsBorderColor,
          textFieldsBorderWidth,
        ),
        labelStyle: TextStyle(
          color: textFieldsLabelColor,
          fontWeight: FontWeight.values[textFieldsLabelFontWeight],
          fontSize: textFieldsLabelFontSize,
        ),
        contentPadding: EdgeInsetsDirectional.only(
          start: textFieldsPaddingLeft,
          end: textFieldsPaddingRight,
          top: textFieldsPaddingTop,
          bottom: textFieldsPaddingBottom,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(buttonBorderRadius)),
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(buttonBorderRadius)),
          ),
        ),
      ),
      dividerColor: dividerColor,
      primaryColor: primary,
    );
  }

  InputBorder _buildInputBorder(
    String? textFieldsType,
    textFieldsBorderRadius,
    textFieldsBorderColor,
    textFieldsBorderWidth,
  ) {
    return textFieldsType == 'filled'
        ? UnderlineInputBorder(
            borderRadius: BorderRadius.circular(textFieldsBorderRadius),
            borderSide: BorderSide(color: textFieldsBorderColor, width: textFieldsBorderWidth),
          )
        : OutlineInputBorder(
            borderRadius: BorderRadius.circular(textFieldsBorderRadius),
            borderSide: BorderSide(color: textFieldsBorderColor, width: textFieldsBorderWidth),
          );
  }

  TextTheme _buildTextTheme(TextTheme base, String fontFamily, fontFamilyBody, displayColor, bodyColor) {
    return base.copyWith(
      displayLarge: GoogleFonts.getFont(
        fontFamily,
        textStyle: base.displayLarge?.copyWith(
          color: displayColor,
        ),
      ),
      displayMedium: GoogleFonts.getFont(
        fontFamily,
        textStyle: base.displayMedium?.copyWith(
          color: displayColor,
        ),
      ),
      displaySmall: GoogleFonts.getFont(
        fontFamily,
        textStyle: base.displaySmall?.copyWith(
          color: displayColor,
        ),
      ),
      headlineMedium: GoogleFonts.getFont(
        fontFamily,
        textStyle: base.headlineMedium?.copyWith(
          color: displayColor,
        ),
      ),
      headlineSmall: GoogleFonts.getFont(
        fontFamily,
        textStyle: base.headlineSmall?.copyWith(
          color: displayColor,
        ),
      ),
      titleLarge: GoogleFonts.getFont(
        fontFamily,
        textStyle: base.titleLarge?.copyWith(
          color: displayColor,
        ),
        fontWeight: FontWeight.w500,
      ),
      titleMedium: GoogleFonts.getFont(
        fontFamilyBody,
        textStyle: base.titleMedium?.copyWith(
          color: displayColor,
        ),
        fontWeight: FontWeight.w500,
      ),
      titleSmall: GoogleFonts.getFont(
        fontFamilyBody,
        textStyle: base.titleSmall?.copyWith(
          color: displayColor,
        ),
        fontWeight: FontWeight.w500,
      ),
      labelLarge: GoogleFonts.getFont(
        fontFamilyBody,
        textStyle: base.labelLarge?.copyWith(
          color: displayColor,
        ),
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
      bodyLarge: base.bodyLarge?.copyWith(color: bodyColor, fontSize: 16),
      bodyMedium: base.bodyMedium?.copyWith(color: bodyColor, fontSize: 14),
      bodySmall: GoogleFonts.getFont(
        fontFamilyBody,
        textStyle: base.bodySmall?.copyWith(
          color: bodyColor,
        ),
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        fontSize: 12,
      ),
      labelSmall: GoogleFonts.getFont(
        fontFamilyBody,
        textStyle: base.labelSmall?.copyWith(
          color: bodyColor,
        ),
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
        fontSize: 10,
      ),
    );
  }

  IconThemeData _customIconTheme(IconThemeData original, Color appBarIconColor) {
    return original.copyWith(color: appBarIconColor);
  }
}
