import 'package:car_vendor/core/cache/cache_helper.dart';
import 'package:car_vendor/core/service/service_locator.dart';
import 'package:car_vendor/core/utils/theme.dart';
import 'package:car_vendor/features/add_product/presentation/view/add_products_view.dart';
import 'package:car_vendor/features/add_product/presentation/view/market_view.dart';
import 'package:car_vendor/features/add_product/presentation/view_model/provider/add_products.dart';
import 'package:car_vendor/features/auth/presentation/manger/provider/user_provider.dart';
import 'package:car_vendor/features/auth/presentation/view/forget_password_view.dart';
import 'package:car_vendor/features/auth/presentation/view/login_view.dart';
import 'package:car_vendor/features/auth/presentation/view/sign_up_view.dart';
import 'package:car_vendor/features/home/presentation/view/home_view.dart';
import 'package:car_vendor/features/lang/app_localization.dart';
import 'package:car_vendor/features/lang/cubit/locale_cubit.dart';
import 'package:car_vendor/features/my_product/presentation/view/my_product_view.dart';
import 'package:car_vendor/features/my_product/presentation/view_model/model/products_model.dart';
import 'package:car_vendor/features/my_product/presentation/view_model/provider/my_products_provider.dart';
import 'package:car_vendor/features/my_product/presentation/view_model/provider/product_provider.dart';
import 'package:car_vendor/features/profile/presentation/view/profile_view.dart';
import 'package:car_vendor/features/settings/presentation/view/settings_view.dart';
import 'package:car_vendor/features/splash/presentation/view/splash_view.dart';
import 'package:car_vendor/firebase_options.dart';
import 'package:car_vendor/root_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    // DeviceOrientation.portraitDown,
  ]);
  // WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  await getIt<CacheHelper>().init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LocaleCubit()..getSavedLanguage(),
        ),
      ],
      child: const CarVendor(),
    ),
  );
}

class CarVendor extends StatelessWidget {
  const CarVendor({super.key, this.productsModel});
  final ProductsModel? productsModel;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => NEWProductProvider()),
        ChangeNotifierProvider(create: (_) => VendorProductsProvider()),
      ],
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        child: BlocBuilder<LocaleCubit, LocaleState>(
          builder: (context, state) {
            if (state is ChangeLocaleState) {
              return MaterialApp(
                locale: state.locale,
                supportedLocales: const [Locale('en'), Locale('ar')],
                localizationsDelegates: const [
                  AppLocalization.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate
                ],
                theme: Styles.themeData(
                  context: context,
                  fontFamily:
                      state.locale.languageCode == 'en' ? 'Poppins' : "Cairo",
                ),
                debugShowCheckedModeBanner: false,
                initialRoute: SplashView.routeName,
                routes: {
                  SplashView.routeName: (context) => const SplashView(),
                  LoginView.routeName: (context) => const LoginView(),
                  SignUpView.routeName: (context) => const SignUpView(),
                  ForgetPasswordView.routeName: (context) =>
                      const ForgetPasswordView(),
                  RootView.routeName: (context) => const RootView(),
                  HomeView.routeName: (context) => const HomeView(),
                  SettingsView.routeName: (context) => const SettingsView(),
                  AddProductsView.routeName: (context) =>
                      const AddProductsView(),
                  MarkerView.routeName: (context) => const MarkerView(),
                  ProfileView.routeName: (context) => const ProfileView(),
                  MyProductView.routeName: (context) => const MyProductView(),
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
