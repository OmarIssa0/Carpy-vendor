import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserModel with ChangeNotifier {
  final String vendorName,
      vendorId,
      vendorEmail,
      phoneNumber,
      location,
      image,
      companyType;
  final Timestamp createdAt;
  final List products;

  UserModel({
    required this.vendorName,
    required this.vendorId,
    required this.vendorEmail,
    required this.phoneNumber,
    required this.location,
    required this.image,
    required this.companyType,
    required this.createdAt,
    required this.products,
  });
}
