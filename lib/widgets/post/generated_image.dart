import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../components/images/image_file_view.dart';
import '../../components/loading/loading_view.dart';
import '../../constants/enums/generate_status.dart';
import '../../constants/extensions/media_query/media_query_extension.dart';
import '../../constants/extensions/theme/theme_extension.dart';
import '../../constants/values_manager/values_manager.dart';
import '../../state/providers/post_providers/generate_image_provider.dart';

class GeneratedImage extends ConsumerWidget {
  const GeneratedImage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(generateImageProvider);
    final provider = ref.watch(generateImageProvider.notifier);

    return switch (state) {
      GenerateStatus.notStarted => const GeneratorImagePlaceHolder(
          child: Text('select image'),
        ),
      GenerateStatus.loading => const GeneratorImagePlaceHolder(
          child: LoadingView(),
        ),
      GenerateStatus.success => GeneratorImagePlaceHolder(
          child: ImageFileViewer(
            image: provider.generatedImage,
            shape: BoxShape.rectangle,
          ),
        ),
      GenerateStatus.error => const GeneratorImagePlaceHolder(
          child: Text('Error'),
        ),
    };
  }
}

class GeneratorImagePlaceHolder extends StatelessWidget {
  final Widget child;
  const GeneratorImagePlaceHolder({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: context.height * 0.4,
      width: context.width,
      decoration: BoxDecoration(
        color: context.theme.colorScheme.outlineVariant,
        borderRadius: BorderRadius.circular(AppSize.s16),
      ),
      child: child,
    );
  }
}
