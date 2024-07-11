import 'package:car_vendor/core/utils/app_styles.dart';
import 'package:car_vendor/features/lang/app_localization.dart';
import 'package:car_vendor/features/my_product/presentation/view_model/model/products_model.dart';
import 'package:flutter/material.dart';

class SwitchReservation extends StatefulWidget {
  final ProductsModel? productModel;

  const SwitchReservation({super.key, this.productModel});

  @override
  State<SwitchReservation> createState() => _SwitchReservationState();
}

class _SwitchReservationState extends State<SwitchReservation> {
  bool isReservation = false;

  @override
  void initState() {
    super.initState();
    // Initialize isReservation with the value from productModel if available
    if (widget.productModel != null) {
      isReservation = widget.productModel!.isSwitchReservation;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          'Add a reservation'.tr(context),
          style: AppStyles.semiBold16,
        ),
        Switch(
          activeTrackColor: Colors.green,
          inactiveThumbColor: Colors.white,
          inactiveTrackColor: Colors.red,
          value: isReservation,
          onChanged: (value) {
            setState(() {
              isReservation = value;
              if (widget.productModel != null) {
                widget.productModel!.isSwitchReservation = value;
              }
            });
          },
        ),
      ],
    );
  }
}
