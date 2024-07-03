import 'package:car_vendor/core/constant/my_const.dart';
import 'package:car_vendor/core/utils/app_color.dart';
import 'package:car_vendor/features/lang/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class YearDropdownButton extends StatefulWidget {
  const YearDropdownButton({super.key});

  @override
  State<YearDropdownButton> createState() => YearDropdownButtonState();
}

class YearDropdownButtonState extends State<YearDropdownButton> {
  String? _categoryValue;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        border: Border.all(
          color: AppColor.kSilver.withOpacity(.2),
        ),
      ),
      child: DropdownButton(
        isExpanded: true,
        underline: const SizedBox(),
        icon: const Icon(IconlyLight.arrow_down_2),
        dropdownColor: Colors.white,
        value: _categoryValue,
        hint: Text(
          _categoryValue ?? "brand".tr(context),
          style: const TextStyle(
            color: AppColor.kSilver,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        items: AppConstants.brandDropDownList(context),
        onChanged: (value) {
          setState(() {
            _categoryValue = value;
          });
        },
      ),
    );
  }
}

class BrandDropdownButton extends StatefulWidget {
  const BrandDropdownButton({super.key});

  @override
  State<BrandDropdownButton> createState() => BrandDropdownButtonState();
}

class BrandDropdownButtonState extends State<BrandDropdownButton> {
  String? _yearValue;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 7),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          border: Border.all(
            color: AppColor.kSilver.withOpacity(.2),
          )),
      child: DropdownButton(
        isExpanded: true,
        underline: const SizedBox(),
        icon: const Icon(IconlyLight.arrow_down_2),
        dropdownColor: Colors.white,
        value: _yearValue,
        hint: Text(
          _yearValue ?? "Model".tr(context),
          style: const TextStyle(
            color: AppColor.kSilver,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        items: YearProvider.yearDropDownList,
        onChanged: (value) {
          setState(() {
            _yearValue = value;
          });
        },
      ),
    );
  }
}
