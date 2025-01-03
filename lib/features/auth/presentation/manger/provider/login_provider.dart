import 'package:car_vendor/core/api/firebase_analytics.dart';
import 'package:car_vendor/core/utils/app_image.dart';
import 'package:car_vendor/core/widgets/alert_dialog.dart';
import 'package:car_vendor/features/lang/app_localization.dart';
import 'package:car_vendor/root_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class LoginProvider with ChangeNotifier {
  // Controllers
  late TextEditingController emailTextController;
  late TextEditingController passwordTextController;

  // Focus nodes
  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;

  // Form key
  final formKey = GlobalKey<FormState>();

  // State variables
  bool obscureText = true;
  bool _isLoading = false;
  void changeObscureText() {
    obscureText = !obscureText;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  LoginProvider() {
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> loginFun(BuildContext context) async {
    final isValid = formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      formKey.currentState!.save();

      try {
        _setLoading(true);

        final auth = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailTextController.text.trim(),
          password: passwordTextController.text.trim(),
        );
        final analyticsService =
            Provider.of<AnalyticsService>(context, listen: false);
        if (auth.user!.emailVerified) {
          if (!context.mounted) return;
          Fluttertoast.showToast(
            msg: "Login Successful".tr(context),
            toastLength: Toast.LENGTH_SHORT,
            textColor: Colors.white,
          );
          if (!context.mounted) return;
          await Navigator.of(context)
              .pushNamedAndRemoveUntil(RootView.routeName, (route) => false);
          analyticsService.logEvent(
            eventName: 'login_vendors',
            parameters: {
              'app_type': 'vendors',
              'screen_name': 'login_vendors',
            },
          );
        } else {
          if (!context.mounted) return;
          AlertDialogMethods.showDialogForgotPassword(
            context: context,
            subtitle: "Please confirm your email! Please check your email!"
                .tr(context),
            titleBottom: 'Cancel'.tr(context),
            lottileAnimation: Assets.imagesSendEmailCar,
            function: () {},
          );
        }
      } on FirebaseAuthException catch (e) {
        if (!context.mounted) return;
        _handleAuthException(context, e);
      } catch (error) {
        if (!context.mounted) return;
        AlertDialogMethods.showError(
          context: context,
          subtitle: "An error has occurred: $error",
          titleBottom: "Ok",
          lottileAnimation: Assets.imagesErrorMas,
          function: () {
            Navigator.of(context).pop();
          },
        );
      } finally {
        _setLoading(false);
      }
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _handleAuthException(BuildContext context, FirebaseAuthException e) {
    String subtitle;
    if (e.code == 'user-not-found') {
      subtitle = "No user found for that email.".tr(context);
    } else if (e.code == 'wrong-password') {
      subtitle = "Wrong password provided for that user.".tr(context);
    } else {
      subtitle = e.message ?? "An unknown error occurred.".tr(context);
    }

    AlertDialogMethods.showError(
      context: context,
      subtitle: subtitle,
      titleBottom: "Ok",
      lottileAnimation: Assets.imagesErrorMas,
      function: () {
        Navigator.of(context).pop();
      },
    );
  }
}
