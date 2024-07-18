// import 'package:car_vendor/features/my_product/presentation/view_model/model/products_model.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:uuid/uuid.dart';

// class MyProductsProvider with ChangeNotifier {
//   final Map<String, MyProductsModel> _myProducts = {};
//   Map<String, MyProductsModel> get myProducts => _myProducts;

//   final userDB = FirebaseFirestore.instance.collection('vendors');
//   final _auth = FirebaseAuth.instance;

//   // Future<void> fetchMyProducts({required String productsId}) async {
//   //   final User? user = _auth.currentUser;
//   //   if (user == null) return;

//   //   final uid = user.uid;
//   //   final vendorId = const Uuid().v4();
//   //   try {
//   //     userDB.doc(uid).update({

//   //     });
//   //   } catch (e) {}
//   // }

//   Future<void> fetchMyProducts() async {
//     final User? user = _auth.currentUser;
//     if (user == null) return;
//     try {
//       final userDoc = await userDB.doc(user.uid).get();
//       final data = userDoc.data();
//       if (data == null || !data.containsKey('products')) {
//         return;
//       }
//       final leng = userDoc.get('products').length;
//       for (int i = 0; i < leng; i++) {
//         _myProducts.putIfAbsent(
//             userDoc.get('products')[i]['productId'],
//             () => MyProductsModel(
//                   myProductsId: userDoc.get('products')[i]['userId'],
//                   productsId: userDoc.get('products')[i]['productsId'],
//                 ));
//       }
//     } catch (e) {
//       rethrow;
//     }

//     notifyListeners();
//   }
// }

// class MyProductsModel with ChangeNotifier {
//   final String productsId;
//   final String myProductsId;

//   MyProductsModel({required this.productsId, required this.myProductsId});
// }

import 'package:car_vendor/features/my_product/presentation/view_model/model/products_model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// class MyProductsProvider with ChangeNotifier {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   List<MyProductModel> _myProducts = [];
//   List<MyProductModel> get myProducts => _myProducts;

//   Future<void> fetchMyProducts() async {
//     final User? user = _auth.currentUser;
//     if (user == null) return;
//     try {
//       final userDoc =
//           await _firestore.collection('vendors').doc(user.uid).get();
//       final data = userDoc.data();
//       if (data == null || !data.containsKey('products')) {
//         return;
//       }
//       final products = List<Map<String, dynamic>>.from(userDoc.get('products'));
//       _myProducts = products.map((productData) {
//         return MyProductModel.fromMap(productData);
//       }).toList();
//     } catch (e) {
//       rethrow;
//     }
//     notifyListeners();
//   }
// }
// class MyProductsProvider with ChangeNotifier {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   final Map<String, MyProductModel> _myProducts = {};
//   Map<String, MyProductModel> get myProducts => _myProducts;

//   Future<void> fetchMyProducts() async {
//     final User? user = _auth.currentUser;
//     if (user == null) return;

//     try {
//       final userDoc =
//           await _firestore.collection('vendors').doc(user.uid).get();
//       final data = userDoc.data();
//       if (data == null || !data.containsKey('products')) {
//         return;
//       }

//       final List<dynamic> products = data['products'];
//       for (var product in products) {
//         final productId = product['productId'];
//         _myProducts[productId] = MyProductModel(
//           productId: productId,
//           productTitle: product['productTitle'],
//           productPrice: product['productPrice'],
//           productDescription: product['productDescription'],
//           productImage: List<String>.from(product['productImage']),
//           productCategory: product['productCategory'],
//           isSwitchReservation: product['isSwitchReservation'],
//           discount: product['discount'],
//           model: product['model'],
//           // createdAt: product['createdAt'],
//           location: product['location'],
//           imageCompany: product['imageCompany'],
//           userId: product['userId'],
//           companyName: product['companyName'],
//           phoneNumber: product['phoneNumber'],
//         );
//       }
//     } catch (e) {
//       log("Error fetching products: $e");
//     }

//     notifyListeners();
//   }
// }

// class MyProductModel {
//   final String productId;
//   final String userId;
//   final String productTitle;
//   final String productPrice;
//   final String productDescription;
//   final String productCategory;
//   final bool isSwitchReservation;
//   final String discount;
//   final List<String> productImage;
//   final String model;
//   final String location;
//   final String imageCompany;
//   final String companyName;
//   final String phoneNumber;

