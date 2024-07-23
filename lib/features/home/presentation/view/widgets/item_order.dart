import 'package:car_vendor/core/utils/app_styles.dart';
import 'package:car_vendor/features/my_product/presentation/view_model/provider/my_products_provider.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemOrder extends StatelessWidget {
  const ItemOrder({
    super.key,
    required this.productId,
    required this.name,
    required this.phone,
  });

  final String productId, name, phone;

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<VendorProductsProvider>(context);
    final getCurrentProduct = productProvider.findByProductId(productId);

    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: size.height * .17,
          // padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getCurrentProduct?.imagesProduct.first == null
                  ? const SizedBox.shrink()
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: FancyShimmerImage(
                        imageUrl: getCurrentProduct?.imagesProduct.first,
                        height: size.height * .15,
                        errorWidget: const Icon(Icons.error),
                        width: size.width * .32,
                        boxFit: BoxFit.cover,
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
                          getCurrentProduct?.nameProduct ?? "",
                          style: AppStyles.regular14,
                          textAlign: TextAlign.end,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: size.width * .45,
                        child: Text(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          getCurrentProduct?.descriptionProduct ?? "",
                          style: AppStyles.regular14,
                          textAlign: TextAlign.end,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: size.width * .45,
                        child: Text(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          name,
                          style: AppStyles.regular14,
                          textAlign: TextAlign.end,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: size.width * .45,
                        child: Text(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          phone,
                          style: AppStyles.regular14,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: size.width * .45,
                    child: Text(
                      getCurrentProduct?.priceProduct.toString() ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.regular12,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Divider(
          color: Colors.grey.shade400,
        )
      ],
    );
  }
}
