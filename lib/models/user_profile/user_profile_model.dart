import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart' show immutable;

import '../../constants/database/database_column_name.dart';

@immutable
class UserProfileModel extends MapView<String, dynamic> {
  final int id;
  final String uid;
  final String name;
  final String? image;
  final DateTime createdAt;

  UserProfileModel({
    required this.id,
    required this.uid,
    required this.name,
    required this.image,
    required this.createdAt,
  }) : super(
          {
            DatabaseColumnName.id: id,
            DatabaseColumnName.userId: uid,
            DatabaseColumnName.name: name,
            DatabaseColumnName.image: image,
            DatabaseColumnName.createdAt: createdAt,
          },
        );

  UserProfileModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json[DatabaseColumnName.id],
          uid: json[DatabaseColumnName.userId],
          name: json[DatabaseColumnName.name] ?? '',
          image: json[DatabaseColumnName.image],
          createdAt: DateTime.parse(json[DatabaseColumnName.createdAt]),
        );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        DatabaseColumnName.id: id,
        DatabaseColumnName.userId: uid,
        DatabaseColumnName.name: name,
        DatabaseColumnName.image: image,
        DatabaseColumnName.createdAt: createdAt.toIso8601String(),
      };

  UserProfileModel copyWith({String? name, String? image}) => UserProfileModel(
        id: id,
        uid: uid,
        name: name ?? this.name,
        image: image ?? this.image,
        createdAt: createdAt,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProfileModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          uid == other.uid &&
          name == other.name &&
          image == other.image &&
          createdAt == other.createdAt;

  @override
  int get hashCode => Object.hashAll(
        [
          id,
          uid,
          name,
          image,
          createdAt,
        ],
      );

  @override
  String toString() {
    return toJson().toString();
  }
}
