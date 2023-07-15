import 'package:flutter/material.dart';

import '../../constants/extensions/theme/theme_extension.dart';
import '../../constants/values_manager/values_manager.dart';
import '../../helpers/localization/app_local.dart';
import '../../widgets/home/stories/stories.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.theme.colorScheme.outlineVariant,
        title: Text(
          AppLocal.tr(context, 'app.what_if'),
          style: context.textTheme.displayLarge,
        ),
        toolbarHeight: AppSize.s80,
      ),
      body: ListView(
        children: const [
          Stories(),
        ],
      ),
    );
  }
}
