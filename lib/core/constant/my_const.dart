import 'package:car_vendor/features/lang/app_localization.dart';
import 'package:flutter/material.dart';

class AppConstants {
  static List<String> brandList = [
    "Acura",
    "Alfa Romeo",
    "Aston Martin",
    "Audi",
    "Bentley",
    "BMW",
    "Bugatti",
    "Cadillac",
    "Chevrolet",
    "Chrysler",
    "Dodge",
    "Ferrari",
    "Fiat",
    "Ford",
    "Honda",
    "Hyundai",
    "Jaguar",
    "Jeep",
    "Kia",
    "Lamborghini",
    "Land Rover",
    "Lexus",
    "Maserati",
    "Mazda",
    "Mercedes-Benz",
    "Mitsubishi",
    "Nissan",
    "Porsche",
    "Rolls-Royce",
    "Subaru",
    "Suzuki",
    "Tesla",
    "Toyota",
    "Volkswagen",
    "Volvo",
  ];

  static List<DropdownMenuItem<String>> brandDropDownList(
      BuildContext context) {
    List<DropdownMenuItem<String>> menuItem =
        List<DropdownMenuItem<String>>.generate(
      brandList.length,
      (index) => DropdownMenuItem(
        value: brandList[index].tr(context),
        child: Text(
          brandList[index].tr(context),
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
