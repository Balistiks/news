import 'package:flutter/material.dart';

final mainTheme = ThemeData(
  dividerColor: Colors.white24,
  primarySwatch: Colors.yellow,
  primaryColor: Color.fromARGB(255, 64, 143, 37),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 26, 26, 26),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w500,
    )
  ),
  scaffoldBackgroundColor: Color.fromARGB(255, 67, 63, 63),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w700,
      fontSize: 20,
    ),
    labelSmall: TextStyle(
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.w700
    ),
  )
);