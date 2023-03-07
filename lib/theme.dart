import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

final lightAppBarTheme = const AppBarTheme(
    centerTitle: false,
    elevation: 0,
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.black));

final darkAppBarTheme = const AppBarTheme(
    centerTitle: false,
    elevation: 0,
    backgroundColor: Colors.black,
    iconTheme: IconThemeData(color: Colors.white));

final tabBarTheme = TabBarTheme(
  indicatorSize: TabBarIndicatorSize.label,
  unselectedLabelColor: Colors.black54,
  indicator: BoxDecoration(
    borderRadius: BorderRadius.circular(50),
    color: kPrimary,
  ),
);

final dividerTheme =
    const DividerThemeData().copyWith(thickness: 1.0, indent: 75.0);

ThemeData lightTheme(BuildContext context) => ThemeData.light().copyWith(
      primaryColor: kPrimary,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: lightAppBarTheme,
      tabBarTheme: tabBarTheme,
      dividerTheme: dividerTheme.copyWith(color: kIconLight),
      iconTheme: const IconThemeData(color: Colors.white),
      textTheme: GoogleFonts.openSansTextTheme(Theme.of(context).textTheme)
          .apply(displayColor: Colors.black, bodyColor: Colors.black),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );

ThemeData darkTheme(BuildContext context) => ThemeData.dark().copyWith(
      colorScheme: const ColorScheme.dark(),
      primaryColor: kPrimary,
      scaffoldBackgroundColor: Colors.black,
      tabBarTheme: tabBarTheme.copyWith(unselectedLabelColor: Colors.white70),
      appBarTheme: darkAppBarTheme,
      dividerTheme: dividerTheme.copyWith(color: kBubbleDark),
      iconTheme: const IconThemeData(color: Colors.white),
      textTheme:
          GoogleFonts.openSansTextTheme(Theme.of(context).textTheme).apply(
        displayColor: Colors.white,
        bodyColor: Colors.white,
      ),
      //.apply(displayColor: Colors.white),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );

bool isLightTheme(BuildContext context) {
  return MediaQuery.of(context).platformBrightness == Brightness.light;
}
