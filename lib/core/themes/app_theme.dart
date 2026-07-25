part of '_themes.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: BaseColors.primary,
        surface: BaseColors.white,
      ),
      fontFamily: FontTheme.fontFamily,
      scaffoldBackgroundColor: BaseColors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: BaseColors.white,
        surfaceTintColor: BaseColors.transparent,
        elevation: 2,
        shadowColor: BaseColors.black.withValues(alpha: 0.5),
      ),
      textTheme: TextTheme(
        displayLarge: FontTheme.mainHeader,
        headlineLarge: FontTheme.sectionHeader,
        headlineMedium: FontTheme.subHeader,
        bodyLarge: FontTheme.bodyBold,
        bodyMedium: FontTheme.bodyMedium,
        labelLarge: FontTheme.textBold,
      ),
    );
  }
}
