import 'package:car_vendor/features/lang/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:popover/popover.dart';

class ItemPopover extends StatelessWidget {
  const ItemPopover({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return IconButton(
        icon: const Icon(Icons.more_vert_rounded),
        onPressed: () {
          showPopover(
            // height: 150,
            // width: 250,
            context: context,
            bodyBuilder: (context) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () async {
                      // _showSheet(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 55, vertical: 25),
                      child: Text(
                        'Edit item'.tr(context),
                        style: const TextStyle(fontSize: 11),
                      ),
                    ),
                  ),
                  Container(
                    width: 145,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade50)),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 25),
                      child: Text(
                        'Delete item'.tr(context),
                        style: const TextStyle(fontSize: 11, color: Colors.red),
                      ),
                    ),
                  )
                ],
              );
            },
          );
        },
      );
    });
  }
}
