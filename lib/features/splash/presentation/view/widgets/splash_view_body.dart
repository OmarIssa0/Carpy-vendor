import 'package:car_vendor/core/utils/animation_nav.dart';
import 'package:car_vendor/core/utils/app_image.dart';
import 'package:car_vendor/features/auth/presentation/view/login_view.dart';
import 'package:car_vendor/root_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    excuteNavigation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Image.asset(
      Assets.imagesIconSplashView2,
      height: 150,
      fit: BoxFit.scaleDown,
    ));
  }

  void excuteNavigation() {
    Future.delayed(const Duration(seconds: 3), () {
      FirebaseAuth.instance.currentUser != null &&
              FirebaseAuth.instance.currentUser!.emailVerified
          ? Navigator.pushReplacement(
              context, AnimationNav.navigatorAnimation(child: const RootView()))
          : Navigator.pushReplacement(context,
              AnimationNav.navigatorAnimation(child: const LoginView()));
      // Navigator.pushReplacementNamed(context, LoginView.routeName);
      // Navigator.pushReplacement(
      //     context, AnimationNav.navigatorAnimation(child: const LoginView()));
    });
  }
}
