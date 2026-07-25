part of '_storage.dart';

class HiveService {
  static final Map<String, Box<dynamic>> _boxes = {};
  static late List<int> _encryptionKey;

  /// Max number of entries kept in [BoxNames.cache]. Oldest-inserted entries
  /// are evicted first once this is exceeded, so the box can't grow unbounded.
  static const int _maxCacheEntries = 200;

  static Future<void> init() async {
    LoggerService.i('Initializing Hive Storage');
    await Hive.initFlutter();
    _encryptionKey = await SecureKeyService.getOrCreateEncryptionKey();
    await openBox(BoxNames.auth, encrypted: true);
    await openBox(BoxNames.cache);
  }

  /// Open (or return an already-open) named Hive box.
  ///
  /// Set [encrypted: true] for any box that will hold sensitive data —
  /// the same Keystore-backed key is reused, so there is no extra secret to manage.
  ///
  /// Call this in [main] (or a feature's datasource init) before using the box.
  /// Calling it again for an already-open box is a no-op.
  ///
  /// ```dart
  /// // In main.dart, after HiveService.init():
  /// await HiveService.openBox(BoxNames.medicalData, encrypted: true);
  ///
  /// // In BoxNames:
  /// static const medicalData = 'inagrichat_medical_data';
  /// ```
  static Future<Box<dynamic>> openBox(
    String name, {
    bool encrypted = false,
  }) async {
    if (_boxes.containsKey(name)) return _boxes[name]!;
    final box = await Hive.openBox<dynamic>(
      name,
      encryptionCipher: encrypted ? HiveAesCipher(_encryptionKey) : null,
    );
    _boxes[name] = box;
    return box;
  }

  static Box<dynamic> _box(String name) {
    assert(
      _boxes.containsKey(name),
      'Box "$name" is not open. '
      'Call await HiveService.openBox("$name") before using it.',
    );
    return _boxes[name]!;
  }

  /// Write [value] into [box] and evict old entries if [box] is over capacity.
  /// All writes must go through this so eviction can't be missed by a future
  /// write path that forgets to call [_evictIfNeeded] itself.
  static Future<void> _put(String box, String key, dynamic value) async {
    await _box(box).put(key, value);
    await _evictIfNeeded(box);
  }

  // ── Primitives ───────────────────────────────────────────────────────────
  // Default box is [BoxNames.auth] (encrypted). Pass [box:] to target any other box.

  static Future<void> saveString(
    String key,
    String value, {
    String box = BoxNames.auth,
  }) => _put(box, key, value);

  static String? getString(String key, {String box = BoxNames.auth}) =>
      _box(box).get(key) as String?;

  static Future<void> saveInt(
    String key,
    int value, {
    String box = BoxNames.auth,
  }) => _put(box, key, value);

  static int? getInt(String key, {String box = BoxNames.auth}) =>
      _box(box).get(key) as int?;

  static Future<void> saveBool(
    String key, {
    required bool value,
    String box = BoxNames.auth,
  }) => _put(box, key, value);

  static bool? getBool(String key, {String box = BoxNames.auth}) =>
      _box(box).get(key) as bool?;

  static Future<void> remove(String key, {String box = BoxNames.auth}) async =>
      _box(box).delete(key);

  // ── Single model (JSON-serializable / Freezed) ───────────────────────────
  // Default box is [BoxNames.cache]. Pass [box:] to store in an encrypted box.

  /// Store any model that has a [toJson] method.
  ///
  /// Pass [ttl] to automatically expire the entry after a duration. The
  /// expiry is stored alongside the data, so [getCachedModel] needs no [ttl]
  /// argument and can't be called with a mismatched one.
  ///
  /// ```dart
  /// await HiveService.cacheModel('profile', profile, toJson: (p) => p.toJson());
  /// await HiveService.cacheModel('profile', profile, toJson: (p) => p.toJson(), ttl: Duration(minutes: 15));
  /// ```
  static Future<void> cacheModel<T>(
    String key,
    T model, {
    required Map<String, dynamic> Function(T) toJson,
    String box = BoxNames.cache,
    Duration? ttl,
  }) async {
    final data = toJson(model);
    final value = ttl != null
        ? {
            'data': data,
            'expiresAt': DateTime.now().add(ttl).millisecondsSinceEpoch,
          }
        : data;
    await _put(box, key, value);
  }

