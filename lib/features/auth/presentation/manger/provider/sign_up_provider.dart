import 'dart:io';
import 'package:car_vendor/core/utils/app_image.dart';
import 'package:car_vendor/core/widgets/alert_dialog.dart';
import 'package:car_vendor/features/lang/app_localization.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class SignUpProvider with ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  bool obscureText = true;
  bool obscureTextConfirm = true;
  bool _isLoading = false;
  String? companyType;

  bool get isLoading => _isLoading;

  late TextEditingController nameCompanyController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController phoneNumberController;

  late FocusNode nameCompanyFocusNode;
  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;
  late FocusNode confirmPasswordFocusNode;
  late FocusNode phoneNumberFocusNode;
  final authFirebase = FirebaseAuth.instance;

  SignUpProvider() {
    nameCompanyController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    phoneNumberController = TextEditingController();

    nameCompanyFocusNode = FocusNode();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    confirmPasswordFocusNode = FocusNode();
    phoneNumberFocusNode = FocusNode();
  }
  Future<void> signUpFun(BuildContext context) async {
    final isValid = formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (companyType == null || companyType!.isEmpty) {
      AlertDialogMethods.showError(
        context: context,
        titleBottom: 'Ok',
        subtitle: "Please select company type".tr(context),
        lottileAnimation: Assets.imagesErrorMas,
        function: () {
          Navigator.of(context).pop();
        },
      );
      return;
    } else if (image == null) {
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

    if (isValid) {
      formKey.currentState!.save();
      try {
        setLoading(true);

        final auth = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        User? user = authFirebase.currentUser;
        final uid = user!.uid;
        final ref = FirebaseStorage.instance
            .ref()
            .child("vendorsImages")
            .child("${nameCompanyController.text.trim()}.jpg");
        await ref.putFile(File(image!.path));
        final vendorImageUrl = await ref.getDownloadURL();

        // final vendorId = const Uuid().v4();
        await FirebaseFirestore.instance.collection("vendors").doc(uid).set({
          "vendorId": uid,
          "vendorName": nameCompanyController.text.trim(),
          "vendorEmail": emailController.text.trim(),
          "image": vendorImageUrl,
          "phoneNumber": phoneNumberController.text.trim(),
          "companyType": companyType,
          "products": [],
          "myOrders": [],
          "location": "",
          "createdAt": Timestamp.now(),
        });
        if (!context.mounted) return;
        Fluttertoast.showToast(
          msg: "An account has been created".tr(context),
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.white,
        );
        if (!context.mounted) return;
        AlertDialogMethods.showDialogForgotPassword(
          context: context,
          subtitle:
              'Please confirm your email! Please check your email!'.tr(context),
          // isError: false,
          titleBottom: 'Cancel'.tr(context),
          lottileAnimation: Assets.imagesSendEmailCar,
          function: () {
            Navigator.of(context).pop();
          },
        );
        FirebaseAuth.instance.setLanguageCode("ar");
        FirebaseAuth.instance.currentUser!.sendEmailVerification();
      } on FirebaseAuthException catch (error) {
        if (error.code == "weak-password") {
          AlertDialogMethods.showError(
            context: context,
            subtitle: "The password provided is too weak.".tr(context),
            titleBottom: "Ok",
            lottileAnimation: Assets.imagesErrorMas,
            function: () {
              Navigator.of(context).pop();
            },
          );
        } else if (error.code == "email-already-in-use") {
          AlertDialogMethods.showError(
            context: context,
            subtitle: "The account already exists for that email.".tr(context),
            titleBottom: "Ok",
            lottileAnimation: Assets.imagesErrorMas,
            function: () {
              Navigator.of(context).pop();
            },
          );
        }
      } catch (error) {
        AlertDialogMethods.showError(
          context: context,
          subtitle: "An error has been occured".tr(context),
          titleBottom: "Ok",
          lottileAnimation: Assets.imagesErrorMas,
          function: () {
            Navigator.of(context).pop();
          },
        );
      } finally {
        setLoading(false);
      }
    }
  }

  void changeObscureText() {
    obscureText = !obscureText;
    notifyListeners();
  }

  void changeObscureTextConfirm() {
    obscureTextConfirm = !obscureTextConfirm;
    notifyListeners();
  }

  @override
  void dispose() {
    nameCompanyController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneNumberController.dispose();

    nameCompanyFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    phoneNumberFocusNode.dispose();

    super.dispose();
  }

  XFile? image;

  Future<void> pickImage(BuildContext context) async {
    try {
      // استخدام await للحصول على النتيجة
      final XFile? result =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (result != null) {
        image = result;
        notifyListeners();
      }
    } catch (e) {
      if (!context.mounted) return;
      AlertDialogMethods.showError(
        context: context,
        titleBottom: 'Ok',
        subtitle: "Error picking image: $e",
        lottileAnimation: Assets.imagesErrorMas,
        function: () {
          Navigator.of(context).pop();
        },
      );
      // print("Error picking image: $e");
    }
  }

  void removeImage() {
    image = null;
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
