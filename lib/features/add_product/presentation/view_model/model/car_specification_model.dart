import 'package:flutter/material.dart';

class CarFeature with ChangeNotifier {
  final String name;
  bool isSelected;

  CarFeature({required this.name, this.isSelected = false});
}
