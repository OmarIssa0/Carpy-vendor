import 'package:car_vendor/core/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: MediaQuery.sizeOf(context).width < SizeConfig.tablet
            ? const EdgeInsetsDirectional.only(start: 24, end: 24)
            : EdgeInsetsDirectional.only(
                start: MediaQuery.sizeOf(context).width / 6,
                end: MediaQuery.sizeOf(context).width / 6,
              ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [],
        ),
      ),
    );
  }
}
