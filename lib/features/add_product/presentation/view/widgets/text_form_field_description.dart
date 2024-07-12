import 'package:car_vendor/core/utils/app_color.dart';
import 'package:car_vendor/features/lang/app_localization.dart';
import 'package:flutter/material.dart';

class TextFormFieldDescription extends StatelessWidget {
  const TextFormFieldDescription({
    super.key,
    required this.descriptionController,
    required this.descriptionFocusNode,
    // required this.descriptionController,
  });
  final TextEditingController descriptionController;
  final FocusNode descriptionFocusNode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: descriptionController,
      minLines: 5,
      maxLines: 8,
      maxLength: 1000,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: 'Description'.tr(context),
        hintStyle: const TextStyle(
          color: AppColor.kSilver,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        border: buildBorder(),
        enabledBorder: buildBorder(),
        focusedErrorBorder: buildBorder(),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: AppColor.kSilver.withOpacity(.2),
          ),
        ),
      ),

      // validator: (value) {
      //   return MyValidators.uploadProdTexts(
      //     value: value,
      //     toBeReturnedString: "Description is missed",
      //   );
      // },
      // onTap: () {},
    );
  }
}

OutlineInputBorder buildBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(
      color: AppColor.kSilver.withOpacity(.2),
    ),
  );
}
