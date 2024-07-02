import 'package:car_vendor/core/utils/app_color.dart';
import 'package:car_vendor/core/utils/app_styles.dart';
import 'package:car_vendor/core/utils/size_config.dart';
import 'package:car_vendor/features/home/presentation/view/widgets/box_info.dart';
import 'package:car_vendor/features/home/presentation/view/widgets/item_vendor.dart';
import 'package:car_vendor/features/lang/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: MediaQuery.sizeOf(context).width < SizeConfig.tablet
            ? const EdgeInsetsDirectional.only(start: 24, end: 24)
            : EdgeInsetsDirectional.only(
                start: MediaQuery.sizeOf(context).width / 6,
                end: MediaQuery.sizeOf(context).width / 6,
              ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            const BoxInfo(),
            const Divider(
              height: 40,
              color: AppColor.kGrayOpacity,
              thickness: .5,
            ),
            Text(
              "My products".tr(context),
              style: AppStyles.semiBold22,
            ),
            const SizedBox(height: 25),
            const ItemVendor()
          ],
        ),
      ),
    );
  }
}
