import 'dart:io';

import 'package:car_vendor/core/api/firebase_analytics.dart';
import 'package:car_vendor/core/utils/app_image.dart';
import 'package:car_vendor/core/widgets/alert_dialog.dart';
import 'package:car_vendor/features/auth/presentation/manger/provider/user_provider.dart';
import 'package:car_vendor/features/lang/app_localization.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class EditProfileProvider with ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  late TextEditingController nameCompanyController;
  late TextEditingController phoneNumberController;
  late TextEditingController locationController;
  late FocusNode nameCompanyFocusNode;
  late FocusNode phoneNumberFocusNode;
  late FocusNode locationFocusNode;
  XFile? image;
  String? imageUrl;
  String? productImageUrl;

  EditProfileProvider(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    productImageUrl = userProvider.userModel?.image ?? '';
    // image = userProvider?.userModel?.image ?? ;
    nameCompanyController =
        TextEditingController(text: userProvider.userModel?.vendorName);
    phoneNumberController =
        TextEditingController(text: userProvider.userModel?.phoneNumber);
    locationController = TextEditingController(
      text: userProvider.userModel?.location,
    );
    nameCompanyFocusNode = FocusNode();
    phoneNumberFocusNode = FocusNode();
    locationFocusNode = FocusNode();
  }
  void pickImages() async {
    final ImagePicker picker = ImagePicker();
    image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      productImageUrl = null;
    }
    notifyListeners();
  }

  Future<void> updateProfile(BuildContext context) async {
    final isValid = formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      try {
        if (image == null && productImageUrl == null) {
          AlertDialogMethods.showError(
            context: context,
            titleBottom: 'Ok',
            subtitle: "Please select image".tr(context),
            lottileAnimation: Assets.imagesErrorMas,
            function: () {
              Navigator.of(context).pop();
            },
          );
          return;
        }
        if (nameCompanyController.text.isEmpty ||
            phoneNumberController.text.isEmpty ||
            locationController.text.isEmpty) {
          AlertDialogMethods.showError(
            context: context,
            titleBottom: 'Ok',
            subtitle: "Please fill all fields".tr(context),
            lottileAnimation: Assets.imagesErrorMas,
            function: () {
              Navigator.of(context).pop();
            },
          );
          return;
        }
        _isLoading = true;
        notifyListeners();
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        // final userid = userProvider.userModel?.vendorId;
        if (image != null) {
          final ref = FirebaseStorage.instance
              .ref()
              .child("vendorsImages")
              .child(
                  "image_${nameCompanyController.text}${const Uuid().v4()}.jpg");
          await ref.putFile(File(image!.path));
          imageUrl = await ref.getDownloadURL();
        }

        await FirebaseFirestore.instance
            .collection("vendors")
            .doc(userProvider.userModel!.vendorId)
            .update({
          "vendorName": nameCompanyController.text,
          "phoneNumber": phoneNumberController.text,
          "location": locationController.text,
          "image": imageUrl ?? productImageUrl,
        });
        if (!context.mounted) return;
        Fluttertoast.showToast(
          msg: "Profile updated successfully".tr(context),
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 25,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        Future.delayed(const Duration(seconds: 1), () {
          Navigator.of(context).pop();
        });
        final analyticsService =
            Provider.of<AnalyticsService>(context, listen: false);
        analyticsService.logEvent(
          eventName: 'edit_profile_vendors',
          parameters: {
            'app_type': 'vendors',
            'screen_name': 'edit_profile_vendors',
          },
        );
        // notifyListeners();
      } on FirebaseException catch (e) {
        if (!context.mounted) return;
        AlertDialogMethods.showError(
          context: context,
          titleBottom: 'Ok',
          subtitle: "Error updating profile: $e",
          lottileAnimation: Assets.imagesErrorMas,
          function: () {
            Navigator.of(context).pop();
          },
        );
      } catch (e) {
        if (!context.mounted) return;
        AlertDialogMethods.showError(
          context: context,
          titleBottom: 'Ok',
          subtitle: "Error updating profile: $e",
          lottileAnimation: Assets.imagesErrorMas,
          function: () {
            Navigator.of(context).pop();
          },
        );
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  void removeImage() {
    image = null;
    productImageUrl = null;

    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
