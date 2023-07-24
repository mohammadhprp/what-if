import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../constants/database/database_collection_name.dart';
import '../../models/cache/cache_model.dart';

@immutable
class CacheManager {
  const CacheManager();

  Future<Isar> _init() async {
    final dir = await getApplicationDocumentsDirectory();

    var isar = Isar.getInstance(DatabaseCollectionName.cacheManager);

    // Open new instance of not opened
    isar ??= await Isar.open(
      [CacheModelSchema],
      name: DatabaseCollectionName.cacheManager,
      directory: dir.path,
    );

    return isar;
  }

  /// Store the [key] with the given [value].
  Future<void> store({
    required String key,
    required String value,
    required Duration expiredAt,
  }) async {
    if (await isExist(key: key)) {
      return;
    }

    final expire = DateTime.now().add(expiredAt);

    final isar = await _init();

    final cache = CacheModel()
      ..key = key
      ..value = value
      ..expiredAt = expire;

    await isar.writeTxn(() async {
      await isar.cacheModels.put(cache);
    });
  }

  /// Get the value for the given [key].
  Future<String?> get({required String key}) async {
    final isar = await _init();

    final query = await isar.cacheModels.filter().keyEqualTo(key).findFirst();

    return query?.value;
  }

  /// Delete the [value] with the given [key].
  Future<void> delete({required String key}) async {
    final isar = await _init();

    final query = await isar.cacheModels.filter().keyEqualTo(key).findFirst();

    if (query == null) {
      return;
    }

    await isar.writeTxn(() async {
      await isar.cacheModels.delete(query.id);
    });
  }

  // Check the value exist by the given [key]
  Future<bool> isExist({required String key}) async {
    final isar = await _init();

    final query = await isar.cacheModels
        .filter()
        .keyEqualTo(key)
        .expiredAtGreaterThan(DateTime.now())
        .findFirst();

    return query != null;
  }
}
