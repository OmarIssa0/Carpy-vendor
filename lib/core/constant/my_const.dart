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
    "اكسسوارات",
    "قطع غيار",
    "استئجار المركبات",
    "مركبات للبيع",
    "تعبئة على الطريق",
    "زيوت وسوائل",
    "تنظيف المركبات"
  ];
  static List<String> colorList = [
    'أحمر',
    'أزرق',
    'أسود',
    'أبيض',
    'فضي',
    'رمادي',
    'أخضر',
    'برتقالي',
    'بني',
    'أصفر',
    'أرجواني',
    'زهري',
    'بحري',
    'أزرق فاتح',
    'أخضر فاتح',
    'أحمر داكن',
    'أزرق داكن',
    'برونزي',
    'مشمشي',
    'ذهبي',
    'نيلي',
    'أبيض لؤلؤي',
    'رمادي غامق',
    'أسود معدني',
    'أحمر مشرق',
    'أزرق سماوي',
    'أخضر زيتوني',
    'بيج'
  ];
  static List<String> kilometerList = [
    'صفر',
    'أقل من 10,000 كم',
    '10,000 - 20,000 كم',
    '20,000 - 30,000 كم',
    '30,000 - 40,000 كم',
    '40,000 - 50,000 كم',
    '50,000 - 60,000 كم',
    '60,000 - 70,000 كم',
    '70,000 - 80,000 كم',
    '80,000 - 90,000 كم',
    '90,000 - 100,000 كم',
    '100,000 - 150,000 كم',
    '150,000 - 200,000 كم',
    'أكثر من 200,000 كم',
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

  static List<DropdownMenuItem<String>> kilometerListDropDown() {
    List<DropdownMenuItem<String>> menuItem =
        List<DropdownMenuItem<String>>.generate(
      kilometerList.length,
      (index) => DropdownMenuItem(
        value: kilometerList[index],
        child: Text(
          kilometerList[index],
        ),
      ),
    );
    return menuItem;
  }

  static List<DropdownMenuItem<String>> colorDropDownList() {
    List<DropdownMenuItem<String>> menuItem =
        List<DropdownMenuItem<String>>.generate(
      colorList.length,
      (index) => DropdownMenuItem(
        value: colorList[index],
        child: Text(
          colorList[index],
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
