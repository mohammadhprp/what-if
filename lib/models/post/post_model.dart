import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart' show immutable;

import '../../constants/database/database_column_name.dart';
import '../user_profile/user_profile_model.dart';

@immutable
class PostModel extends MapView<String, dynamic> {
  final int id;
  final UserProfileModel user;
  final String prompt;
  final String caption;
  final String image;
  final int likeCount;
  final int commentCount;
  final DateTime createdAt;

  PostModel({
    required this.id,
    required this.user,
    required this.caption,
    required this.prompt,
    required this.image,
    required this.likeCount,
    required this.commentCount,
    required this.createdAt,
  }) : super(
          {
            DatabaseColumnName.id: id,
            DatabaseColumnName.user: user,
            DatabaseColumnName.caption: caption,
            DatabaseColumnName.prompt: prompt,
            DatabaseColumnName.image: image,
            DatabaseColumnName.likeCount: likeCount,
            DatabaseColumnName.commentCount: commentCount,
            DatabaseColumnName.createdAt: createdAt,
          },
        );

  PostModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json[DatabaseColumnName.id],
          user: UserProfileModel.fromJson(json[DatabaseColumnName.user]),
          caption: json[DatabaseColumnName.caption],
          prompt: json[DatabaseColumnName.prompt],
          image: json[DatabaseColumnName.image],
          likeCount: json[DatabaseColumnName.likeCount],
          commentCount: json[DatabaseColumnName.commentCount],
          createdAt: DateTime.parse(json[DatabaseColumnName.createdAt]),
        );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        DatabaseColumnName.id: id,
        DatabaseColumnName.user: user.toJson(),
        DatabaseColumnName.prompt: prompt,
        DatabaseColumnName.caption: caption,
        DatabaseColumnName.image: image,
        DatabaseColumnName.likeCount: likeCount,
        DatabaseColumnName.commentCount: commentCount,
        DatabaseColumnName.createdAt: createdAt.toIso8601String(),
      };

  PostModel copyWith({String? caption, String? image}) => PostModel(
        id: id,
        user: user,
        prompt: prompt,
        caption: caption ?? this.caption,
        image: image ?? this.image,
        likeCount: likeCount,
        commentCount: commentCount,
        createdAt: createdAt,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          user == other.user &&
          prompt == other.prompt &&
          caption == other.caption &&
          image == other.image &&
          likeCount == other.likeCount &&
          commentCount == other.commentCount &&
          createdAt == other.createdAt;

  @override
  int get hashCode => Object.hashAll(
        [
          id,
          user,
          prompt,
          caption,
          image,
          likeCount,
          commentCount,
          createdAt,
        ],
      );

  @override
  String toString() {
    return toJson().toString();
  }
}
