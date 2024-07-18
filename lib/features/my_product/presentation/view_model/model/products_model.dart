import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductsModel extends ChangeNotifier {
  final String nameProduct,
      priceProduct,
      descriptionProduct,
      phoneNumberVendor,
      companyName,
      modelProduct,
      categoryProduct,
      productsId,
      imageCompany,
      userId;
  final String? locationVendor, discount;
  List<dynamic> imagesProduct;
  // List<dynamic> productsVendor;
  bool isSwitchReservation = false;
  // Timestamp? createdAt;

  ProductsModel({
    required this.productsId,
    required this.userId,
    required this.imageCompany,
    required this.nameProduct,
    required this.priceProduct,
    required this.descriptionProduct,
    required this.phoneNumberVendor,
    required this.companyName,
    required this.modelProduct,
    required this.categoryProduct,
    required this.imagesProduct,
    // required this.productsVendor,
    required this.isSwitchReservation,
    this.locationVendor,
    this.discount,
  });

  factory ProductsModel.fromFirebase(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return ProductsModel(
      productsId: data['productId'],
      userId: data['userId'],
      imageCompany: data['imageCompany'],
      nameProduct: data['productTitle'],
      priceProduct: data['productPrice'],
      descriptionProduct: data['productDescription'],
      phoneNumberVendor: data['phoneNumber'],
      companyName: data['companyName'],
      modelProduct: data['model'],
      categoryProduct: data['productCategory'],
      imagesProduct: data['productImage'],
      isSwitchReservation: data['isSwitchReservation'],
      locationVendor: data['location'],
      discount: data['discount'],
    );
  }
  // factory ProductsModel.fromFirebase(DocumentSnapshot doc) {
  //   Map data = doc.data() as Map<String, dynamic>;
  //   return ProductsModel(
  //     productsId: productsId,
  //     userId: userId,
  //     imageCompany: imageCompany,
  //     nameProduct: nameProduct,
  //     priceProduct: priceProduct,
  //     descriptionProduct: descriptionProduct,
  //     phoneNumberVendor: phoneNumberVendor,
  //     companyName: companyName,
  //     modelProduct: modelProduct,
  //     categoryProduct: categoryProduct,
  //     imagesProduct: imagesProduct,
  //     isSwitchReservation: isSwitchReservation,
  //   );
  // }
}
