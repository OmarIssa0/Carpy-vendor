import 'package:car_vendor/features/my_product/presentation/view_model/model/products_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VendorProductsProvider with ChangeNotifier {
  final Map<String, ProductsModel> _myProducts = {};
  Map<String, ProductsModel> get myProducts => _myProducts;

  // firebase
  final usersDB = FirebaseFirestore.instance.collection("vendors");
  final _auth = FirebaseAuth.instance;
  ProductsModel? findByProductId(String productId) {
    // اذا حصلنا اي منتج داخل ال Map
    if (!_myProducts.containsKey(productId)) {
      return null;
    }
    // العنصر المطلوب
    return _myProducts[productId];
  }

  Future<void> fetchMyProducts() async {
    final User? user = _auth.currentUser;
    if (user == null) return;

    try {
      final userDoc = await usersDB.doc(user.uid).get();
      final data = userDoc.data();
      if (data == null || !data.containsKey('products')) {
        return;
      }

      final products = List<Map<String, dynamic>>.from(data['products']);
      for (var product in products) {
        _myProducts[product['productId']] = ProductsModel(
          productsId: product['productId'],
          userId: product['userId'],
          nameProduct: product['productTitle'],
          priceProduct: product['productPrice'],
          descriptionProduct: product['productDescription'],
          imagesProduct: List<String>.from(product['productImage']),
          locationVendor: product['location'],
          isSwitchReservation: product['isSwitchReservation'],
          discount: product['discount'],
          categoryProduct: product['productCategory'],
          modelProduct: product['model'],
          // createdAt: product['createdAt'],
          imageCompany: product['imageCompany'],
          companyName: product['companyName'],
          phoneNumberVendor: product['phoneNumber'],
        );
      }
      notifyListeners();
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }
  // Stream<List<ProductsModel>> fetchMyProducts() {
  //   final User? user = _auth.currentUser;
  //   if (user == null) return Stream.value([]);

  //   return usersDB.doc(user.uid).snapshots().map((snapshot) {
  //     final data = snapshot.data();
  //     if (data == null || !data.containsKey('products')) {
  //       return [];
  //     }

  //     final products = List<Map<String, dynamic>>.from(data['products']);
  //     return products.map((product) {
  //       return ProductsModel(
  //         productsId: product['productId'],
  //         userId: product['userId'],
  //         nameProduct: product['productTitle'],
  //         priceProduct: product['productPrice'],
  //         descriptionProduct: product['productDescription'],
  //         imagesProduct: List<String>.from(product['productImage']),
  //         locationVendor: product['location'],
  //         isSwitchReservation: product['isSwitchReservation'],
  //         discount: product['discount'],
  //         categoryProduct: product['productCategory'],
  //         modelProduct: product['model'],
  //         imageCompany: product['imageCompany'],
  //         companyName: product['companyName'],
  //         phoneNumberVendor: product['phoneNumber'],
  //       );
  //     }).toList();
  //   });
  // }
}
