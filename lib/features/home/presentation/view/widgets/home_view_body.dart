import 'package:car_vendor/core/utils/size_config.dart';
import 'package:car_vendor/features/auth/presentation/manger/provider/user_provider.dart';
import 'package:car_vendor/features/home/presentation/view/widgets/item_order.dart';
import 'package:car_vendor/features/lang/app_localization.dart';
import 'package:car_vendor/features/my_product/presentation/view_model/provider/my_products_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
        padding: const EdgeInsetsDirectional.only(start: 24, end: 24),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('vendors')
              .where('vendorId', isEqualTo: userModel?.vendorId)
              .snapshots(),
          builder: (context, snapshot) {
            // if (snapshot.connectionState == ConnectionState.waiting) {
            //   return const Center(child: CircularProgressIndicator());
            // }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text('No products available'.tr(context)));
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

  void _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    // ignore: deprecated_member_use
    await launch(launchUri.toString());
  }
}
