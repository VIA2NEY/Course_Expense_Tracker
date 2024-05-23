
import 'package:flutter/material.dart';

import 'package:expenses_tracker/widgets/expenses.dart';


var kColorScheme = ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 96, 59, 181));
var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125)
);


void main() {
  runApp(
    MaterialApp(
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
          // centerTitle: true,
        ),
        cardTheme: CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8)
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer
          )
        ),

        textTheme: ThemeData().textTheme.copyWith(
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            color: kColorScheme.onSecondaryContainer,
            fontSize: 16
          ),
        )
      ),

      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,
        cardTheme: CardTheme().copyWith(
          color: kDarkColorScheme.secondaryContainer,
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8)
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.primaryContainer
          )
        ),
      ),
      themeMode: ThemeMode.system, // Use either the light or dark theme based on what the user has selected in the system settings

      home: Expenses(),
    ),
  );
}