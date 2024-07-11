import 'package:car_vendor/core/utils/app_image.dart';
import 'package:car_vendor/core/utils/app_styles.dart';
import 'package:car_vendor/core/utils/size_config.dart';
import 'package:car_vendor/core/widgets/drop_down_button.dart';
import 'package:flutter/material.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: MediaQuery.sizeOf(context).width < SizeConfig.tablet
            ? const EdgeInsetsDirectional.symmetric(horizontal: 24)
            : EdgeInsetsDirectional.only(
                start: MediaQuery.sizeOf(context).width / 6,
                end: MediaQuery.sizeOf(context).width / 6,
              ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(Assets.imagesFerareCar),
                ),
                SizedBox(width: 19),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      // 'Matilda Brown',
                      "+962799999999",
                      style: AppStyles.regular12,
                    ),
                    Text(
                      'name company',
                      style: AppStyles.medium14,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 33),
            DropDownButtonLocal(),
          ],
        ),
      ),
    );
  }
}