//   MyProductModel({
//     required this.productId,
//     required this.userId,
//     required this.productTitle,
//     required this.productPrice,
//     required this.productDescription,
//     required this.productCategory,
//     required this.isSwitchReservation,
//     required this.discount,
//     required this.productImage,
//     required this.model,
//     required this.location,
//     required this.imageCompany,
//     required this.companyName,
//     required this.phoneNumber,
//   });

//   factory MyProductModel.fromMap(Map<String, dynamic> map) {
//     return MyProductModel(
//       productId: map['productId'],
//       userId: map['userId'],
//       productTitle: map['productTitle'],
//       productPrice: map['productPrice'],
//       productDescription: map['productDescription'],
//       productCategory: map['productCategory'],
//       isSwitchReservation: map['isSwitchReservation'],
//       discount: map['discount'],
//       productImage: List<String>.from(map['productImage']),
//       model: map['model'],
//       location: map['location'],
//       imageCompany: map['imageCompany'],
//       companyName: map['companyName'],
//       phoneNumber: map['phoneNumber'],
//     );
//   }
// }
// class VendorProductsProvider with ChangeNotifier {
//   final Map<String, VendorProductsModel> _myProducts = {};
//   Map<String, VendorProductsModel> get myProducts => _myProducts;
// // firebase
//   final usersDB = FirebaseFirestore.instance.collection("vendors");
//   final _auth = FirebaseAuth.instance;

//   Future<void> fetchMyProducts() async {
//     final User? user = _auth.currentUser;
//     if (user == null) return;

//     try {
//       final userDoc = await usersDB.doc(user.uid).get();

//       final data = userDoc.data();
//       if (data == null || !data.containsKey('products')) {
//         return;
//       }
//       final leng = userDoc.get('products').length;
//       for (int i = 0; i < leng; i++) {
//         _myProducts.putIfAbsent(
//           userDoc.get('products')[i]['productId'],
//           () => VendorProductsModel(
//             productsId: userDoc.get('products')[i]['productId'],
//             userId: userDoc.get('products')[i]['userId'],
//           ),
//         );
//       }
//     } catch (e) {
//       rethrow;
//     }
//     notifyListeners();
//   }
// }

// class VendorProductsModel with ChangeNotifier {
//   String productsId;
//   String userId;
//   VendorProductsModel({required this.productsId, required this.userId});
// }
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
}
// class VendorProductsProvider with ChangeNotifier {
//   final Map<String, VendorProductsModel> _myProducts = {};
//   Map<String, VendorProductsModel> get myProducts => _myProducts;

//   // firebase
//   final usersDB = FirebaseFirestore.instance.collection("vendors");
//   final _auth = FirebaseAuth.instance;

//   Future<void> fetchMyProducts() async {
//     final User? user = _auth.currentUser;
//     if (user == null) return;

//     try {
//       final userDoc = await usersDB.doc(user.uid).get();
//       final data = userDoc.data();
//       if (data == null || !data.containsKey('products')) {
//         return;
//       }

//       final products = List<Map<String, dynamic>>.from(data['products']);
//       for (var product in products) {
//         _myProducts[product['productId']] = VendorProductsModel(
//           productsId: product['productId'],
//           userId: product['userId'],
//           productTitle: product['productTitle'],
//           productPrice: product['productPrice'],
//           productDescription: product['productDescription'],
//           productImage: List<String>.from(product['productImage']),
//           location: product['location'],
//           isSwitchReservation: product['isSwitchReservation'],
//           discount: product['discount'],
//           category: product['productCategory'],
//           model: product['model'],
//           createdAt: product['createdAt'],
//           imageCompany: product['imageCompany'],
//           companyName: product['companyName'],
//           phoneNumber: product['phoneNumber'],
//         );
//       }
//     } catch (e) {
//       rethrow;
//     }
//     notifyListeners();
//   }
// }

// class VendorProductsModel with ChangeNotifier {
//   final String productsId;
//   final String userId;
//   final String productTitle;
//   final String productPrice;
//   final String? productDescription;
//   final List<String> productImage;
//   final String location;
//   bool isSwitchReservation;
//   final String discount;
//   final String category;
//   final String model;
//   final Timestamp createdAt;
//   final String imageCompany;
//   final String companyName;
//   final String phoneNumber;

//   VendorProductsModel({
//     required this.productsId,
//     required this.userId,
//     required this.productTitle,
//     required this.productPrice,
//     this.productDescription,
//     required this.productImage,
//     required this.location,
//     required this.isSwitchReservation,
//     required this.discount,
//     required this.category,
//     required this.model,
//     required this.createdAt,
//     required this.imageCompany,
//     required this.companyName,
//     required this.phoneNumber,
//   });
// }
