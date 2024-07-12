import 'package:car_vendor/core/utils/app_color.dart';
import 'package:car_vendor/core/widgets/adaptive_layout_widgets.dart';
import 'package:car_vendor/features/add_product/presentation/view/market_view.dart';
import 'package:car_vendor/features/lang/app_localization.dart';
import 'package:car_vendor/features/my_product/presentation/view/widgets/my_product_view_body.dart';
import 'package:flutter/material.dart';

class MyProductView extends StatelessWidget {
  const MyProductView({super.key});
  static const routeName = '/my_product_view';

  @override
  Widget build(BuildContext context) {
    // final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('My products'.tr(context)),
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.kBackGroundColorSplash,
        onPressed: () {
          // Navigator.pushNamed(context, AddProductsView.routeName);
          Navigator.pushNamed(context, MarkerView.routeName);
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: AdaptiveLayout(
        mobileLayout: (context) => const MyProductViewBody(),
        tabletLayout: (context) => const MyProductViewBody(),
      ),
    );
  }
}
