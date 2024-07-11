import 'package:car_vendor/features/my_product/presentation/view/widgets/item_products_vendor.dart';
import 'package:car_vendor/features/my_product/presentation/view_model/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyProductViewBody extends StatelessWidget {
  const MyProductViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    // final getCurrentProduct = productProvider.findByProductId(productId);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: List.generate(
          productProvider.getProduct.length,
          (index) => ItemProductsVendor(
            productId: productProvider.getProduct[index].productsId,
          ),
        ),
      ),
    );
  }
}
