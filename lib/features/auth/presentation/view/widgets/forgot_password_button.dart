import 'package:car_vendor/core/utils/app_color.dart';
import 'package:flutter/material.dart';

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({super.key, required this.child, this.onPressed});

  final Widget child;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: AppColor.kBackGroundColorSplash),
        child: child,
        onPressed: () {
          onPressed!();
        },
      ),
    );
  }
}
