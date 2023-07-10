import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../components/app_logo/app_logo.dart';
import '../../components/app_version/app_version_view.dart';
import '../../constants/extensions/media_query/media_query_extension.dart';
import '../../constants/extensions/widget/padding_extension.dart';
import '../../constants/values_manager/values_manager.dart';
import '../../state/providers/auth_providers/is_logged_in_provider.dart';
import '../auth/auth_screen.dart';
import '../home/home_screen.dart';

class SplashScreen extends HookConsumerWidget {
  static const routeName = '/splash';
  const SplashScreen({super.key});

  Future _authCheck(BuildContext context, WidgetRef ref) async {
    final isAuth = ref.watch(isLoggedInProvider);
    if (!isAuth) {
      _push(const AuthScreen(), context);
    } else {
      _push(const HomeScreen(), context);
    }
  }

  void _push(Widget screen, BuildContext context) {
    Future.delayed(
      const Duration(seconds: DurationConstant.d2),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAnimationComplete = useState(false);

    final AnimationController animationController = useAnimationController(
      duration: const Duration(
        seconds: DurationConstant.d1,
        milliseconds: DurationConstant.d500,
      ),
    );

    useEffect(() {
      animationController.forward();

      void listener() {
        isAnimationComplete.value =
            animationController.isAnimating || animationController.isCompleted;
      }

      Future.delayed(Duration.zero, () {
        _authCheck(context, ref);
      });

      animationController.addListener(listener);
      return () {
        animationController.removeListener(listener);
      };
    }, [isAnimationComplete, animationController]);

    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
            animation: animationController,
            builder: (context, child) {
              return AnimatedOpacity(
                curve: Curves.easeIn,
                duration: const Duration(seconds: DurationConstant.d1),
                opacity: isAnimationComplete.value ? 1 : 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(),
                    AppLogo(height: context.height * 0.4),
                    const AppVersionView()
                        .padding([Edge.bottom], AppPadding.p10),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
