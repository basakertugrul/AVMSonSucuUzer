import 'package:flutter/material.dart';

TextStyle listTitleDefaultTextStyle = TextStyle(color: unSelectedColor, fontSize: 20.0, fontWeight: FontWeight.w700);
TextStyle listTitleSelectedTextStyle = TextStyle(color: selectedColor, fontSize: 20.0, fontWeight: FontWeight.w700);

Color selectedColor = Color.fromRGBO(80, 77, 229, 1);
Color unSelectedColor = Colors.grey;
Color drawerBackgroundColor = Colors.white;

final darkTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.black,
  brightness: Brightness.dark,
  backgroundColor: const Color(0xFF212121),
  accentColor: Colors.white,
  accentIconTheme: IconThemeData(color: Colors.black),
  dividerColor: Colors.black12,
);

final lightTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.white,
  brightness: Brightness.light,
  backgroundColor: const Color(0xFFE5E5E5),
  accentColor: Colors.black,
  accentIconTheme: IconThemeData(color: Colors.white),
  dividerColor: Colors.white54,
);