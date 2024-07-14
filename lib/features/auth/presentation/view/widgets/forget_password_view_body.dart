import 'package:car_vendor/core/constant/my_validators.dart';
import 'package:car_vendor/core/utils/app_color.dart';
import 'package:car_vendor/core/utils/app_image.dart';
import 'package:car_vendor/core/utils/app_styles.dart';
import 'package:car_vendor/core/utils/size_config.dart';
import 'package:car_vendor/core/widgets/custom_text_filed.dart';
import 'package:car_vendor/features/auth/presentation/manger/provider/forget_password_provider.dart';
import 'package:car_vendor/features/auth/presentation/view/widgets/forgot_password_button.dart';
import 'package:car_vendor/features/lang/app_localization.dart';
import 'package:car_vendor/loading_manger.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class ForgetPasswordViewBody extends StatelessWidget {
  const ForgetPasswordViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ForgetPasswordProvider(),
      child: SingleChildScrollView(
        child: Padding(
          padding: MediaQuery.sizeOf(context).width < SizeConfig.tablet
              ? const EdgeInsetsDirectional.symmetric(horizontal: 24)
              : EdgeInsetsDirectional.only(
                  start: MediaQuery.sizeOf(context).width / 6,
                  end: MediaQuery.sizeOf(context).width / 6,
                ),
          child: Consumer<ForgetPasswordProvider>(
              builder: (context, provider, child) {
            return Form(
              key: provider.formKey,
              child: LoadingMangerView(
                isLoading: provider.isLoading,
                child: Column(
                  children: [
                    const SizedBox(height: 44),
                    Image.asset(Assets.imagesNewIconApp, height: 76),
                    const SizedBox(height: 95),
                    Text("Forgot Password".tr(context),
                        style: AppStyles.semiBold20),
                    const SizedBox(height: 5),
                    Text(
                        "Please enter the email address you'd like your password reset information sent to"
                            .tr(context),
                        textAlign: TextAlign.center,
                        style: AppStyles.regular14),
                    const SizedBox(height: 44),
                    CustomTextFiled(
                      controller: provider.emailController,
                      focusNode: provider.emailFocusNode,
                      validator: (p0) {
                        return MyValidators.emailValidator(p0, context);
                      },
                      onFieldSubmitted: (p0) {
                        provider.forgetPasswordFun(context);
                      },
                      title: "Email address".tr(context),
                      textInputType: TextInputType.emailAddress,
                      prefix: const Icon(
                        IconlyBold.message,
                        color: AppColor.kSilver,
                      ),
                    ),
                    const SizedBox(height: 44),
                    ForgotPasswordButton(
                      onPressed: () {
                        provider.forgetPasswordFun(context);
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
