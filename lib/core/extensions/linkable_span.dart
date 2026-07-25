part of '_extensions.dart';

extension LinkableSpan on String {
  TextSpan toLinkSpan({
    VoidCallback? onTap,
    TextStyle style = const TextStyle(decoration: TextDecoration.underline),
  }) {
    return TextSpan(
      text: this,
      style: style,
      recognizer: TapGestureRecognizer()..onTap = onTap,
    );
  }
}
