import 'package:envied/envied.dart';
part 'config.g.dart';

@Envied(name: 'Config', path: '.env')
abstract class Config {
  @EnviedField(varName: 'MEALDB_BASE_URL')
  static const String mealDbBaseUrl = _Config.mealDbBaseUrl;

  @EnviedField(varName: 'GEMINI_API_KEY', obfuscate: true)
  static final String geminiApiKey = _Config.geminiApiKey;
}
