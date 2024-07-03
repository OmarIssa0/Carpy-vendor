import 'dart:io';

import 'package:car_vendor/core/utils/app_image.dart';
import 'package:car_vendor/core/utils/app_styles.dart';
import 'package:car_vendor/features/lang/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';

class UploadImageButton extends StatefulWidget {
  const UploadImageButton({
    super.key,
  });

  @override
  State<UploadImageButton> createState() => _UploadImageButtonState();
}

class _UploadImageButtonState extends State<UploadImageButton> {
  List<XFile> selectedImages = [];
  Future<void> pickImages() async {
    List<XFile>? result = await ImagePicker().pickMultiImage();
    selectedImages = result;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        selectedImages.isEmpty
            ? const SizedBox()
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Align(
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            selectedImages.clear();
                          });
                        },
                        icon: const Icon(
                          IconlyBold.delete,
                          color: Colors.red,
                        ),
                      ),
                      Row(
                        children: List.generate(
                          selectedImages.length,
                          (index) => Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 8.0),
                            child: Image.file(
                              File(selectedImages[index].path),
                              height: 150,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        const SizedBox(height: 15),
        InkWell(
          onTap: () {
            pickImages();
          },
          child: Container(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 12),
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              // color: AppColor.kGrayColor.withOpacity(.2),
              color: Colors.grey.shade300,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(Assets.imagesUploadImage, height: 45),
                Text("Upload Image".tr(context), style: AppStyles.semiBold16),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
