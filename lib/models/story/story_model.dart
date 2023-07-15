import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart' show immutable;

import '../../constants/database/database_column_name.dart';
import '../user_profile/user_profile_model.dart';

@immutable
class StoryModel extends MapView<String, dynamic> {
  final int id;
  final UserProfileModel user;
  final String image;
  final DateTime createdAt;

  StoryModel({
    required this.id,
    required this.user,
    required this.image,
    required this.createdAt,
  }) : super(
          {
            DatabaseColumnName.id: id,
            DatabaseColumnName.user: user,
            DatabaseColumnName.image: image,
            DatabaseColumnName.createdAt: createdAt,
          },
        );

  StoryModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json[DatabaseColumnName.id],
          user: UserProfileModel.fromJson(json[DatabaseColumnName.user]),
          image: json[DatabaseColumnName.image],
          createdAt: DateTime.parse(json[DatabaseColumnName.createdAt]),
        );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        DatabaseColumnName.id: id,
        DatabaseColumnName.user: user.toJson(),
        DatabaseColumnName.image: image,
        DatabaseColumnName.createdAt: createdAt.toIso8601String(),
      };

  StoryModel copyWith({String? caption, String? image}) => StoryModel(
        id: id,
        user: user,
        image: image ?? this.image,
        createdAt: createdAt,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoryModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          user == other.user &&
          image == other.image &&
          createdAt == other.createdAt;

  @override
  int get hashCode => Object.hashAll(
        [
          id,
          user,
          image,
          createdAt,
        ],
      );

  @override
  String toString() {
    return toJson().toString();
  }
}
