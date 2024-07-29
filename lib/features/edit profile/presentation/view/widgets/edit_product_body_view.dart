import 'dart:io';
import 'package:car_vendor/core/utils/app_color.dart';
import 'package:car_vendor/core/utils/size_config.dart';
import 'package:car_vendor/core/widgets/custom_button.dart';
import 'package:car_vendor/core/widgets/custom_text_filed.dart';
import 'package:car_vendor/features/edit%20profile/presentation/view_model/provider/edit_profile_provider.dart';
import 'package:car_vendor/features/lang/app_localization.dart';
import 'package:car_vendor/loading_manger.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class EditProductBodyView extends StatelessWidget {
  const EditProductBodyView({super.key});

  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<UserProvider>(context);
    return ChangeNotifierProvider(
      create: (context) => EditProfileProvider(context),
      child: Consumer<EditProfileProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            child: Padding(
              padding: MediaQuery.sizeOf(context).width < SizeConfig.tablet
                  ? const EdgeInsetsDirectional.only(start: 24, end: 24)
                  : EdgeInsetsDirectional.only(
                      start: MediaQuery.sizeOf(context).width / 6,
                      end: MediaQuery.sizeOf(context).width / 6,
                    ),
              child: LoadingMangerView(
                isLoading: provider.isLoading,
                child: Form(
                  key: provider.formKey,
                  child: Column(
                    children: [
                      if (provider.productImageUrl != null) ...[
                        FancyShimmerImage(
                          imageUrl: provider.productImageUrl!,
                          height: 150,
                          boxFit: BoxFit.contain,
                          errorWidget: const Icon(
                            Icons.error,
                            color: Colors.red,
                          ),
                        )
                      ] else if (provider.image == null) ...[
                        GestureDetector(
                          onTap: () {
                            provider.pickImages();
                          },
                          child: Container(
                            height: 150,
                            decoration: BoxDecoration(
                              // color: Colors.black,
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
                      ] else ...[
                        Image.file(
                          File(provider.image!.path),
                          height: 150,
                        )
                      ],
                      if (provider.image != null ||
                          provider.productImageUrl != null) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                provider.pickImages();
                              },
                              child: Text("Upload Image".tr(context),
                                  style:
                                      TextStyle(color: Colors.grey.shade600)),
                            ),
                            TextButton(
                              onPressed: () {
                                provider.removeImage();
                              },
                              child: Text(
                                "Remove image".tr(context),
                                style: const TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        )
                      ],
                      const SizedBox(height: 35),
                      CustomTextFiled(
                        controller: provider.nameCompanyController,
                        focusNode: provider.nameCompanyFocusNode,
                        title: "name Company".tr(context),
                        textInputType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (p0) {
                          FocusScope.of(context)
                              .requestFocus(provider.phoneNumberFocusNode);
                        },
                      ),
                      const SizedBox(height: 15),
                      CustomTextFiled(
                        controller: provider.phoneNumberController,
                        focusNode: provider.phoneNumberFocusNode,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (p0) {
                          FocusScope.of(context)
                              .requestFocus(provider.locationFocusNode);
                        },
                        maxLength: 10,
                        prefix: const Icon(
                          IconlyBold.call,
                          color: AppColor.kSilver,
                        ),
                        title: "Phone number".tr(context),
                        textInputType: TextInputType.number,
                      ),
                      const SizedBox(height: 15),
                      CustomTextFiled(
                        controller: provider.locationController,
                        focusNode: provider.locationFocusNode,
                        textInputAction: TextInputAction.done,
                        prefix: const Icon(
                          IconlyBold.location,
                          color: AppColor.kSilver,
                        ),
                        title: "Location".tr(context),
                        textInputType: TextInputType.streetAddress,
                      ),
                      const SizedBox(height: 45),
                      CustomButton(
                        title: "Edit".tr(context),
                        onPressed: () async {
                          await provider.updateProfile(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
