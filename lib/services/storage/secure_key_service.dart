part of '_storage.dart';

class SecureKeyService {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );
  static const _hiveEncryptionKeyName = 'inagrichat_hive_enc_key';

  static Future<List<int>> getOrCreateEncryptionKey() async {
    final existingKey = await _storage.read(key: _hiveEncryptionKeyName);
    if (existingKey != null) {
      return base64Decode(existingKey);
    }
    final key = Hive.generateSecureKey();
    await _storage.write(
      key: _hiveEncryptionKeyName,
      value: base64Encode(key),
    );
    return key;
  }
}
