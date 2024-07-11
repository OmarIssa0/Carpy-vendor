import 'package:car_vendor/core/widgets/adaptive_layout_widgets.dart';
import 'package:car_vendor/features/lang/app_localization.dart';
import 'package:car_vendor/features/profile/presentation/view/widgets/profile_view_body.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});
  static const String routeName = 'ProfileView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "My Profile".tr(context),
        ),
      ),
      body: AdaptiveLayout(
        mobileLayout: (context) => const ProfileViewBody(),
        tabletLayout: (context) => const ProfileViewBody(),
      ),
    );
  }
}
