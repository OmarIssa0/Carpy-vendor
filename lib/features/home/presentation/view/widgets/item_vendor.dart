import 'package:car_vendor/core/utils/app_image.dart';
import 'package:car_vendor/core/utils/app_styles.dart';
import 'package:car_vendor/features/home/presentation/view/widgets/item_popover.dart';
import 'package:flutter/material.dart';

class ItemVendor extends StatelessWidget {
  const ItemVendor({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          Assets.imagesFerareCar,
          height: 85,
        ),
        Column(
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width / 2.5,
              child: Text(
                "Ferare Car" * 10,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppStyles.medium16,
              ),
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width / 2.5,
              child: Text(
                "Rs. 18,00,000.00" * 10,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppStyles.medium16,
              ),
            ),
          ],
        ),
        const ItemPopover(),
      ],
    );
  }
}
