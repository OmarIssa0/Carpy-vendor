import 'package:car_vendor/core/utils/size_config.dart';
import 'package:car_vendor/core/widgets/drop_down_button.dart';
import 'package:flutter/material.dart';

class SettingsViewBody extends StatelessWidget {
  const SettingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.sizeOf(context).width < SizeConfig.tablet
          ? const EdgeInsetsDirectional.symmetric(horizontal: 12)
          : EdgeInsetsDirectional.only(
              start: MediaQuery.sizeOf(context).width / 6,
              end: MediaQuery.sizeOf(context).width / 6,
            ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropDownButtonLocal(),
        ],
      ),
    );
  }
}
