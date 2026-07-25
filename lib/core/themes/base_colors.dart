part of '_themes.dart';

class BaseColors {
  static const Color primary = Color(0xFF466130);
  static const Color primaryText = Color(0xFF466130);

  static const int _secondaryPrimaryValue = 0xFFFFD1D5DB;
  static const MaterialColor secondary =
      MaterialColor(_secondaryPrimaryValue, <int, Color>{
        50: Color(0xFFF9FAFB),
        100: Color(0xFFF3F4F6),
        200: Color(0xFFE5E7EB),
        300: Color(_secondaryPrimaryValue),
        400: Color(0xFF9CA3AF),
        500: Color(0xFF6B7280),
        600: Color(0xFF4B5563),
        700: Color(0xFF374151),
        800: Color(0xFF1F2937),
        900: Color(0xFF111827),
      });

  static const int _brandPrimaryValue = 0xFF1E326B;
  static const MaterialColor brand =
      MaterialColor(_brandPrimaryValue, <int, Color>{
        50: Color(0xFFE9EBF0),
        100: Color(0xFFB9BFD1),
        200: Color(0xFF98A1BB),
        300: Color(0xFF68769C),
        400: Color(0xFF4B5B89),
        500: Color(_brandPrimaryValue),
        600: Color(0xFF1B2E61),
        700: Color(0xFF15244C),
        800: Color(0xFF111C3B),
        900: Color(0xFF0D152D),
      });

  static const int _limePrimaryValue = 0xFF84CC16;
  static const MaterialColor lime =
      MaterialColor(_limePrimaryValue, <int, Color>{
        50: Color(0xFFF7FEE7),
        100: Color(0xFFECFCCB),
        200: Color(0xFFD9F99D),
        300: Color(0xFFBEF264),
        400: Color(0xFFA3E635),
        500: Color(_limePrimaryValue),
        600: Color(0xFF65A30D),
        700: Color(0xFF4D7C0F),
        800: Color(0xFF3F6212),
        900: Color(0xFF365314),
        950: Color(0xFF1A2E05),
      });

  static const int _redPrimaryValue = 0xFFC10007;
  static const MaterialColor red = MaterialColor(_redPrimaryValue, <int, Color>{
    50: Color(0xFFFEF2F2),
    100: Color(0xFFFEE2E2),
    200: Color(0xFFFECACA),
    300: Color(0xFFFCA5A5),
    400: Color(0xFFF87171),
    500: Color(_redPrimaryValue),
    600: Color(0xFFB91C1C),
    700: Color(0xFF991B1B),
    800: Color(0xFF7F1D1D),
    900: Color(0xFF450A0A),
    950: Color(0xFF450A0A),
  });

  static const int _amberPrimaryValue = 0xFFF59E0B;
  static const MaterialColor amber =
      MaterialColor(_amberPrimaryValue, <int, Color>{
        50: Color(0xFFFFFBEB),
        100: Color(0xFFFEF3C7),
        200: Color(0xFFFDE68A),
        300: Color(0xFFFCD34D),
        400: Color(0xFFFBBF24),
        500: Color(_amberPrimaryValue),
        600: Color(0xFFD97706),
        700: Color(0xFFB45309),
        800: Color(0xFF92400E),
        900: Color(0xFF78350F),
        950: Color(0xFF451A03),
      });

  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color blue = Colors.blue;
  static const Color transparent = Colors.transparent;

  static const Color success = Color(_limePrimaryValue);
  static const Color warning = Color(_amberPrimaryValue);
  static const Color error = Color(_redPrimaryValue);

  static const scaffoldColor = Colors.white;

  static const Color ristekPurple = Color(0xFF5038BC);
}
