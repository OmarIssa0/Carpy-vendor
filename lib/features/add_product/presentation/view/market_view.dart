import 'package:car_vendor/core/utils/app_color.dart';
import 'package:car_vendor/core/utils/app_styles.dart';
import 'package:car_vendor/core/widgets/adaptive_layout_widgets.dart';
import 'package:car_vendor/features/add_product/presentation/view/widgets/market_view_body.dart';
import 'package:car_vendor/features/lang/app_localization.dart';
import 'package:flutter/material.dart';

class MarkerView extends StatelessWidget {
  const MarkerView({super.key});
  static String routeName = '/kMarketView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColor.kGrayColor,
          ),
        ),
        title: Text(
          'market'.tr(context),
          style: AppStyles.semiBold22.copyWith(
            color: AppColor.kBackGroundColorSplash,
          ),
        ),
      ),
      body: AdaptiveLayout(
        mobileLayout: (context) => const MarketViewBody(),
        tabletLayout: (context) => const MarketViewBody(),
      ),
    );
  }
}
