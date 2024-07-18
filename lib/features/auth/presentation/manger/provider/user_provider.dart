import 'package:car_vendor/features/auth/presentation/manger/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  UserModel? userModel;
  UserModel? get getUserModel => userModel;

  // Future<UserModel?> getUser() async {
  //   final FirebaseAuth auth = FirebaseAuth.instance;
  //   User? user = auth.currentUser;

  //   if (user == null) {
  //     return null;
  //   }
  //   var uid = user.uid;
  //   try {
  //     final userDoc =
  //         await FirebaseFirestore.instance.collection("vendors").doc(uid).get();
  //     final userDocMap = userDoc.data();
  //     userModel = UserModel(
  //       vendorName: userDoc.get("vendorName"),
  //       vendorId: userDoc.get("vendorId"),
  //       vendorEmail: userDoc.get("vendorEmail"),
  //       phoneNumber: userDoc.get("phoneNumber"),
  //       location: userDoc.get("location"),
  //       image: userDoc.get("image"),
  //       companyType: userDoc.get("companyType"),
  //       createdAt: userDoc.get("createdAt"),
  //       products:
  //           userDocMap!.containsKey("products") ? userDoc.get("products") : [],
  //       myOrders:
  //           userDocMap.containsKey("myOrders") ? userDoc.get("myOrders") : [],
  //     );
  //   } on FirebaseException catch (e) {
  //     throw e.message.toString();
  //   } catch (e) {
  //     rethrow;
  //   }
  //   return userModel;
  // }
  Future<UserModel?> getUser() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user == null) {
      return null;
    }
    var uid = user.uid;
    try {
      final userDoc =
          await FirebaseFirestore.instance.collection("vendors").doc(uid).get();
      final userDocMap = userDoc.data();
      if (userDocMap == null) {
        return null;
      }

      // تأكد من أن products و myOrders هما إما قوائم من العناصر أو خرائط
      final products = userDocMap.containsKey("products")
          ? (userDocMap["products"] is Iterable
              ? List<dynamic>.from(userDocMap["products"])
              : [userDocMap["products"]])
          : [];
      final myOrders = userDocMap.containsKey("myOrders")
          ? (userDocMap["myOrders"] is Iterable
              ? List<dynamic>.from(userDocMap["myOrders"])
              : [userDocMap["myOrders"]])
          : [];

      userModel = UserModel(
        vendorName: userDoc.get("vendorName"),
        vendorId: userDoc.get("vendorId"),
        vendorEmail: userDoc.get("vendorEmail"),
        phoneNumber: userDoc.get("phoneNumber"),
        location: userDoc.get("location"),
        image: userDoc.get("image"),
        companyType: userDoc.get("companyType"),
        createdAt: userDoc.get("createdAt"),
        products: products,
        myOrders: myOrders,
      );
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      rethrow;
    }
    return userModel;
  }
}
