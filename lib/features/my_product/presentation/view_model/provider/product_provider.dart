// import 'package:car_vendor/core/utils/app_image.dart';
// import 'package:car_vendor/features/my_product/presentation/view_model/model/products_model.dart';
// import 'package:flutter/material.dart';
// import 'package:uuid/uuid.dart';

// class ProductProvider extends ChangeNotifier {
//   List<ProductsModel> get getProduct {
//     return _products;
//   }

//   ProductsModel? findByProductId(String productId) {
//     if (_products.where((element) => element.productsId == productId).isEmpty) {
//       return null;
//     }
//     return _products.firstWhere((element) => element.productsId == productId);
//   }

//   final List<ProductsModel> _products = [
//     ProductsModel(
//       isSwitchReservation: true,
//       userId: const Uuid().v4(),
//       imageCompany: Assets.imagesFerareCar,
//       productsId: const Uuid().v4(),
//       nameProduct: "Toyota Corolla",
//       priceProduct: "20000",
//       descriptionProduct: "A reliable and fuel-efficient sedan.",
//       phoneNumberVendor: "1234567890",
//       companyName: "Toyota",
//       modelProduct: "1991",
//       categoryProduct: "Acura - أكورا",
//       imagesProduct: [Assets.imagesFerareCar, Assets.imagesFerareCar],
//       // productsVendor: [
//       //   "Product1",
//       //   "Product2",
//       //   "Product1",
//       //   "Product2",
//       //   "Product1",
//       //   "Product2",
//       //   "Product1",
//       //   "Product2",
//       //   "Product1",
//       //   "Product2",
//       //   "Product1",
//       //   "Product2",
//       //   "Product1",
//       //   "Product2",
//       //   "Product1",
//       //   "Product2",
//       //   "Product1",
//       //   "Product2",
//       //   "Product1",
//       //   "Product2",
//       // ],
//       locationVendor: "Riyadh, Saudi Arabia",
//       discount: "5%",
//     ),
//     ProductsModel(
//       isSwitchReservation: true,
//       userId: const Uuid().v4(),
//       imageCompany: Assets.imagesFerareCar,
//       productsId: const Uuid().v4(),
//       nameProduct: "Honda Civic",
//       priceProduct: "22000",
//       descriptionProduct: "A stylish and powerful compact car.",
//       phoneNumberVendor: "0987654321",
//       companyName: "Honda",
//       modelProduct: "2022",
//       categoryProduct: "Acura - أكورا",
//       imagesProduct: [Assets.imagesCarTest, Assets.imagesCarTest],
//       // productsVendor: ["Product3", "Product4"],
//       locationVendor: "Jeddah, Saudi Arabia",
//       discount: "7%",
//     ),
//     ProductsModel(
//       isSwitchReservation: true,
//       userId: const Uuid().v4(),
//       imageCompany: Assets.imagesFerareCar,
//       productsId: const Uuid().v4(),
//       nameProduct: "Honda Civic",
//       priceProduct: "22000",
//       descriptionProduct: "A stylish and powerful compact car.",
//       phoneNumberVendor: "0987654321",
//       companyName: "Honda",
//       modelProduct: "2022",
//       categoryProduct: "Acura - أكورا",
//       imagesProduct: [Assets.imagesCarTest, Assets.imagesCarTest],
//       // productsVendor: ["Product3", "Product4"],
//       locationVendor: "Jeddah, Saudi Arabia",
//       discount: "7%",
//     ),
//     ProductsModel(
//       isSwitchReservation: true,
//       userId: const Uuid().v4(),
//       imageCompany: Assets.imagesFerareCar,
//       productsId: const Uuid().v4(),
//       nameProduct: "BMW X5",
//       priceProduct: "50000",
//       descriptionProduct: "A luxurious and spacious SUV.",
//       phoneNumberVendor: "1122334455",
//       companyName: "BMW",
//       modelProduct: "2022",
//       categoryProduct: "Acura - أكورا",
//       imagesProduct: [Assets.imagesTesla, Assets.imagesTesla],
//       // productsVendor: ["Product5", "Product6"],
//     ),
//   ];
// }
