import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../components/icon/icon_view.dart';
import '../../constants/app/app_icons.dart';
import '../../constants/extensions/media_query/media_query_extension.dart';
import '../../constants/extensions/theme/theme_extension.dart';
import '../../constants/values_manager/values_manager.dart';
import '../../helpers/localization/app_local.dart';
import '../home/home_screen.dart';
import '../post/generate_image_screen.dart';
import '../user_profile/user_profile_screen.dart';

class MainScreen extends HookWidget {
  static const routeName = '/main';
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final index = useState(0);

    final tabs = [
      const HomeScreen(),
      const GenerateImageScreen(),
      const UserProfileScreen(),
    ];

    final unselectedIcon = context.theme.colorScheme.onBackground;
    final selectedIcon = context.theme.colorScheme.primary;

    return Scaffold(
      body: tabs[index.value],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(AppSize.s18),
        child: Container(
          height: context.height * 0.1,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.outlineVariant,
            borderRadius: BorderRadius.circular(AppSize.s20),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppSize.s20),
            child: BottomNavigationBar(
              elevation: 0,
              currentIndex: index.value,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.transparent,
              fixedColor: Colors.transparent,
              onTap: (value) {
                index.value = value;
              },
              items: [
                BottomNavigationBarItem(
                  icon: IconView(
                    icon: AppIcons.house,
                    color: unselectedIcon,
                  ),
                  activeIcon: IconView(
                    icon: AppIcons.house,
                    color: selectedIcon,
                  ),
                  label: AppLocal.tr(context, 'timeline'),
                ),
                BottomNavigationBarItem(
                  icon: IconView(
                    icon: AppIcons.addSquare,
                    color: unselectedIcon,
                    height: AppSize.s30,
                  ),
                  activeIcon: IconView(
                    icon: AppIcons.addSquare,
                    color: selectedIcon,
                    height: AppSize.s30,
                  ),
                  label: AppLocal.tr(context, 'add_post'),
                ),
                BottomNavigationBarItem(
                  icon: IconView(
                    icon: AppIcons.user,
                    color: unselectedIcon,
                  ),
                  activeIcon: IconView(
                    icon: AppIcons.user,
                    color: selectedIcon,
                  ),
                  label: AppLocal.tr(context, 'profile'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
