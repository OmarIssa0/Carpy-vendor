import 'package:car_vendor/core/utils/app_color.dart';
import 'package:car_vendor/core/utils/app_styles.dart';
import 'package:car_vendor/core/utils/size_config.dart';
import 'package:car_vendor/features/add_product/presentation/view/market_view.dart';
import 'package:car_vendor/features/lang/app_localization.dart';
import 'package:flutter/material.dart';

class AddProductsViewBody extends StatelessWidget {
  const AddProductsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.sizeOf(context).width < SizeConfig.tablet
          ? const EdgeInsetsDirectional.symmetric(horizontal: 24)
          : EdgeInsetsDirectional.only(
              start: MediaQuery.sizeOf(context).width / 6,
              end: MediaQuery.sizeOf(context).width / 6,
            ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Choose the ad type'.tr(context),
                style: AppStyles.semiBold22,
              ),
              const SizedBox(height: 45),
              ItemAD(
                name: "market",
                onTap: () {
                  Navigator.pushNamed(context, MarkerView.routeName);
                },
              ),
              const SizedBox(height: 50),
              ItemAD(
                name: "freelancer",
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ItemAD extends StatelessWidget {
  const ItemAD({
    super.key,
    required this.name,
    this.onTap,
  });

  final String name;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: MediaQuery.sizeOf(context).height * .15,
        width: MediaQuery.sizeOf(context).width * .5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColor.kGrayColor.withOpacity(.2),
        ),
        child: Center(
          child: Text(
            name.tr(context),
            style: AppStyles.bold27.copyWith(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
