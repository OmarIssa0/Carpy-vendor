import 'package:car_vendor/core/utils/app_color.dart';
import 'package:car_vendor/core/utils/app_styles.dart';
import 'package:car_vendor/features/add_product/presentation/view/widgets/market_view_body.dart';
import 'package:car_vendor/features/auth/presentation/manger/model/user_model.dart';
import 'package:car_vendor/features/lang/app_localization.dart';
import 'package:car_vendor/features/my_product/presentation/view_model/model/products_model.dart';
import 'package:flutter/material.dart';

class MarkerView extends StatelessWidget {
  const MarkerView({super.key, this.productsModel, this.userModel});
  static String routeName = '/kMarketView';

  final ProductsModel? productsModel;
  final UserModel? userModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: const AdMobBanner(),
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
          'Add product'.tr(context),
          style: AppStyles.semiBold22.copyWith(
            color: AppColor.kBackGroundColorSplash,
          ),
        ),
      ),
      body: MarketViewBody(
        productsModel: productsModel,
      ),
    );
  }
}
