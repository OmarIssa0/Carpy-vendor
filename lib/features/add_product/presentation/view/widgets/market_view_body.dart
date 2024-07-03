import 'package:car_vendor/core/utils/app_color.dart';
import 'package:car_vendor/core/utils/size_config.dart';
import 'package:car_vendor/core/widgets/custom_button.dart';
import 'package:car_vendor/core/widgets/custom_text_filed.dart';
import 'package:car_vendor/features/add_product/presentation/view/widgets/custom_dropdown_button.dart';
import 'package:car_vendor/features/add_product/presentation/view/widgets/text_form_field_description.dart';
import 'package:car_vendor/features/add_product/presentation/view/widgets/upload_image_button.dart';
import 'package:car_vendor/features/lang/app_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconly/iconly.dart';

class MarketViewBody extends StatelessWidget {
  const MarketViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: MediaQuery.sizeOf(context).width < SizeConfig.tablet
            ? const EdgeInsetsDirectional.symmetric(horizontal: 24)
            : EdgeInsetsDirectional.only(
                start: MediaQuery.sizeOf(context).width / 6,
                end: MediaQuery.sizeOf(context).width / 6,
              ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const UploadImageButton(),
            const Divider(
              color: AppColor.kGrayOpacity,
              height: 60,
              thickness: .5,
              endIndent: 16,
              indent: 16,
            ),
            CustomTextFiled(
              title: "Product Name".tr(context),
              textInputType: TextInputType.name,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: CustomTextFiled(
                      title: "Price".tr(context),
                      textInputType: TextInputType.number),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: CustomTextFiled(
                      title: "Discount".tr(context),
                      textInputType: TextInputType.number),
                ),
              ],
            ),
            const SizedBox(height: 15),
            const Row(
              children: [
                Expanded(
                  child: YearDropdownButton(),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: BrandDropdownButton(),
                ),
              ],
            ),
            const SizedBox(height: 15),
            CustomTextFiled(
              prefix: const Icon(IconlyBold.location, color: AppColor.kSilver),
              title: "Location".tr(context),
              textInputType: TextInputType.streetAddress,
            ),
            const SizedBox(height: 15),
            const TextFormFieldDescription(),
            const SizedBox(height: 45),
            CustomButton(title: "Add Product".tr(context), onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
