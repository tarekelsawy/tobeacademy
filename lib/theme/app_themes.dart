import 'package:flutter/material.dart';
import '../local/localization_service.dart';
import 'app_colors.dart';

class AppThemes {
  /// Rounded shape ************************************************************
  static var shape =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(12));

  static ThemeData get dark => ThemeData(
        scaffoldBackgroundColor: kPrimary18,
        colorScheme: ColorScheme.dark(
          primary: kPrimary,
          error: kDanger,
          background: kPrimary18,
        ),
        cardColor: kBlack,
        //backgroundColor: kPrimary18,
        primaryColor: kPrimary,
        indicatorColor: kPrimary,
        dividerColor: kGrayF2,
        cardTheme: CardTheme(
            elevation: 16,
            color: kBlack,
            surfaceTintColor: kBlack,
            shape: shape,
            margin: EdgeInsets.zero),
        appBarTheme: const AppBarTheme(
            color: kBlack,
            iconTheme: IconThemeData(color: kWhite),
            surfaceTintColor: kBlack),
        textTheme: TextTheme(
            displayLarge: TextStyle(
              color: kWhite,
              fontFamily: kBold,
            ),
            displayMedium: TextStyle(
              color: kWhite,
              fontFamily: kMedium,
            ),
            displaySmall: TextStyle(
              color: kWhite,
              fontFamily: kRegular,
            ),
            headlineLarge: TextStyle(
              color: kWhite,
              fontFamily: kLight,
            ),
            headlineMedium:
                TextStyle(color: kPrimaryLight, fontFamily: kMedium),
            bodyLarge: TextStyle(color: kPrimaryLight, fontFamily: kBold)),
      );
  static ThemeData get light => ThemeData(
        scaffoldBackgroundColor: kGreyF9,
        colorScheme: ColorScheme.light(
          primary: kPrimary,
          error: kDanger,
          background: kGreyF9,
        ),
        //errorColor: kDanger,
        cardColor: kWhite,
        //backgroundColor: kGreyF9,
        primaryColor: kPrimary,
        indicatorColor: kPrimary,
        dividerColor: kGrayF2,
        cardTheme: CardTheme(
            elevation: 16,
            color: kWhite,
            surfaceTintColor: kWhite,
            shape: shape,
            margin: EdgeInsets.zero),
        appBarTheme: const AppBarTheme(
            color: kWhite,
            iconTheme: IconThemeData(color: kBlack),
            surfaceTintColor: kWhite),
        textTheme: TextTheme(
            displayLarge: TextStyle(
              color: kBlack,
              fontFamily: kBold,
            ),
            displayMedium: TextStyle(
              color: kBlack,
              fontFamily: kMedium,
            ),
            displaySmall: TextStyle(
              color: kBlack,
              fontFamily: kRegular,
            ),
            headlineLarge: TextStyle(
              color: kBlack,
              fontFamily: kLight,
            ),
            headlineMedium:
                TextStyle(color: kPrimaryLight, fontFamily: kMedium),
            bodyLarge: TextStyle(color: kPrimaryLight, fontFamily: kBold)),
      );
}

late String kBold;
late String kLight;
late String kMedium;
late String kRegular;

initFonts() {
  kBold = 'BoldAr';
  kLight = 'LightAr';
  kMedium = 'RegularAr';
  kRegular = 'SemiBoldAr';
}
