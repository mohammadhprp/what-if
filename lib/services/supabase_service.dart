import 'dart:io';
import 'dart:typed_data';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../constants/database/database_column_name.dart';
import '../helpers/storage/cache_manager.dart';

class SupabaseService {
  final supabase = Supabase.instance.client;

  /// Fetch list of data
  Future<List> fetch(String table, String columns) async {
    try {
      final List data = await supabase
          .from(table)
          .select(columns)
          .order(DatabaseColumnName.createdAt);

      return data;
    } on Exception catch (e) {
      throw Exception('failed to fetch data from supabase => Error [$e]');
    }
  }

  // Fetch single data
  Future<Map<String, dynamic>> get(String table, String columns) async {
    try {
      final Map<String, dynamic> data =
          await supabase.from(table).select(columns).single();

      return data;
    } on Exception catch (e) {
      throw Exception('failed to get data from supabase => Error [$e]');
    }
  }

  Future<Map<String, dynamic>?> getWhere(
    String table,
    String columns,
    Map match,
  ) async {
    try {
      final Map<String, dynamic>? data =
          await supabase.from(table).select(columns).match(match).maybeSingle();

      return data;
    } on Exception catch (e) {
      throw Exception('failed to get data from supabase => Error [$e]');
    }
  }

  /// Insert data
  Future<Map<String, dynamic>> insert(
      String table, Map<String, dynamic> columns) async {
    try {
      final response =
          await supabase.from(table).insert(columns).select().single();

      return response;
    } on Exception catch (e) {
      throw Exception('failed to insert data into supabase => Error [$e]');
    }
  }

  /// Update data
  Future<void> update(
    String table,
    Map<String, dynamic> columns,
    Map<String, dynamic> where,
  ) async {
    try {
      await supabase.from(table).update(columns).match(where);
    } on Exception catch (e) {
      throw Exception('failed to update data from supabase => Error [$e]');
    }
  }

  /// Delete data
  Future<void> delete(
    String table,
    Map<String, dynamic> where,
  ) async {
    try {
      await supabase.from(table).delete().match(where);
    } on Exception catch (e) {
      throw Exception('failed to delete data from supabase => Error [$e]');
    }
  }

  /// Upload a file
  Future<String> upload(
    String bucket,
    String path,
    File file,
  ) async {
    try {
      final uploadPath = await supabase.storage.from(bucket).upload(
            path,
            file,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
          );

      return uploadPath;
    } on Exception catch (e) {
      throw Exception('failed to upload file to supabase => Error [$e]');
    }
  }

  /// Download a file
  Future<Uint8List> download(
    String bucket,
    String file,
  ) async {
    try {
      final Uint8List downloadedFile =
          await supabase.storage.from(bucket).download(file);

      return downloadedFile;
    } on Exception catch (e) {
      throw Exception('failed to download file from supabase => Error [$e]');
    }
  }

  /// Create a signed URL
  Future<String> publicUrl(String bucket, String file) async {
    try {
      const CacheManager cacheManager = CacheManager();
      final key = "$bucket.$file";
      const expiredAt = Duration(hours: 1);
      if (await cacheManager.isExist(key: key)) {
        return await cacheManager.get(key: key) ?? '';
      }

      final String signedUrl = await supabase.storage
          .from(bucket)
          .createSignedUrl(file, expiredAt.inMinutes);

      await cacheManager.store(
        key: key,
        value: signedUrl,
        expiredAt: expiredAt,
      );

      return signedUrl;
    } on Exception catch (e) {
      throw Exception(
        'failed to create and get public url from supabase => Error [$e]',
      );
    }
  }
}
