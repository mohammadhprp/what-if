import 'package:isar/isar.dart';

part 'cache_model.g.dart';

@collection
class CacheModel {
  Id id = Isar.autoIncrement;
  String? key;
  String? value;
  DateTime? expiredAt;
}
