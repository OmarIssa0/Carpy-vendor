import 'dart:io';

import 'package:car_vendor/core/constant/my_validators.dart';
import 'package:car_vendor/core/utils/app_color.dart';
import 'package:car_vendor/core/utils/app_styles.dart';
import 'package:car_vendor/core/utils/size_config.dart';
import 'package:car_vendor/core/widgets/custom_text_filed.dart';
import 'package:car_vendor/features/auth/presentation/manger/provider/sign_up_provider.dart';
import 'package:car_vendor/features/auth/presentation/view/widgets/forgot_password_button.dart';
import 'package:car_vendor/features/auth/presentation/view/widgets/user_info_type_dropdown.dart';
import 'package:car_vendor/features/lang/app_localization.dart';
import 'package:car_vendor/loading_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class SignUpViewBody extends StatelessWidget {
  const SignUpViewBody({super.key});

  // bool obscureText = true;
  // bool obscureTextVerify = true;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignUpProvider(),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: MediaQuery.sizeOf(context).width < SizeConfig.tablet
              ? const EdgeInsetsDirectional.only(start: 24, end: 24, top: 25)
              : EdgeInsetsDirectional.only(
                  start: MediaQuery.sizeOf(context).width / 6,
                  end: MediaQuery.sizeOf(context).width / 6,
                ),
          child: Consumer<SignUpProvider>(builder: (context, provider, child) {
            return Form(
              key: provider.formKey,
              child: LoadingMangerView(
                isLoading: provider.isLoading,
                child: Column(
                  children: [
                    provider.image == null
                        ? GestureDetector(
                            onTap: () {
                              provider.pickImage(context);
                            },
                            child: Container(
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: AppColor.kBackGroundColorSplash,
                                    width: 2),
                              ),
                              child: Center(
                                child: Text("Upload Image".tr(context)),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              // provider.pickImage(context);
                            },
                            child: Container(
                              height: 120,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: FileImage(File(provider.image!.path)),
                                ),
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: AppColor.kBackGroundColorSplash,
                                    width: 2),
                              ),
                              child: Center(
                                child: Align(
                                  alignment: const AlignmentDirectional(0, 1.6),
                                  child: IconButton(
                                    onPressed: () {
                                      provider.removeImage();
                                    },
                                    icon: const Icon(
                                      IconlyBold.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                    const SizedBox(height: 32),
                    CustomTextFiled(
                      onFieldSubmitted: (p0) {
                        FocusScope.of(context)
                            .requestFocus(provider.phoneNumberFocusNode);
                      },
                      controller: provider.nameCompanyController,
                      focusNode: provider.nameCompanyFocusNode,
                      textInputAction: TextInputAction.next,
                      prefix: const Icon(
                        IconlyBold.work,
                        color: AppColor.kSilver,
                      ),
                      title: "name Company".tr(context),
                      textInputType: TextInputType.name,
                      validator: (p0) {
                        return MyValidators.displayNameValidator(p0, context);
                      },
                    ),
                    const SizedBox(height: 16),
                    CustomTextFiled(
                      onFieldSubmitted: (p0) {
                        FocusScope.of(context)
                            .requestFocus(provider.emailFocusNode);
                      },
                      controller: provider.phoneNumberController,
                      focusNode: provider.phoneNumberFocusNode,
                      validator: (p0) {
                        return MyValidators.validateMobile(p0!, context);
                      },
                      maxLength: 10,
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
                      onFieldSubmitted: (p0) {
                        FocusScope.of(context)
                            .requestFocus(provider.passwordFocusNode);
                      },
                      controller: provider.emailController,
                      focusNode: provider.emailFocusNode,
                      validator: (p0) {
                        return MyValidators.emailValidator(p0, context);
                      },
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
                          provider.changeObscureText();
                        },
                        icon: provider.obscureText
                            ? const Icon(IconlyBold.show,
                                color: AppColor.kSilver)
                            : const Icon(IconlyBold.hide,
                                color: AppColor.kSilver),
                      ),
                      prefix: const Icon(
                        IconlyBold.password,
                        color: AppColor.kSilver,
                      ),
                      title: "Password".tr(context),
                      obscureText: provider.obscureText,
                      textInputType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                      focusNode: provider.passwordFocusNode,
                      controller: provider.passwordController,
                      validator: (p0) {
                        return MyValidators.passwordValidator(p0, context);
                      },
                      onFieldSubmitted: (p0) {
                        FocusScope.of(context)
                            .requestFocus(provider.confirmPasswordFocusNode);
                      },
                    ),
                    const SizedBox(height: 16),
                    CustomTextFiled(
                      controller: provider.confirmPasswordController,
                      focusNode: provider.confirmPasswordFocusNode,
                      suffixIcon: IconButton(
                        onPressed: () {
                          provider.changeObscureTextConfirm();
                        },
                        icon: provider.obscureTextConfirm
                            ? const Icon(IconlyBold.show,
                                color: AppColor.kSilver)
                            : const Icon(IconlyBold.hide,
                                color: AppColor.kSilver),
                      ),
                      prefix: const Icon(
                        IconlyBold.password,
                        color: AppColor.kSilver,
                      ),
                      title: "Verify Password".tr(context),
                      obscureText: provider.obscureTextConfirm,
                      textInputType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      validator: (p0) {
                        return MyValidators.repeatPasswordValidator(
                            password: provider.passwordController.text,
                            context,
                            value: p0);
                      },
                    ),
                    const SizedBox(height: 16),
                    const InfoUserMarketOrFreelancer(),
                    const SizedBox(height: 45),
                    ForgotPasswordButton(
                      onPressed: () {
                        provider.signUpFun(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Send email".tr(context),
                              style: AppStyles.semiBold16
                                  .copyWith(color: Colors.white)),
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
          }),
        ),
      ),
    );
  }
}
