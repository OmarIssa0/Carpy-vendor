import 'package:car_vendor/features/lang/app_localization.dart';
import 'package:flutter/material.dart';

class AppConstants {
  static List<String> userType = ["market", "freelancer"];
  static List<String> brandList = [
    "Acura - أكورا",
    "Alfa Romeo - ألفا روميو",
    "Aston Martin - أستون مارتن",
    "Audi - أودي",
    "Bentley - بنتلي",
    "BMW - بي إم دبليو",
    "Bugatti - بوغاتي",
    "Cadillac - كاديلاك",
    "Changan - شانجان",
    "Chevrolet - شيفروليه",
    "Chrysler - كرايسلر",
    "Dodge - دودج",
    "Ferrari - فيراري",
    "Fiat - فيات",
    "Ford - فورد",
    "Geely - جيلي",
    "Great Wall - جريت وول",
    "Honda - هوندا",
    "Hyundai - هيونداي",
    "Jaguar - جاكوار",
    "Jeep - جيب",
    "Kia - كيا",
    "Lamborghini - لامبورغيني",
    "Land Rover - لاند روفر",
    "Lexus - لكزس",
    "Maserati - مازيراتي",
    "Mazda - مازدا",
    "Mercedes-Benz - مرسيدس بنز",
    "Mitsubishi - ميتسوبيشي",
    "Nissan - نيسان",
    "Peugeot - بيجو",
    "Porsche - بورش",
    "Renault - رينو",
    "Rolls-Royce - رولز رويس",
    "Saab - ساب",
    "Seat - سيات",
    "Skoda - سكودا",
    "Subaru - سوبارو",
    "Suzuki - سوزوكي",
    "Tesla - تسلا",
    "Toyota - تويوتا",
    "Volkswagen - فولكس واجن",
    "Volvo - فولفو",
  ];
  static List<String> categoryList = [
    // "قطع غيار",
    // "اكسسوارات وتعديلات",
    // "إطارات وعجلات",
    // "زيوت وسوائل",
    // "معدات الصيانة والتنظيف",
    // "أنظمة الأمان",
    // "التجهيزات الخارجية",
    // "استئجار المركبات",
    "اكسسوارات",
    "قطع غيار",
    "استئجار المركبات",
    "مركبات للبيع",
    "تعبئة على الطريق",
    "زيوت وسوائل",
    "تنظيف المركبات"
    // "",
  ];

  static List<DropdownMenuItem<String>> brandDropDownList() {
    List<DropdownMenuItem<String>> menuItem =
        List<DropdownMenuItem<String>>.generate(
      brandList.length,
      (index) => DropdownMenuItem(
        value: brandList[index],
        child: Text(
          brandList[index],
        ),
      ),
    );
    return menuItem;
  }

  static List<DropdownMenuItem<String>> categoryDropDownList() {
    List<DropdownMenuItem<String>> menuItem =
        List<DropdownMenuItem<String>>.generate(
      categoryList.length,
      (index) => DropdownMenuItem(
        value: categoryList[index],
        child: Text(
          categoryList[index],
        ),
      ),
    );
    return menuItem;
  }

  static List<DropdownMenuItem<String>> userInfoType(BuildContext context) {
    List<DropdownMenuItem<String>> menuItem =
        List<DropdownMenuItem<String>>.generate(
      userType.length,
      (index) => DropdownMenuItem(
        value: userType[index].tr(context),
        child: Text(
          userType[index].tr(context),
        ),
      ),
    );
    return menuItem;
  }
}

class YearProvider {
  List<int> getYears() {
    List<int> years = [];
    int currentYear = DateTime.now().year;

    for (int year = 1950; year <= currentYear; year++) {
      years.add(year);
    }

    return years;
  }

  static List<DropdownMenuItem<String>>? get yearDropDownList {
    // YearProvider yearProvider = YearProvider();
    List<int> years = YearProvider().getYears();
    List<DropdownMenuItem<String>> menuItem =
        List<DropdownMenuItem<String>>.generate(
      years.length,
      (index) => DropdownMenuItem(
        value: years[index].toString(),
        child: Text(
          years[index].toString(),
        ),
      ),
    );

    return menuItem.reversed.toList();
  }
}
