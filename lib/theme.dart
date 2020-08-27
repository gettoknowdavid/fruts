import 'package:flutter/material.dart';

const Color primary = const Color(0xFFFFFFFF);
const Color primaryVariant = const Color(0xFFEDF2EC);
const Color secondary = const Color(0xFF583752);
const Color secondaryVariant = const Color(0xFFF15968);

class FrutsTheme {
  static get theme {
    final base = ThemeData.light();

    ColorScheme colorScheme = ColorScheme.light(
      primary: primary,
      primaryVariant: primaryVariant,
      onPrimary: secondary,
      secondary: secondary,
      secondaryVariant: secondaryVariant,
      onSecondary: primaryVariant,
    );

    return base.copyWith(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: primary,
      canvasColor: Colors.transparent,
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(80),
        ),
        buttonColor: secondary,
        hoverColor: secondary.withOpacity(0.7),
        colorScheme: colorScheme,
      ),
      iconTheme: _iconTheme(base.iconTheme),
      accentIconTheme: _iconTheme(base.accentIconTheme),
      primaryIconTheme: _iconTheme(base.primaryIconTheme),
      textTheme: _textTheme(base.textTheme),
      accentTextTheme: _textTheme(base.accentTextTheme),
      primaryTextTheme: _textTheme(base.primaryTextTheme),
    );
  }
}

TextTheme _textTheme(TextTheme base) {
  return base
      .copyWith(headline6: base.headline6.copyWith(fontSize: 19))
      .apply(fontFamily: 'ProductSans');
}

IconThemeData _iconTheme(IconThemeData base) {
  return base.copyWith();
}
