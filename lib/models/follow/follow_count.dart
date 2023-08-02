class FollowCount {
  final int follower;
  final int following;

  const FollowCount({required this.follower, required this.following});

  const FollowCount.unknown()
      : follower = 0,
        following = 0;

  FollowCount copyWith({int? follower, int? following}) {
    return FollowCount(
      follower: follower ?? this.follower,
      following: following ?? this.following,
    );
  }
}
