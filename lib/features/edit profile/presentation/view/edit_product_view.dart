import 'dart:developer';

import 'package:car_vendor/core/utils/app_image.dart';
import 'package:car_vendor/core/widgets/alert_dialog.dart';
import 'package:car_vendor/features/auth/presentation/manger/provider/user_provider.dart';
import 'package:car_vendor/features/auth/presentation/view/login_view.dart';
import 'package:car_vendor/features/edit%20profile/presentation/view/widgets/edit_product_body_view.dart';
import 'package:car_vendor/features/lang/app_localization.dart';
import 'package:car_vendor/loading_manger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import 'package:provider/provider.dart';

class EditProductsView extends StatefulWidget {
  const EditProductsView({super.key});
  static const String routeName = '/EditProductsView';

  @override
  State<EditProductsView> createState() => _EditProductsViewState();
}

class _EditProductsViewState extends State<EditProductsView> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return LoadingMangerView(
      isLoading: isLoading,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 8),
              child: Builder(builder: (context) {
                return IconButton(
                  onPressed: () {
                    showPopover(
                      context: context,
                      bodyBuilder: (context) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () async {
                                AlertDialogMethods.showDialogWaring(
                                  context: context,
                                  subtitle:
                                      "Are you sure you want to delete your account?"
                                          .tr(context),
                                  titleBottom: "Delete account".tr(context),
                                  isError: false,
                                  lottileAnimation: Assets.imagesErrorMas,
                                  function: () async {
                                    try {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      deleteVendorAndProducts(
                                          context, userProvider);
                                    } on Exception catch (e) {
                                      AlertDialogMethods.showError(
                                        context: context,
                                        subtitle: e.toString(),
                                        titleBottom: "Ok",
                                        lottileAnimation: Assets.imagesErrorMas,
                                        function: () async {},
                                      );
                                    } finally {
                                      setState(() {
                                        isLoading = false;
                                      });
                                    }
                                  },
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 55, vertical: 25),
                                child: Text(
                                  'Delete account'.tr(context),
                                  style: const TextStyle(fontSize: 11),
                                ),
                              ),
                            ),
                            Container(
                              width: 145,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade50)),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.more_vert),
                );
              }),
            ),
          ],
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          title: Text("Edit profile".tr(context)),
        ),
        body: const EditProductBodyView(),
      ),
    );
  }
}

Future<void> deleteVendorAndProducts(
    BuildContext context, UserProvider userProvider) async {
  try {
    // جلب وثيقة البائع للحصول على قائمة products
    DocumentSnapshot vendorSnapshot = await FirebaseFirestore.instance
        .collection("vendors")
        .doc(userProvider.getUserModel!.vendorId)
        .get();

    if (!vendorSnapshot.exists || vendorSnapshot.data() == null) {
      print("Vendor document does not exist or has no data.");
      return;
    }

    Map<String, dynamic>? vendorData =
        vendorSnapshot.data() as Map<String, dynamic>?;

    // التحقق من وجود حقل products في وثيقة البائع
    if (vendorData == null || !vendorData.containsKey('products')) {
      print("Field 'products' does not exist in the vendor document.");
      return;
    }

    // استخراج قائمة products من وثيقة البائع
    List<dynamic> products = vendorData['products'] as List<dynamic>;

    // حذف المنتجات المطابقة في مجموعة product
    for (var product in products) {
      // تأكد من أن product هو خريطة ولديه مفتاح productId
      if (product is Map<String, dynamic> && product.containsKey('productId')) {
        String productId = product['productId'];
        await FirebaseFirestore.instance
            .collection("product")
            .doc(productId)
            .delete();
      }
    }

    // حذف بيانات البائع من مجموعة vendors
    await FirebaseFirestore.instance
        .collection("vendors")
        .doc(userProvider.getUserModel!.vendorId)
        .delete();

    // حذف حساب البائع من Firebase Authentication
    await FirebaseAuth.instance.currentUser!.delete();

    if (!context.mounted) return;
    Navigator.of(context).pop();
    Navigator.of(context).pushReplacementNamed(LoginView.routeName);
  } catch (e) {
    // التعامل مع الأخطاء هنا
    print("Error deleting vendor and products: $e");
  }
}
