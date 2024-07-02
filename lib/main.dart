import 'package:car_vendor/core/utils/theme.dart';
import 'package:car_vendor/features/auth/presentation/view/forget_password_view.dart';
import 'package:car_vendor/features/auth/presentation/view/login_view.dart';
import 'package:car_vendor/features/auth/presentation/view/sign_up_view.dart';
import 'package:car_vendor/features/lang/app_localization.dart';
import 'package:car_vendor/features/lang/cubit/locale_cubit.dart';
import 'package:car_vendor/features/splash/presentation/view/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    // DeviceOrientation.portraitDown,
  ]);
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
  const CarVendor({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
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
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
