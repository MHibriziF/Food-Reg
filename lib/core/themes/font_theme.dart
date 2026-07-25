part of '_themes.dart';

class FontTheme {
  static const _height = 1.5;
  static const _color = BaseColors.black;
  static const fontFamily = "Plus Jakarta Sans";

  static TextStyle _textStyleHelper({
    String? family,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? height,
  }) {
    return GoogleFonts.getFont(
      family ?? fontFamily,
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height,
    );
  }

  static final mainHeader = _textStyleHelper(
    color: _color,
    fontSize: 30,
    fontWeight: FontWeight.w800,
    height: _height,
  );

  static final sectionHeader = _textStyleHelper(
    color: _color,
    fontSize: 24,
    fontWeight: FontWeight.w800,
    height: _height,
  );

  static final subHeader = _textStyleHelper(
    color: BaseColors.primary,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    height: _height,
  );

  static final bodyBold = _textStyleHelper(
    color: _color,
    fontSize: 16,
    fontWeight: FontWeight.w700,
    height: _height,
  );

  static final bodySemiBold = _textStyleHelper(
    color: _color,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: _height,
  );

  static final bodyMedium = _textStyleHelper(
    color: _color,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: _height,
  );

  static final bodyRegular = _textStyleHelper(
    color: _color,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: _height,
  );

  static final textBold = _textStyleHelper(
    color: _color,
    fontSize: 14,
    fontWeight: FontWeight.w700,
    height: _height,
  );

  static final textSemiBold = _textStyleHelper(
    color: _color,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: _height,
  );

  static final textMedium = _textStyleHelper(
    color: _color,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: _height,
  );

  static final textRegular = _textStyleHelper(
    color: _color,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: _height,
  );

  static final captionBold = _textStyleHelper(
    color: _color,
    fontSize: 12,
    fontWeight: FontWeight.w700,
    height: _height,
  );

  static final captionSemiBold = _textStyleHelper(
    color: _color,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    height: _height,
  );

  static final captionMedium = _textStyleHelper(
    color: _color,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: _height,
  );

  static final captionRegular = _textStyleHelper(
    color: _color,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: _height,
  );
}
