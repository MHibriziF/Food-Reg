part of '_themes.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: BaseColors.primary,
        surface: BaseColors.white,
      ),
      fontFamily: FontTheme.fontFamily,
      scaffoldBackgroundColor: BaseColors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: BaseColors.white,
        foregroundColor: BaseColors.black,
        surfaceTintColor: BaseColors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: FontTheme.sectionHeader,
      ),
      textTheme: TextTheme(
        displayLarge: FontTheme.mainHeader,
        headlineLarge: FontTheme.sectionHeader,
        headlineMedium: FontTheme.subHeader,
        bodyLarge: FontTheme.bodyBold,
        bodyMedium: FontTheme.bodyMedium,
        labelLarge: FontTheme.textBold,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          textStyle: FontTheme.bodyBold,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(double.infinity, 52),
          foregroundColor: BaseColors.primary,
          side: BorderSide(color: BaseColors.primary.withValues(alpha: 0.4)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          textStyle: FontTheme.bodyBold,
        ),
      ),
    );
  }
}
