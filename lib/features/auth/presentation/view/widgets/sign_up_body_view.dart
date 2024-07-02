import 'package:car_vendor/core/utils/app_color.dart';
import 'package:car_vendor/core/utils/app_styles.dart';
import 'package:car_vendor/core/utils/size_config.dart';
import 'package:car_vendor/core/widgets/custom_text_filed.dart';
import 'package:car_vendor/features/auth/presentation/view/widgets/forgot_password_button.dart';
import 'package:car_vendor/features/lang/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconly/iconly.dart';

class SignUpViewBody extends StatefulWidget {
  const SignUpViewBody({super.key});

  @override
  State<SignUpViewBody> createState() => _SignUpViewBodyState();
}

class _SignUpViewBodyState extends State<SignUpViewBody> {
  bool obscureText = true;
  bool obscureTextVerify = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: MediaQuery.sizeOf(context).width < SizeConfig.tablet
            ? const EdgeInsetsDirectional.only(start: 24, end: 24, top: 25)
            : EdgeInsetsDirectional.only(
                start: MediaQuery.sizeOf(context).width / 6,
                end: MediaQuery.sizeOf(context).width / 6,
              ),
        child: Column(
          children: [
            Container(
              height: 120,
              // width: 75,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                // color: AppColor.kBackGroundColorSplash,
                border: Border.all(
                    color: AppColor.kBackGroundColorSplash, width: 2),
              ),
              child: Center(
                child: Text("Upload Image".tr(context)),
              ),
            ),
            const SizedBox(height: 32),
            CustomTextFiled(
              prefix: const Icon(
                IconlyBold.work,
                color: AppColor.kSilver,
              ),
              title: "name Company".tr(context),
              textInputType: TextInputType.name,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),
            CustomTextFiled(
              prefix: const Icon(
                IconlyBold.call,
                color: AppColor.kSilver,
              ),
              title: "Phone number".tr(context),
              textInputType: TextInputType.number,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),
            CustomTextFiled(
              prefix: const Icon(
                IconlyBold.message,
                color: AppColor.kSilver,
              ),
              title: "Email address".tr(context),
              textInputType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),
            CustomTextFiled(
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                icon: obscureText
                    ? const Icon(IconlyBold.show, color: AppColor.kSilver)
                    : const Icon(IconlyBold.hide, color: AppColor.kSilver),
              ),
              prefix: const Icon(
                IconlyBold.password,
                color: AppColor.kSilver,
              ),
              title: "Password".tr(context),
              obscureText: obscureText,
              textInputType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),
            CustomTextFiled(
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    obscureTextVerify = !obscureTextVerify;
                  });
                },
                icon: obscureTextVerify
                    ? const Icon(IconlyBold.show, color: AppColor.kSilver)
                    : const Icon(IconlyBold.hide, color: AppColor.kSilver),
              ),
              prefix: const Icon(
                IconlyBold.password,
                color: AppColor.kSilver,
              ),
              title: "Verify Password".tr(context),
              obscureText: obscureTextVerify,
              textInputType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
            ),
            const SizedBox(height: 45),
            ForgotPasswordButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Send email".tr(context),
                      style:
                          AppStyles.semiBold16.copyWith(color: Colors.white)),
                  const SizedBox(height: 5),
                  const Icon(
                    IconlyBold.send,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
