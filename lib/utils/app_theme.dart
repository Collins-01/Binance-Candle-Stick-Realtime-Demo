import 'package:binance_demo/utils/utils.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      fontFamily: 'Satoshi',
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryColor: AppColors.black,
      scaffoldBackgroundColor: const Color(0xffF8F8F9),
      iconTheme: IconThemeData(
        color: AppColors.black,
      ),
      cardColor: AppColors.white,
      shadowColor: const Color(0xffF1F1F1),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.white,
        elevation: 0,
      ),
      tabBarTheme: TabBarTheme(
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.white,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        unselectedLabelColor: AppColors.blackTint2,
        // labelColor: rockBlack,
      ),
      textTheme: const TextTheme().apply(
        bodyColor: AppColors.black,
        displayColor: AppColors.black,
      ),
      bottomSheetTheme:
          BottomSheetThemeData(backgroundColor: Colors.black.withOpacity(0)),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      fontFamily: 'Satoshi',
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryColor: AppColors.white,
      brightness: Brightness.dark,
      iconTheme: IconThemeData(
        color: AppColors.white,
      ),
      cardColor: AppColors.black,
      // shadowColor: cardStroke,
      // scaffoldBackgroundColor: rockBlack,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.black,
        elevation: 0,
      ),
      tabBarTheme: TabBarTheme(
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          // color: rockBlack,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        unselectedLabelColor: AppColors.white,
        labelColor: AppColors.white,
      ),
      textTheme: const TextTheme().apply(
        fontFamily: 'Satoshi',
        bodyColor: AppColors.white,
        displayColor: AppColors.white,
      ),
      bottomSheetTheme:
          BottomSheetThemeData(backgroundColor: Colors.black.withOpacity(0)),
    );
  }
}
