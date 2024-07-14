import 'package:car_vendor/features/auth/presentation/manger/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  UserModel? userModel;
  UserModel? get getUserModel => userModel;

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
      userModel = UserModel(
        vendorName: userDoc.get("vendorName"),
        vendorId: userDoc.get("vendorId"),
        vendorEmail: userDoc.get("vendorEmail"),
        phoneNumber: userDoc.get("phoneNumber"),
        location: userDoc.get("location"),
        image: userDoc.get("image"),
        companyType: userDoc.get("companyType"),
        createdAt: userDoc.get("createdAt"),
        products:
            userDocMap!.containsKey("products") ? userDoc.get("products") : [],
      );
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      rethrow;
    }
    return userModel;
  }
}
