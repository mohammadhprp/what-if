import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../components/loading/loading_view.dart';
import '../../constants/values_manager/font_manager.dart';
import '../../constants/values_manager/values_manager.dart';
import '../../state/providers/follow_providers/follow_provider.dart';

class UserFollower extends HookConsumerWidget {
  const UserFollower({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Text(
                '10',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              const SizedBox(height: AppSize.s10),
              Text(
                'Posts',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeightManager.regular,
                      color: Theme.of(context).colorScheme.outline,
                    ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Consumer(
            builder: (context, ref, child) {
              final myFollow = ref.watch(myFollowProvider);
              return myFollow.when(
                data: (follow) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            '${follow.follower}',
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                ),
                          ),
                          const SizedBox(height: AppSize.s10),
                          Text(
                            'Followers',
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(
                                  fontWeight: FontWeightManager.regular,
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            '${follow.following}',
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                ),
                          ),
                          const SizedBox(height: AppSize.s10),
                          Text(
                            'Following',
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(
                                  fontWeight: FontWeightManager.regular,
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
                error: (error, __) {
                  return const Text('error');
                },
                loading: () => const LoadingView(),
              );
            },
          ),
        )
      ],
    );
  }
}
