import 'dart:io';

import 'package:car_vendor/core/utils/app_image.dart';
import 'package:car_vendor/core/utils/app_styles.dart';
import 'package:car_vendor/features/lang/app_localization.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadImageButton extends StatefulWidget {
  const UploadImageButton({
    super.key,
    required this.selectedImages,
    required this.productNetworkImages,
    this.onTap,
  });
  final List<XFile> selectedImages;
  final List productNetworkImages;
  final void Function()? onTap;
  @override
  State<UploadImageButton> createState() => _UploadImageButtonState();
}

class _UploadImageButtonState extends State<UploadImageButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.selectedImages.isEmpty && widget.productNetworkImages.isEmpty
            ? const SizedBox()
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Align(
                  child: Row(
                    children: [
                      Row(
                        children: List.generate(
                          widget.productNetworkImages.isNotEmpty
                              ? widget.productNetworkImages.length
                              : widget.selectedImages.length,
                          (index) => Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 8.0),
                            child: widget.productNetworkImages.isEmpty
                                ? Image.file(
                                    File(widget.selectedImages[index].path),
                                    height: 150,
                                  )
                                : FancyShimmerImage(
                                    imageUrl:
                                        widget.productNetworkImages[index],
                                    height: 150,
                                    boxFit: BoxFit.contain,
                                    errorWidget: const Icon(Icons.error),
                                    // width: 75,
                                    // child: Image.network(
                                    //     height: 150,
                                    //   ),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        const SizedBox(height: 15),
        widget.productNetworkImages.isNotEmpty
            ? const SizedBox.shrink()
            : InkWell(
                onTap: () {
                  widget.onTap!();
                  // widget.productNetworkImages.clear();
                  // widget.productNetworkImages.clear();
                  setState(() {});
                },
                child: Container(
                  
                  padding:
                      const EdgeInsetsDirectional.symmetric(horizontal: 12),
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    // color: AppColor.kGrayColor.withOpacity(.2),
                    color: Colors.grey.shade300,
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(Assets.imagesUploadImage, height: 45),
                        Text("Upload Image".tr(context),
                            style: AppStyles.semiBold16),
                      ],
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
