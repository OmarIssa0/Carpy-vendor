import 'package:car_vendor/core/utils/app_styles.dart';
import 'package:car_vendor/core/utils/size_config.dart';
import 'package:car_vendor/features/auth/presentation/manger/provider/user_provider.dart';
import 'package:car_vendor/features/home/presentation/view/widgets/item_order.dart';
import 'package:car_vendor/features/lang/app_localization.dart';
import 'package:car_vendor/features/my_product/presentation/view/widgets/item_products_vendor.dart';
import 'package:car_vendor/features/my_product/presentation/view_model/provider/my_products_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final vendorProductProvider = Provider.of<VendorProductsProvider>(context);
    vendorProductProvider.fetchMyProducts();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final userModel = userProvider.userModel;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: MediaQuery.sizeOf(context).width < SizeConfig.tablet
            ? const EdgeInsetsDirectional.only(start: 24, end: 24)
            : EdgeInsetsDirectional.only(
                start: MediaQuery.sizeOf(context).width / 6,
                end: MediaQuery.sizeOf(context).width / 6,
              ),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('vendors')
              .where('vendorId', isEqualTo: userModel!.vendorId)
              .snapshots(),
          builder: (context, snapshot) {
            // if (snapshot.connectionState == ConnectionState.waiting) {
            //   return const Center(child: CircularProgressIndicator());
            // }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('No products available'));
            }

            final vendorDocs = snapshot.data!.docs;

            return Column(
              children: List.generate(
                vendorDocs.length,
                (vendorIndex) {
                  var vendorData =
                      vendorDocs[vendorIndex].data() as Map<String, dynamic>;

                  if (!vendorData.containsKey('myOrders')) {
                    return const ListTile(
                      title: Text('Error: Missing Order field in document'),
                    );
                  }

                  var productsList = vendorData['myOrders'] as List<dynamic>;

                  return productsList.isEmpty
                      ? Center(child: Text("No Orders".tr(context)))
                      : Column(
                          children: List.generate(
                            productsList.length,
                            (productIndex) {
                              var product = productsList[productIndex]
                                  as Map<String, dynamic>;

                              return GestureDetector(
                                  // onTap: () {
                                  //   Navigator.pushNamed(
                                  //     context,
                                  //     MarkerView.routeName,
                                  //     arguments: product['productId'],
                                  //   );
                                  // },
                                  child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: ItemOrder(
                                  productId: product['productId'],
                                  name: product['userName'],
                                  phone: product['userPhone'],
                                ),
                              ));
                            },
                          ),
                        );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
