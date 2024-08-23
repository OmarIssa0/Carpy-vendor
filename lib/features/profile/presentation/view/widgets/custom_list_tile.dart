import 'package:car_vendor/core/utils/app_styles.dart';
import 'package:car_vendor/features/lang/app_localization.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {super.key,
      required this.iconLeading,
      required this.iconTrailing,
      required this.title,
      required this.function,
      this.iconColor});

  final IconData iconLeading;
  final Widget iconTrailing;
  final String title;
  final Function function;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        function();
      },
      child: ListTile(
          leading: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade200,
            ),
            child: Icon(
              //
              iconLeading,
              size: 28, color: iconColor,
            ),
          ),
          title: Text(
            title.tr(context),
            style: AppStyles.regular16,
          ),
          trailing: iconTrailing),
    );
  }
}
