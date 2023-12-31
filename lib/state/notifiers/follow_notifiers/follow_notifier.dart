import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../constants/database/database_column_name.dart';
import '../../../constants/database/database_table_name.dart';
import '../../../models/follow/follow_count.dart';
import '../../../services/supabase_service.dart';
import '../../../utils/exceptions/message_exception.dart';
import '../../../utils/storage/user_info.dart';

class FollowNotifier extends StateNotifier<FollowCount> {
  FollowNotifier() : super(const FollowCount.unknown());

  final supabase = SupabaseService();

  // Get current user followers and followings
  Future<FollowCount> me() async {
    final userId = await UserInfo.userId();

    String fields = """
      "${DatabaseColumnName.followerId}",
      "${DatabaseColumnName.followingId}"
    """;

    try {
      final follower = await supabase.countWhere(
        table: DatabaseTableName.follows,
        columns: fields,
        column: DatabaseColumnName.followingId,
        value: userId,
      );

      final following = await supabase.countWhere(
        table: DatabaseTableName.follows,
        columns: fields,
        column: DatabaseColumnName.followerId,
        value: userId,
      );

      final follow = FollowCount(
        follower: follower,
        following: following,
      );

      return follow;
    } on Exception {
      throw MessageException(
        'error.failed_to_get_current_user_followers_and_following_count',
      );
    }
  }

  /// Get user following and follower count by given ID
  Future<void> user(String userId) async {
    // Select fields
    String fields = """
      "${DatabaseColumnName.followerId}",
      "${DatabaseColumnName.followingId}"
    """;

    try {
      final followCounts = await Future.wait<int>([
        supabase.countWhere(
          table: DatabaseTableName.follows,
          columns: fields,
          column: DatabaseColumnName.followingId,
          value: userId,
        ),
        supabase.countWhere(
          table: DatabaseTableName.follows,
          columns: fields,
          column: DatabaseColumnName.followerId,
          value: userId,
        )
      ]);

      final follower = followCounts.first;

      final following = followCounts.last;

      final follow = FollowCount(
        follower: follower,
        following: following,
      );
      state = follow;
    } on Exception {
      throw MessageException(
        'error.failed_to_get_user_follower_and_following_count',
      );
    }
  }

  Future<void> follow(String followingId) async {
    final userId = await UserInfo.userId();

    /// Insert follower_id and following_id
    Map<String, dynamic> fields = {
      DatabaseColumnName.followerId: userId,
      DatabaseColumnName.followingId: followingId,
    };
    try {
      await supabase.insert(DatabaseTableName.follows, fields);

      // Update current user followings
      state = state.copyWith(following: state.following + 1);
    } on Exception {
      throw MessageException('error.failed_to_follow_user');
    }
  }

  Future<void> unfollow(String followingId) async {
    final userId = await UserInfo.userId();

    /// delete follower_id and following_id
    Map<String, dynamic> fields = {
      DatabaseColumnName.followerId: userId,
      DatabaseColumnName.followingId: followingId,
    };
    try {
      await supabase.delete(DatabaseTableName.follows, fields);

      // Update current user followings
      state = state.copyWith(following: state.following - 1);
    } on Exception {
      throw MessageException('error.failed_to_unfollow_user');
    }
  }

  Future<bool> isFollowed(String userId) async {
    final currentUserId = await UserInfo.userId();

    String fields = """
      "${DatabaseColumnName.followerId}",
      "${DatabaseColumnName.followingId}"
    """;

    Map<String, dynamic> where = {
      DatabaseColumnName.followerId: currentUserId,
      DatabaseColumnName.followingId: userId,
    };

    try {
      final res = await supabase.getWhere(
        DatabaseTableName.follows,
        fields,
        where,
      );

      return res != null;
    } on Exception {
      throw MessageException('error.failed_to_is_current_user_followed');
    }
  }
}
