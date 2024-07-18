// import 'package:car_vendor/features/my_product/presentation/view/widgets/item_products_vendor.dart';
// import 'package:car_vendor/features/my_product/presentation/view_model/provider/mu_products_provider.dart';
// import 'package:car_vendor/features/my_product/presentation/view_model/provider/product_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class MyProductViewBody extends StatelessWidget {
//   const MyProductViewBody({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final productProvider = Provider.of<ProductProvider>(context);
//     // final getCurrentProduct = productProvider.findByProductId(productId);
//     final vendorProvider = Provider.of<VendorProductsProvider>(context);

//     return SingleChildScrollView(
//       physics: const BouncingScrollPhysics(),
//       child: Column(
//         children: List.generate(
//           vendorProvider.myProducts.length,
//           (index) => ItemProductsVendor(
//             // productId: productProvider.getProduct[index].productsId!,
//             productId:
//                 vendorProvider.myProducts.values.toList()[index].productsId,
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:car_vendor/features/my_product/presentation/view/widgets/item_products_vendor.dart';
import 'package:car_vendor/features/my_product/presentation/view_model/provider/my_products_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyProductViewBody extends StatelessWidget {
  const MyProductViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final vendorProductProvider = Provider.of<VendorProductsProvider>(context);
    vendorProductProvider.fetchMyProducts();

    return Consumer<VendorProductsProvider>(
      builder: (context, provider, child) {
        final myProducts = provider.myProducts;
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: myProducts.isEmpty
              ? const Center(child: Text("No Products Found"))
              : Column(
                  children: List.generate(
                    myProducts.length,
                    (index) => ItemProductsVendor(
                      productId: vendorProductProvider.myProducts.values
                          .toList()[index]
                          .productsId,
                      image: vendorProductProvider.myProducts.values
                          .toList()[index]
                          .imagesProduct
                          .first,
                      title: vendorProductProvider.myProducts.values
                          .toList()[index]
                          .nameProduct,
                      price: vendorProductProvider.myProducts.values
                          .toList()[index]
                          .priceProduct,
                      description: vendorProductProvider.myProducts.values
                          .toList()[index]
                          .descriptionProduct,
                    ),
                  ),
                ),
        );
      },
    );
  }
}
