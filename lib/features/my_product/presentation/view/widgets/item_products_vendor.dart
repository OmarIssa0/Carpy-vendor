import 'package:car_vendor/core/utils/app_styles.dart';
import 'package:car_vendor/features/add_product/presentation/view/market_view.dart';
import 'package:car_vendor/features/auth/presentation/manger/model/user_model.dart';
import 'package:car_vendor/features/auth/presentation/manger/provider/user_provider.dart';
import 'package:car_vendor/features/my_product/presentation/view_model/model/products_model.dart';
import 'package:car_vendor/features/my_product/presentation/view_model/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemProductsVendor extends StatelessWidget {
  const ItemProductsVendor(
      {super.key, required this.productId, this.productsModel});

  final String productId;

  final ProductsModel? productsModel;

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    // final userModel = Provider.of<UserModel>(context, listen: false);
    final getCurrentProduct = productProvider.findByProductId(productId);
    final getUser = userProvider.getUser();
    Size size = MediaQuery.of(context).size;
    return getCurrentProduct == null
        ? const SizedBox.shrink()
        : Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MarkerView(
                        productsModel: getCurrentProduct,
                        // userModel: userModel,
                      ),
                    ),
                  );
                },
                child: Container(
                  height: size.height * .17,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          getCurrentProduct.imagesProduct.first,
                          height: size.height * .15,
                          width: size.width * .32,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: size.width * .45,
                                child: Text(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  getCurrentProduct.nameProduct,
                                  style: AppStyles.regular14,
                                  textAlign: TextAlign.end,
                                ),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: size.width * .45,
                                child: Text(
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  getCurrentProduct.descriptionProduct,
                                  style: AppStyles.regular14,
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: size.width * .45,
                            child: Text(
                              getCurrentProduct.priceProduct.toString(),
                              style: AppStyles.regular12,
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                color: Colors.grey.shade400,
              )
            ],
          );
  }
}
