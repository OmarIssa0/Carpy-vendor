import 'dart:developer';

import 'package:car_vendor/core/utils/app_color.dart';
import 'package:car_vendor/features/auth/presentation/manger/provider/user_provider.dart';
import 'package:car_vendor/features/home/presentation/view/home_view.dart';
import 'package:car_vendor/features/lang/app_localization.dart';
import 'package:car_vendor/features/my_product/presentation/view/my_product_view.dart';
import 'package:car_vendor/features/my_product/presentation/view_model/provider/my_products_provider.dart';
import 'package:car_vendor/features/profile/presentation/view/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class RootView extends StatefulWidget {
  static String routeName = '/RootView';
  const RootView({super.key});

  @override
  State<RootView> createState() => _RootViewState();
}

class _RootViewState extends State<RootView> {
  bool isLoading = true;
  late PageController _controller;
  int currentScreen = 0;

  List<Widget> view = [
    const HomeView(),
    const MyProductView(),
    const ProfileView(),
  ];

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: currentScreen);
  }

  Future<void> fetchData() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final myProducts =
        Provider.of<VendorProductsProvider>(context, listen: false);
    try {
      Future.wait({
        userProvider.getUser(),
        myProducts.fetchMyProducts(),
      });
    } catch (e) {
      log(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void didChangeDependencies() {
    if (isLoading) {
      fetchData();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        // physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (value) {
          setState(() {
            currentScreen = value;
          });
        },
        children: view,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentScreen,
        onDestinationSelected: (value) {
          setState(() {
            // currentScreen = value;
          });
          _controller.animateToPage(value,
              duration: const Duration(milliseconds: 500), curve: Curves.ease);
        },
        indicatorColor: Theme.of(context).scaffoldBackgroundColor,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        // backgroundColor: AppColor.kWhite,
        elevation: 0,
        destinations: [
          NavigationDestination(
            enabled: true,
            icon: const Icon(IconlyLight.home),
            label: 'Home'.tr(context),
            selectedIcon: const Icon(IconlyBold.home,
                color: AppColor.kBackGroundColorSplash),
          ),
          NavigationDestination(
            icon: const Icon(IconlyLight.bag),
            label: 'My Products'.tr(context),
            selectedIcon: const Icon(IconlyBold.bag,
                color: AppColor.kBackGroundColorSplash),
          ),
          NavigationDestination(
            icon: const Icon(IconlyLight.profile),
            label: 'My Profile'.tr(context),
            selectedIcon: const Icon(IconlyBold.profile,
                color: AppColor.kBackGroundColorSplash),
          ),
        ],
      ),
    );
  }
}
