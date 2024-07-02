import 'package:car_vendor/core/utils/app_color.dart';
import 'package:car_vendor/core/utils/app_styles.dart';
import 'package:car_vendor/core/widgets/adaptive_layout_widgets.dart';
import 'package:car_vendor/features/lang/app_localization.dart';
import 'package:car_vendor/features/settings/presentation/view/widgets/settings_view_body.dart';
import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});
  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
        title: Text(
          'Settings'.tr(context),
          style: AppStyles.semiBold22.copyWith(
            color: AppColor.kBackGroundColorSplash,
          ),
        ),
      ),
      body: AdaptiveLayout(
        mobileLayout: (context) => const SettingsViewBody(),
        tabletLayout: (context) => const SettingsViewBody(),
      ),
    );
  }
}
