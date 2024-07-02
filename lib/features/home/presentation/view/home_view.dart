import 'package:car_vendor/core/utils/app_color.dart';
import 'package:car_vendor/core/utils/app_styles.dart';
import 'package:car_vendor/core/widgets/adaptive_layout_widgets.dart';
import 'package:car_vendor/features/home/presentation/view/widgets/home_view_body.dart';
import 'package:car_vendor/features/settings/presentation/view/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.kBackGroundColorSplash,
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.white),
      ),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, SettingsView.routeName);
          },
          icon: const Icon(
            IconlyBold.setting,
            color: AppColor.kGrayColor,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Name Store',
          style: AppStyles.semiBold24.copyWith(
            color: AppColor.kBackGroundColorSplash,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: AdaptiveLayout(
        mobileLayout: (context) => const HomeViewBody(),
        tabletLayout: (context) => const HomeViewBody(),
      ),
    );
  }
}
