part of '_storage.dart';

/// Central registry of Hive box names.
/// Add a constant here for every box the app uses, then open it with
/// [HiveService.openBox]. Mark boxes with sensitive data as [encrypted: true].
abstract final class BoxNames {
  static const auth = 'inagrichat_auth'; // encrypted — tokens, user identity
  static const cache = 'inagrichat_cache'; // plain — API responses, app state
}
