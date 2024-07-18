import 'package:car_vendor/features/auth/presentation/manger/provider/user_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class NEWProductProvider with ChangeNotifier {
  List<XFile> _selectedImages = [];
  List<XFile> get selectedImages => _selectedImages;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // String importId = const Uuid().v4();

  void pickImages() async {
    List<XFile>? result = await ImagePicker().pickMultiImage();
    _selectedImages = result;
    notifyListeners();
  }

  Future<List<String>> uploadImagesToFirebaseStorage() async {
    _isLoading = true;
    notifyListeners();

    final storage = firebase_storage.FirebaseStorage.instance;
    List<String> downloadURLs = [];

    for (int i = 0; i < _selectedImages.length; i++) {
      final imagePath = 'images/image_${const Uuid().v4()}.jpg';
      // final imagePath = 'images/image_${const Uuid().v4()}.jpg';
      final imageFile = File(_selectedImages[i].path);
      final task = storage.ref().child(imagePath).putFile(imageFile);

      await task.whenComplete(() async {
        final downloadURL = await task.snapshot.ref.getDownloadURL();
        downloadURLs.add(downloadURL);
      });
    }

    _isLoading = false;
    notifyListeners();

    return downloadURLs;
  }

  Future<void> storeImageUrlsInFirestore(
      BuildContext context,
      List<String> downloadURLs,
      TextEditingController productNameController,
      TextEditingController priceController,
      TextEditingController descriptionController,
      TextEditingController locationController,
      TextEditingController discountController,
      String? categoryValue,
      String? modelValue,
      bool isSwitchReservation) async {
    final firestore = FirebaseFirestore.instance;
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final userModel = userProvider.userModel;

    if (userModel == null) return;

    final productID = const Uuid().v4();
    final collectionRef = firestore.collection('product').doc(productID);

    try {
      await collectionRef.set({
        'productId': productID,
        'productTitle': productNameController.text,
        'productPrice': priceController.text,
        'productDescription': descriptionController.text,
        'productCategory': categoryValue,
        'isSwitchReservation': isSwitchReservation,
        'discount': discountController.text,
        'productImage': downloadURLs,
        'model': modelValue,
        'createdAt': Timestamp.now(),
        'location': locationController.text,
        'imageCompany': userModel.image,
        'userId': userModel.vendorId,
        'companyName': userModel.vendorName,
        'phoneNumber': userModel.phoneNumber,
      });

      await firestore.collection('vendors').doc(userModel.vendorId).update({
        "products": FieldValue.arrayUnion([
          {
            'productId': productID,
            'productTitle': productNameController.text,
            'productPrice': priceController.text,
            'productDescription': descriptionController.text,
            'productCategory': categoryValue,
            'isSwitchReservation': isSwitchReservation,
            'discount': discountController.text,
            'productImage': downloadURLs,
            'model': modelValue,
            'createdAt': Timestamp.now(),
            'location': locationController.text,
            'imageCompany': userModel.image,
            'userId': userModel.vendorId,
            'companyName': userModel.vendorName,
            'phoneNumber': userModel.phoneNumber,
          }
        ]),
      });

      notifyListeners();
    } catch (e) {
      print("Error storing image URLs in Firestore: $e");
    }
  }

  Future<void> updateProductInFirestore(
    BuildContext context,
    String productId,
    List<String>? downloadURLs,
    TextEditingController productNameController,
    TextEditingController priceController,
    TextEditingController descriptionController,
    TextEditingController locationController,
    TextEditingController discountController,
    String? categoryValue,
    String? modelValue,
    bool isSwitchReservation,
    List<String>? oldDownloadURLs,
  ) async {
    final firestore = FirebaseFirestore.instance;
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final userModel = userProvider.userModel;

    if (userModel == null) return;

    final collectionRef = firestore.collection('product');

    try {
      await collectionRef.doc(productId).update({
        'productTitle': productNameController.text,
        'productPrice': priceController.text,
        'productDescription': descriptionController.text,
        'productCategory': categoryValue,
        'isSwitchReservation': isSwitchReservation,
        'discount': discountController.text,
        'productImage': downloadURLs ?? oldDownloadURLs,
        'model': modelValue,
        'updatedAt': Timestamp.now(),
        'location': locationController.text,
      });

      // await firestore.collection('vendors').doc(userModel.vendorId).update({
      //   "products": {
      //     'productId': productId,
      //     'productTitle': productNameController.text,
      //     'productPrice': priceController.text,
      //     'productDescription': descriptionController.text,
      //     'productCategory': categoryValue,
      //     'isSwitchReservation': isSwitchReservation,
      //     'discount': discountController.text,
      //     'productImage': downloadURLs,
      //     'model': modelValue,
      //     'updatedAt': Timestamp.now(),
      //     'location': locationController.text,
      //     'imageCompany': userModel.image,
      //     'userId': userModel.vendorId,
      //     'companyName': userModel.vendorName,
      //     'phoneNumber': userModel.phoneNumber,
      //   }
      // });
      await firestore.collection('vendors').doc(userModel.vendorId).update({
        "products": FieldValue.arrayUnion([
          {
            'productId': productId,
            'productTitle': productNameController.text,
            'productPrice': priceController.text,
            'productDescription': descriptionController.text,
            'productCategory': categoryValue,
            'isSwitchReservation': isSwitchReservation,
            'discount': discountController.text,
            'productImage': downloadURLs ?? oldDownloadURLs,
            'model': modelValue,
            'updatedAt': Timestamp.now(),
            'location': locationController.text,
            'imageCompany': userModel.image,
            'userId': userModel.vendorId,
            'companyName': userModel.vendorName,
            'phoneNumber': userModel.phoneNumber,
          }
        ])
      });

      notifyListeners();
    } catch (e) {
      print("Error updating product in Firestore: $e");
    }
  }

  // Future<void> deleteProductFromFirestore(
  //   BuildContext context,
  //   String productId,
  // ) async {
  //   final firestore = FirebaseFirestore.instance;
  //   final userProvider = Provider.of<UserProvider>(context, listen: false);
  //   final userModel = userProvider.userModel;

  //   if (userModel == null) return;

  //   final collectionRef = firestore.collection('product');

  //   try {
  //     // حذف المنتج من مجموعة المنتجات
  //     await collectionRef.doc(productId).delete();

  //     // تحديث معلومات البائع وحذف المنتج من قائمة منتجاته
  //     await firestore.collection('vendors').doc(userModel.vendorId).update({
  //       "products": FieldValue.arrayRemove([
  //         {
  //           'productId': productId,
  //           // يجب توفير نفس الحقول المستخدمة عند إضافة المنتج لضمان التحديث الصحيح
  //           // يمكنك استخدام بيانات قديمة أو فارغة حسب الحاجة
  //           'productTitle': '',
  //           'productPrice': '',
  //           'productDescription': '',
  //           'productCategory': '',
  //           'isSwitchReservation': false,
  //           'discount': '',
  //           'productImage': [],
  //           'model': '',
  //           'updatedAt': Timestamp.now(),
  //           'location': '',
  //           'imageCompany': userModel.image,
  //           'userId': userModel.vendorId,
  //           'companyName': userModel.vendorName,
  //           'phoneNumber': userModel.phoneNumber,
  //         }
  //       ])
  //     });

  //     notifyListeners();
  //   } catch (e) {
  //     print("Error deleting product from Firestore: $e");
  //   }
  // }
  Future<void> deleteProductFromFirestore(
    BuildContext context,
    String productId,
  ) async {
    final firestore = FirebaseFirestore.instance;
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final userModel = userProvider.userModel;

    if (userModel == null) return;

    final collectionRef = firestore.collection('product');

    try {
      // حذف المنتج من مجموعة المنتجات
      await collectionRef.doc(productId).delete();

      // تحديث معلومات البائع وحذف المنتج من قائمة منتجاته
      final vendorRef = firestore.collection('vendors').doc(userModel.vendorId);
      final vendorSnapshot = await vendorRef.get();
      final vendorData = vendorSnapshot.data() as Map<String, dynamic>;

      if (vendorData.containsKey('products')) {
        final products =
            List<Map<String, dynamic>>.from(vendorData['products']);

        // إزالة المنتج من قائمة المنتجات
        products.removeWhere((product) => product['productId'] == productId);

        // تحديث مستند البائع مع قائمة المنتجات المحدثة
        await vendorRef.update({
          'products': products,
        });
      }

      notifyListeners();
    } catch (e) {
      print("Error deleting product from Firestore: $e");
    }
  }

  // Future<void> updateProductInFirestore(
  //   BuildContext context,
  //   String productId,
  //   List<String>? downloadURLs,
  //   TextEditingController productNameController,
  //   TextEditingController priceController,
  //   TextEditingController descriptionController,
  //   TextEditingController locationController,
  //   TextEditingController discountController,
  //   String? categoryValue,
  //   String? modelValue,
  //   bool isSwitchReservation,
  //   List<String>? oldDownloadURLs,
  // ) async {
  //   final firestore = FirebaseFirestore.instance;
  //   final userProvider = Provider.of<UserProvider>(context, listen: false);
  //   final userModel = userProvider.userModel;

  //   if (userModel == null) return;

  //   try {
  //     // جلب وثيقة البائع
  //     DocumentSnapshot vendorSnapshot =
  //         await firestore.collection('vendors').doc(userModel.vendorId).get();

  //     if (vendorSnapshot.exists) {
  //       List<dynamic> products = vendorSnapshot.get('products');

  //       // العثور على المنتج المراد تعديله
  //       int productIndex =
  //           products.indexWhere((product) => product['productId'] == productId);

  //       if (productIndex != -1) {
  //         // الحصول على المنتج القديم
  //         var oldProduct = products[productIndex];

  //         // حذف المنتج القديم باستخدام FieldValue.arrayRemove
  //         await firestore.collection('vendors').doc(userModel.vendorId).update({
  //           'products': FieldValue.arrayRemove([oldProduct]),
  //         });

  //         // بعد حذف المنتج القديم، إضافة المنتج الجديد
  //         products.removeAt(productIndex);
  //         final ref = FirebaseStorage.instance
  //             .ref()
  //             .child("images")
  //             .child("$importId.jpg");

  //         // await ref.putFile(File(pickImage!.path));
  //         final oldDownloadURLs = await ref.getDownloadURL();
  //         products.add({
  //           'productId': productId,
  //           'productTitle': productNameController.text,
  //           'productPrice': priceController.text,
  //           'productDescription': descriptionController.text,
  //           'productCategory': categoryValue,
  //           'isSwitchReservation': isSwitchReservation,
  //           'discount': discountController.text,
  //           'productImage': downloadURLs ?? oldDownloadURLs,
  //           'model': modelValue,
  //           'updatedAt': Timestamp.now(),
  //           'location': locationController.text,
  //           'imageCompany': userModel.image,
  //           'userId': userModel.vendorId,
  //           'companyName': userModel.vendorName,
  //           'phoneNumber': userModel.phoneNumber,
  //         });

  //         // تحديث وثيقة البائع بالقائمة المعدلة
  //         await firestore.collection('vendors').doc(userModel.vendorId).update({
  //           'products': products,
  //         });

  //         print('Product updated successfully');
  //       } else {
  //         print('Product not found');
  //       }
  //     } else {
  //       print('Vendor not found');
  //     }

  //     notifyListeners();
  //   } catch (e) {
  //     print("Error updating product in Firestore: $e");
  //   }
  // }
}

// class UserProvider with ChangeNotifier {
//   UserModel? _userModel;
//   UserModel? get userModel => _userModel;

//   Future<void> fetchUserInfo() async {
//     final user = FirebaseAuth.instance.currentUser;

//     if (user == null) return;

//     try {
//       final doc = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(user.uid)
//           .get();
//       _userModel = UserModel.fromJson(doc.data()!);
//       notifyListeners();
//     } catch (error) {
//       print("Error fetching user info: $error");
//     }
//   }
// }

// class UserModel {
//   final String vendorId;
//   final String vendorName;
//   final String phoneNumber;
//   final String image;

//   UserModel({
//     required this.vendorId,
//     required this.vendorName,
//     required this.phoneNumber,
//     required this.image,
//   });

//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     return UserModel(
//       vendorId: json['vendorId'],
//       vendorName: json['vendorName'],
//       phoneNumber: json['phoneNumber'],
//       image: json['image'],
//     );
//   }
// }
