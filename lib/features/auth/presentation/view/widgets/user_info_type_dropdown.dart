import 'package:car_vendor/core/constant/my_const.dart';
import 'package:car_vendor/core/utils/app_color.dart';
import 'package:car_vendor/features/auth/presentation/manger/provider/sign_up_provider.dart';
import 'package:car_vendor/features/lang/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class InfoUserMarketOrFreelancer extends StatefulWidget {
  const InfoUserMarketOrFreelancer({super.key});

  @override
  State<InfoUserMarketOrFreelancer> createState() => YearDropdownButtonState();
}

class YearDropdownButtonState extends State<InfoUserMarketOrFreelancer> {
  // String? _categoryValue;
  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpProvider>(builder: (context, provider, child) {
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
          value: provider.companyType,
          hint: Text(
            provider.companyType ?? "Choose your account type".tr(context),
            style: const TextStyle(
              color: AppColor.kSilver,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          items: AppConstants.userInfoType(context),
          onChanged: (value) {
            setState(() {
              provider.companyType = value;
            });
          },
        ),
      );
    });
  }
}
