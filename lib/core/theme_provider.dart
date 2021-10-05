import 'package:flutter/material.dart';

class MyThemes {
  static final darkTheme = ThemeData(
      scaffoldBackgroundColor: Colors.grey.shade800,
      backgroundColor: Colors.grey.shade800,
      fontFamily: 'Montserrat',
      colorScheme: ColorScheme.dark(),
      textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.white,selectionColor: Colors.black38),
  );

  static final lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      backgroundColor: Colors.white,
      fontFamily: 'Montserrat',
      colorScheme: ColorScheme.light(),
      textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.black,selectionColor: Colors.black38),
  );
}