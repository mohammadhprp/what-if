import 'package:flutter/material.dart';

import '../../../../components/icon/icon_view.dart';
import '../../../../components/images/image_network_view.dart';
import '../../../../constants/app/app_icons.dart';
import '../../../../constants/extensions/date_time/date_time.dart';
import '../../../../constants/extensions/media_query/media_query_extension.dart';
import '../../../../constants/extensions/string/truncate.dart';
import '../../../../constants/extensions/theme/theme_extension.dart';
import '../../../../constants/extensions/widget/padding_extension.dart';
import '../../../../constants/values_manager/font_manager.dart';
import '../../../../constants/values_manager/values_manager.dart';
import '../../../../models/post/post_model.dart';

class PostItem extends StatelessWidget {
  final PostModel post;
  const PostItem({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * 0.4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ImageNetworkView(
                    width: AppSize.s40,
                    height: AppSize.s40,
                    image: post.userProfile.image ?? '',
                    border: Border.all(
                      width: AppSize.s2,
                      color: context.theme.colorScheme.primary,
                    ),
                    radius: AppSize.s20,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: AppSize.s30),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.userProfile.name,
                        style: context.textTheme.displayMedium,
                      ),
                      Text(
                        post.createdAt.format(),
                        style: context.textTheme.titleSmall?.copyWith(
                          color: context.theme.colorScheme.outline,
                          fontSize: FontSize.s13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: AppSize.s8),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  post.caption.truncate(),
                  style: context.textTheme.titleMedium,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSize.s12),
          ImageNetworkView(
            height: context.height * 0.23,
            width: context.width,
            image: post.image,
            fit: BoxFit.fitWidth,
            radius: AppSize.s12,
          ),
          const SizedBox(height: AppSize.s12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                ),
                onPressed: () {
                  // TODO: like the post
                },
                icon: IconView(
                  icon: AppIcons.heart,
                  color: context.colors.onBackground,
                ),
                label: Text("${post.likeCount}"),
              ),
              const SizedBox(width: AppSize.s8),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                ),
                onPressed: () {
                  // TODO: Got to comment page
                },
                icon: IconView(
                  icon: AppIcons.comment,
                  color: context.colors.onBackground,
                ),
                label: Text("${post.commentCount}"),
              ),
            ],
          )
        ],
      ).padding([Edge.horizontal], AppPadding.p18),
    );
  }
}
