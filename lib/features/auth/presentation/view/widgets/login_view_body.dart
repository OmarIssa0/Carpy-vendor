import 'package:car_vendor/core/constant/my_validators.dart';
import 'package:car_vendor/core/utils/animation_nav.dart';
import 'package:car_vendor/core/utils/app_color.dart';
import 'package:car_vendor/core/utils/app_image.dart';
import 'package:car_vendor/core/utils/app_styles.dart';
import 'package:car_vendor/core/utils/size_config.dart';
import 'package:car_vendor/core/widgets/custom_button.dart';
import 'package:car_vendor/core/widgets/custom_text_filed.dart';
import 'package:car_vendor/features/auth/presentation/manger/provider/login_provider.dart';
import 'package:car_vendor/features/auth/presentation/view/forget_password_view.dart';
import 'package:car_vendor/features/auth/presentation/view/sign_up_view.dart';
import 'package:car_vendor/features/lang/app_localization.dart';
import 'package:car_vendor/loading_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginProvider(),
      child: SingleChildScrollView(
        child: Padding(
          // padding: const EdgeInsets.
          padding: MediaQuery.sizeOf(context).width < SizeConfig.tablet
              ? const EdgeInsetsDirectional.symmetric(horizontal: 24)
              : EdgeInsetsDirectional.only(
                  start: MediaQuery.sizeOf(context).width / 6,
                  end: MediaQuery.sizeOf(context).width / 6,
                ),
          child: Consumer<LoginProvider>(builder: (context, provider, child) {
            return Form(
              key: provider.formKey,
              child: LoadingMangerView(
                isLoading: provider.isLoading,
                child: Column(
                  children: [
                    const SizedBox(height: 44),
                    Image.asset(Assets.imagesSplachImage, height: 76),
                    const SizedBox(height: 95),
                    Text("Login".tr(context), style: AppStyles.semiBold20),
                    Text("Welcome to Carpy vendor".tr(context),
                        style: AppStyles.regular14),
                    const SizedBox(height: 44),
                    CustomTextFiled(
                      controller: provider.emailTextController,
                      focusNode: provider.emailFocusNode,
                      title: "Email address".tr(context),
                      textInputType: TextInputType.emailAddress,
                      prefix: const Icon(
                        IconlyBold.message,
                        color: AppColor.kSilver,
                      ),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context)
                            .requestFocus(provider.passwordFocusNode);
                      },
                      validator: (value) {
                        return MyValidators.emailValidator(value, context);
                      },
                    ),
                    const SizedBox(height: 24),
                    CustomTextFiled(
                      controller: provider.passwordTextController,
                      focusNode: provider.passwordFocusNode,
                      validator: (value) {
                        return MyValidators.passwordValidator(value, context);
                      },
                      title: "Password".tr(context),
                      textInputType: TextInputType.visiblePassword,
                      obscureText: provider.obscureText,
                      prefix: const Icon(
                        IconlyBold.password,
                        color: AppColor.kSilver,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          provider.obscureText
                              ? IconlyBold.show
                              : IconlyBold.hide,
                          color: AppColor.kSilver,
                        ),
                        onPressed: () {
                          provider.changeObscureText();
                        },
                      ),
                      onFieldSubmitted: (value) {
                        provider.loginFun(context);
                      },
                    ),
                    const SizedBox(height: 24),
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              AnimationNav.navigatorAnimation(
                                  child: const ForgetPasswordView()));
                        },
                        child: Text("Forgot Password?".tr(context),
                            style: AppStyles.medium14
                                .copyWith(color: AppColor.kBlack)),
                      ),
                    ),
                    const SizedBox(height: 24),
                    CustomButton(
                      title: 'Login'.tr(context),
                      onPressed: () {
                        provider.loginFun(context);
                      },
                    ),
                    const SizedBox(height: 45),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don’t have an vendor account ?".tr(context),
                              style: AppStyles.medium12),
                          GestureDetector(
                            onTap: () {
                              // Navigator.pushNamed(context, SignUpView.routeName);
                              Navigator.push(
                                  context,
                                  AnimationNav.navigatorAnimation(
                                      child: const SignUpView()));
                            },
                            child: Text(" Sign Up".tr(context),
                                style: AppStyles.medium14.copyWith(
                                    color: AppColor.kBackGroundColorSplash)),
                          ),
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
