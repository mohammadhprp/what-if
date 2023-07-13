import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../constants/values_manager/font_manager.dart';
import '../../constants/values_manager/values_manager.dart';

class UserFollower extends HookConsumerWidget {
  const UserFollower({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
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
        Column(
          children: [
            Text(
              '100',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            const SizedBox(height: AppSize.s10),
            Text(
              'Followers',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeightManager.regular,
                    color: Theme.of(context).colorScheme.outline,
                  ),
            ),
          ],
        ),
        Column(
          children: [
            Text(
              '20k',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            const SizedBox(height: AppSize.s10),
            Text(
              'Following',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeightManager.regular,
                    color: Theme.of(context).colorScheme.outline,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
