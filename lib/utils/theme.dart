import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

const lightAppBarTheme = AppBarTheme(
    centerTitle: false,
    elevation: 0,
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.black));

const darkAppBarTheme = AppBarTheme(
    centerTitle: false,
    elevation: 0,
    backgroundColor: kAppBarDark,
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
      primaryColor: kWhite,
      scaffoldBackgroundColor: kPrimary,
      tabBarTheme: tabBarTheme.copyWith(unselectedLabelColor: Colors.white70),
      appBarTheme: darkAppBarTheme,
      dividerTheme: dividerTheme.copyWith(color: kBubbleDark),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              iconColor: MaterialStateColor.resolveWith((states) => kWhite),
              backgroundColor: MaterialStateProperty.resolveWith(
                  (states) => Colors.transparent),
              foregroundColor:
                  MaterialStateColor.resolveWith((states) => kWhite),
              shape: MaterialStateProperty.resolveWith(
                  (states) => RoundedRectangleBorder(
                      side: const BorderSide(
                        color: kWhite,
                      ),
                      borderRadius: BorderRadius.circular(kBorderRadius))),
              textStyle: MaterialStateProperty.resolveWith(
                  (states) => const TextStyle(color: kWhite)))),
      iconTheme: const IconThemeData(color: kWhite, size: kDefaultIconSize),
      textTheme: const TextTheme(
          headlineSmall: TextStyle(
              fontSize: kSmallHeadlineFontSize,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis),
          headlineMedium: TextStyle(
              fontSize: kMediumHeadlineFontSize,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis),
          bodySmall: TextStyle(
              fontSize: kBodySmallFontSize, overflow: TextOverflow.ellipsis),
          bodyMedium: TextStyle(
              fontSize: kBodyMediumFontSize, overflow: TextOverflow.ellipsis),
          bodyLarge: TextStyle(
              fontSize: kBodyLargeFontSize, overflow: TextOverflow.ellipsis)),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      colorScheme: const ColorScheme.dark().copyWith(background: kPrimary),
    );

bool isLightTheme(BuildContext context) {
  return MediaQuery.of(context).platformBrightness == Brightness.light;
}

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(kBorderRadius),
    borderSide: const BorderSide(color: kWhite),
  );
}

final otpInputDecoration = InputDecoration(
  // focusColor: kWhite,
  contentPadding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

double getProportionateScreenHeight(double inputHeight) {
  // double screenHeight = SizeConfig.screenHeight;
  // 812 is the layout height that designer use
  return (inputHeight / 812.0).sh;
}

double getProportionateScreenWidth(double inputWidth) {
  // double screenWidth = SizeConfig.screenWidth;
  // 375 is the layout width that designer use
  return (inputWidth / 375.0).sw;
}
