import 'package:car_vendor/core/utils/app_color.dart';
import 'package:car_vendor/core/utils/app_styles.dart';
import 'package:car_vendor/core/widgets/adaptive_layout_widgets.dart';
import 'package:car_vendor/features/auth/presentation/view/widgets/sign_up_body_view.dart';
import 'package:car_vendor/features/lang/app_localization.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  static const String routeName = 'SignUpView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
        title: Text(
          "Create a merchant account".tr(context),
          style: AppStyles.semiBold24
              .copyWith(color: AppColor.kBackGroundColorSplash),
        ),
      ),
      body: AdaptiveLayout(
        mobileLayout: (context) => const SignUpViewBody(),
        tabletLayout: (context) => const SignUpViewBody(),
      ),
    );
  }
}
