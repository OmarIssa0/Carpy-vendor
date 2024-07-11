import 'package:car_vendor/core/widgets/adaptive_layout_widgets.dart';
import 'package:car_vendor/features/home/presentation/view/widgets/home_view_body.dart';
import 'package:car_vendor/features/lang/app_localization.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Requests received'.tr(context)),
        automaticallyImplyLeading: false,
      ),
      body: AdaptiveLayout(
        mobileLayout: (context) => const HomeViewBody(),
        tabletLayout: (context) => const HomeViewBody(),
      ),
    );
  }
}
