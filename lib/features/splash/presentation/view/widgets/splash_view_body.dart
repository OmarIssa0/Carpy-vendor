import 'dart:developer';

import 'package:car_vendor/core/utils/animation_nav.dart';
import 'package:car_vendor/core/utils/app_image.dart';
import 'package:car_vendor/features/auth/presentation/manger/provider/user_provider.dart';
import 'package:car_vendor/features/auth/presentation/view/login_view.dart';
import 'package:car_vendor/features/my_product/presentation/view_model/provider/my_products_provider.dart';
import 'package:car_vendor/root_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  @override
  void initState() {
    excuteNavigation();
    super.initState();
  }
  // bool isLoading = true;

  // Future<void> fetchData() async {
  //   final userProvider = Provider.of<UserProvider>(context, listen: false);
  //   final myProducts =
  //       Provider.of<VendorProductsProvider>(context, listen: false);
  //   try {
  //     Future.wait({
  //       userProvider.getUser(),
  //       myProducts.fetchMyProducts(),
  //     });
  //   } catch (e) {
  //     log(e.toString());
  //   } finally {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

  // @override
  // void didChangeDependencies() {
  //   if (isLoading) {
  //     fetchData();
  //   }
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Image.asset(
      Assets.imagesSplachImage,
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
