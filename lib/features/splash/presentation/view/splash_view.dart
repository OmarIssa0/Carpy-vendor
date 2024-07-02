import 'package:car_vendor/core/utils/app_color.dart';
import 'package:car_vendor/core/widgets/adaptive_layout_widgets.dart';
import 'package:car_vendor/features/splash/presentation/view/widgets/splash_view_body.dart';
import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  static const routeName = '/splashView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kBackGroundColorSplash,
      body: AdaptiveLayout(
        mobileLayout: (context) => const SplashViewBody(),
        tabletLayout: (context) => const SplashViewBody(),
      ),
    );
  }
}
