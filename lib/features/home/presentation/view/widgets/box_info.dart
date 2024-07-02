
import 'package:car_vendor/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

class BoxInfo extends StatelessWidget {
  const BoxInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(250),
          child: Image.network(
            'https://picsum.photos/200',
            height: 70,
            fit: BoxFit.scaleDown,
          ),
        ),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "Company Name",
              style: AppStyles.semiBold20,
            ),
            Text(
              "+91 1234567890",
              style: AppStyles.medium17,
            ),
          ],
        )
      ],
    );
  }
}
