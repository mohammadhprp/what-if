import 'package:flutter/material.dart';

import '../../constants/extensions/widget/padding_extension.dart';
import '../../constants/values_manager/values_manager.dart';
import '../../widgets/user_profile/user_follower.dart';
import '../../widgets/user_profile/user_profile_info.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Column(
        children: [
          UserProfileInfo(),
          UserFollower(),
          // TODO: user post in here
        ],
      ).padding([Edge.all], AppPadding.p10),
    );
  }
}
