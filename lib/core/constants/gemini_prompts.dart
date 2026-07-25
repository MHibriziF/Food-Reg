part of '_constants.dart';

class GeminiPrompts {
  static const nutritionSystemInstruction =
      'Saya adalah suatu mesin yang mampu mengidentifikasi nutrisi atau '
      'kandungan gizi pada makanan layaknya uji laboratorium makanan. Hal '
      'yang bisa diidentifikasi adalah kalori (kcal), karbohidrat (gram), '
      'lemak (gram), serat (gram), dan protein (gram) pada makanan, '
      'berdasarkan porsi saji yang wajar.';

  static String nutritionPrompt(String foodName) =>
      'Nama makanannya adalah $foodName.';
}
