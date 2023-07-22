import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../components/dividers/horizontal_divider.dart';
import '../../../../components/loading/loading_view.dart';
import '../../../../constants/extensions/media_query/media_query_extension.dart';
import '../../../../constants/extensions/widget/padding_extension.dart';
import '../../../../constants/values_manager/values_manager.dart';
import '../../../../helpers/localization/app_local.dart';
import '../../../../state/providers/post_providers/post_list_providers/post_list_provider.dart';
import 'post_item.dart';

class Posts extends HookConsumerWidget {
  const Posts({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fetchPost = ref.watch(fetchPostsProvider);
    return SizedBox(
      height: context.height * 0.6,
      child: fetchPost.when(
        data: (_) {
          final provider = ref.watch(postListProvider);
          final posts = provider.list;
          final length = posts.length;

          if (posts.isEmpty) {
            return Center(
              child: Text(AppLocal.tr(context, 'app.empty_list')),
            );
          }

          return ListView.separated(
            itemCount: length,
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            separatorBuilder: (BuildContext context, int index) {
              return const HorizontalDivider()
                  .padding([Edge.all], AppPadding.p10);
            },
            itemBuilder: (BuildContext context, int index) {
              final post = posts[index];
              return Column(
                children: [
                  PostItem(post: post),
                  if (index == length)
                    SizedBox(
                      height: context.height * 0.1,
                    )
                ],
              );
            },
          );
        },
        error: (e, _) => const Text('error'),
        loading: () => const LoadingView(),
      ),
    ).padding([Edge.horizontal], AppPadding.p10);
  }
}
