import 'package:flutter/material.dart';

import 'colors.dart';

// ignore: non_constant_identifier_names
final ThemeData EzTheme = _buildEzTheme();

ThemeData _buildEzTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
      primaryColor: color_primary,
      buttonTheme: base.buttonTheme.copyWith(

      ),
      inputDecorationTheme: base.inputDecorationTheme.copyWith(
          fillColor: color_white,
          filled: true,

          hintStyle: TextStyle(
              color: color_green_dark, fontSize: 13.5, fontFamily: 'Montserrat')),
      appBarTheme: base.appBarTheme
          .copyWith(color: color_white, shadowColor: Colors.transparent),
      cardTheme: CardTheme(
        clipBehavior: Clip.antiAlias,
          color: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0),
      textTheme: _buildEzTextTheme(base.textTheme));
}

TextTheme _buildEzTextTheme(TextTheme base) {
  return base
      .copyWith(
          headline5: base.headline5.copyWith(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontFamily: 'Comfortaa'),
          headline6: base.headline6
              .copyWith(fontWeight: FontWeight.bold, fontFamily: 'Comfortaa'),
          bodyText1:
              base.bodyText1.copyWith(fontSize: 18, fontFamily: 'Montserrat'),
          bodyText2:
              base.bodyText2.copyWith(fontSize: 12, fontFamily: 'Montserrat'))
      .apply(bodyColor: color_green_dark);
}
