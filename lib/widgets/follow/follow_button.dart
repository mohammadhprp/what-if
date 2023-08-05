import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../components/buttons/outlined_button.dart';
import '../../components/loading/loading_view.dart';
import '../../state/providers/follow_providers/follow_provider.dart';
import '../../utils/storage/user_info.dart';

class FollowButton extends StatelessWidget {
  final String uid;
  const FollowButton({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: UserInfo.userId(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        }
        final currentUid = snapshot.requireData;
        if (currentUid == uid) {
          return Container();
        }

        return Consumer(
          builder: (context, ref, child) {
            final String userId = uid;
            final isFollowedProvider = ref.watch(
              isUserFollowedProvider(userId),
            );
            return isFollowedProvider.when(
              data: (isFollowed) {
                return AppOutlinedButton(
                  width: 120,
                  height: 50,
                  onPressed: () {
                    final provider = ref.read(followProvider.notifier);
                    isFollowed
                        ? provider.unfollow(userId)
                        : provider.follow(userId);
                  },
                  child: Text(
                    isFollowed ? 'app.unfollow' : 'app.follow',
                  ),
                );
              },
              error: (error, __) {
                return const Text('error');
              },
              loading: () => const LoadingView(),
            );
          },
        );
      },
    );
  }
}