  /// Retrieve a cached model. Returns null if the key is missing or the entry
  /// has expired (an expired entry is also deleted from disk).
  ///
  /// ```dart
  /// final profile = HiveService.getCachedModel('profile', fromJson: ProfileModel.fromJson);
  /// ```
  static T? getCachedModel<T>(
    String key, {
    required T Function(Map<String, dynamic>) fromJson,
    String box = BoxNames.cache,
  }) {
    final raw = _box(box).get(key);
    if (raw == null) return null;
    final map = Map<String, dynamic>.from(raw as Map);
    if (!map.containsKey('expiresAt')) return fromJson(map);
    if (_isExpired(map)) {
      _box(box).delete(key);
      return null;
    }
    return fromJson(Map<String, dynamic>.from(map['data'] as Map));
  }

  // ── List of models ───────────────────────────────────────────────────────

  /// Store a list of models that have a [toJson] method.
  ///
  /// Pass [ttl] to automatically expire the entry after a duration.
  ///
  /// ```dart
  /// await HiveService.cacheModelList('crops', crops, toJson: (c) => c.toJson());
  /// await HiveService.cacheModelList('crops', crops, toJson: (c) => c.toJson(), ttl: Duration(minutes: 15));
  /// ```
  static Future<void> cacheModelList<T>(
    String key,
    List<T> models, {
    required Map<String, dynamic> Function(T) toJson,
    String box = BoxNames.cache,
    Duration? ttl,
  }) async {
    final data = models.map(toJson).toList();
    final value = ttl != null
        ? {
            'data': data,
            'expiresAt': DateTime.now().add(ttl).millisecondsSinceEpoch,
          }
        : data;
    await _put(box, key, value);
  }

  /// Retrieve a cached list of models. Returns null if the key is missing or
  /// the entry has expired (an expired entry is also deleted from disk).
  ///
  /// ```dart
  /// final crops = HiveService.getCachedModelList('crops', fromJson: CropModel.fromJson);
  /// ```
  static List<T>? getCachedModelList<T>(
    String key, {
    required T Function(Map<String, dynamic>) fromJson,
    String box = BoxNames.cache,
  }) {
    final raw = _box(box).get(key);
    if (raw == null) return null;
    if (raw is Map) {
      final wrapper = Map<String, dynamic>.from(raw);
      if (_isExpired(wrapper)) {
        _box(box).delete(key);
        return null;
      }
      return (wrapper['data'] as List)
          .cast<Map>()
          .map((e) => fromJson(Map<String, dynamic>.from(e)))
          .toList();
    }
    return (raw as List)
        .cast<Map>()
        .map((e) => fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  static bool _isExpired(Map<String, dynamic> wrapper) =>
      DateTime.now().isAfter(
        DateTime.fromMillisecondsSinceEpoch(wrapper['expiresAt'] as int),
      );

  /// Evict the oldest-inserted entries from [box] once it exceeds
  /// [_maxCacheEntries], so the cache can't grow unbounded. Only applies to
  /// [BoxNames.cache] — [BoxNames.auth] holds a small, explicit set of keys.
  static Future<void> _evictIfNeeded(String box) async {
    if (box != BoxNames.cache) return;
    final b = _box(box);
    final overflow = b.length - _maxCacheEntries;
    if (overflow <= 0) return;
    await b.deleteAll(b.keys.take(overflow));
  }

  // ── Lifecycle ────────────────────────────────────────────────────────────
  // Boxes opened at init() stay open for the app's lifetime — no need to close them.
  // Use these only for logout or session reset.

  /// Clear all data from a box without closing it.
  /// Prefer this for logout over [deleteBox] unless you need to reclaim disk space.
  static Future<void> clearBox(String boxName) async => _box(boxName).clear();

  /// Close and permanently delete a box from disk.
  /// The box must be re-opened with [openBox] before it can be used again.
  /// Use for logout when you want a clean slate.
  static Future<void> deleteBox(String boxName) async {
    await _box(boxName).close();
    await Hive.deleteBoxFromDisk(boxName);
    _boxes.remove(boxName);
  }

  // ── HTTP helper ──────────────────────────────────────────────────────────

  static Map<String, String> getHeaders() {
    final token = getString(StorageKeys.token);
    return <String, String>{
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }
}
