import 'package:car_vendor/core/api/firebase_analytics.dart';
import 'package:car_vendor/features/auth/presentation/manger/provider/user_provider.dart';
import 'package:flutter/material.dart';
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

  void clearImages() {
    _selectedImages = [];
    notifyListeners();
  }

  void clearImagesWithoutNotify() {
    _selectedImages = [];
  }

  @override
  void dispose() {
    clearImagesWithoutNotify();
    super.dispose();
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
    TextEditingController discountController,
    String? categoryValue,
    String? modelValue,
    bool isSwitchReservation,
    String? categoryTypeAd,
  ) async {
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
        "categoryTypeAd": categoryTypeAd,
        'isSwitchReservation': isSwitchReservation,
        'discount': discountController.text,
        'productImage': downloadURLs,
        'model': modelValue,
        'createdAt': Timestamp.now(),
        'location': userModel.location,
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
            "categoryTypeAd": categoryTypeAd,
            'isSwitchReservation': isSwitchReservation,
            'discount': discountController.text,
            'productImage': downloadURLs,
            'model': modelValue,
            'createdAt': Timestamp.now(),
            'location': userModel.location,
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
    String? categoryTypeAd,
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
        "categoryTypeAd": categoryTypeAd,
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
            "categoryTypeAd": categoryTypeAd,
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
      final analyticsService =
          Provider.of<AnalyticsService>(context, listen: false);
      analyticsService.logEvent(
        eventName: 'add_product_vendors',
        parameters: {
          'app_type': 'vendors',
          'screen_name': 'add_product_vendors',
        },
      );
    } catch (e) {
      print("Error updating product in Firestore: $e");
    }

    dispose();
  }

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
      final analyticsService =
          Provider.of<AnalyticsService>(context, listen: false);
      analyticsService.logEvent(
        eventName: 'delete_product_vendors',
        parameters: {
          'app_type': 'vendors',
          'screen_name': 'delete_product_vendors',
        },
      );
      notifyListeners();
    } catch (e) {
      print("Error deleting product from Firestore: $e");
    }
  }
}
