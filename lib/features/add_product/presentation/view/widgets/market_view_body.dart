import 'dart:io';

import 'package:car_vendor/core/constant/my_const.dart';
import 'package:car_vendor/core/utils/app_color.dart';
import 'package:car_vendor/core/utils/app_image.dart';
import 'package:car_vendor/core/utils/size_config.dart';
import 'package:car_vendor/core/widgets/alert_dialog.dart';
import 'package:car_vendor/core/widgets/custom_button.dart';
import 'package:car_vendor/core/widgets/custom_text_filed.dart';
import 'package:car_vendor/features/add_product/presentation/view/widgets/custom_dropdown_button.dart';
import 'package:car_vendor/features/add_product/presentation/view/widgets/switch_reseration.dart';
import 'package:car_vendor/features/add_product/presentation/view/widgets/text_form_field_description.dart';
import 'package:car_vendor/features/add_product/presentation/view/widgets/upload_image_button.dart';
import 'package:car_vendor/features/auth/presentation/manger/model/user_model.dart';
import 'package:car_vendor/features/auth/presentation/manger/provider/user_provider.dart';
import 'package:car_vendor/features/lang/app_localization.dart';
import 'package:car_vendor/features/my_product/presentation/view_model/model/products_model.dart';
import 'package:car_vendor/loading_manger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class MarketViewBody extends StatefulWidget {
  const MarketViewBody({super.key, this.productsModel});

  final ProductsModel? productsModel;
  // final UserModel? userModel;
  @override
  State<MarketViewBody> createState() => _MarketViewBodyState();
}

class _MarketViewBodyState extends State<MarketViewBody> {
  List productNetworkImage = [];
  final _key = GlobalKey<FormState>();
  bool isEditing = false;
  String? _categoryValue;
  String? _modelValue;
  bool isLoading = false;

  late TextEditingController productNameController,
      priceController,
      descriptionController,
      locationController,
      discountController;

  late final FocusNode productNameFocusNode,
      priceFocusNode,
      descriptionFocusNode,
      locationFocusNode,
      discountFocusNode;

  List<XFile> selectedImages = [];
  UserModel? userModel;
  User? user = FirebaseAuth.instance.currentUser;
  Future<void> fetchUserInfo() async {
    if (user == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      userModel = await userProvider.getUser();
    } catch (error) {
      if (!mounted) return;
      await AlertDialogMethods.showError(
        context: context,
        subtitle: "An error has been occured".tr(context),
        titleBottom: "Ok",
        lottileAnimation: Assets.imagesErrorMas,
        function: () {
          Navigator.of(context).pop();
        },
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> pickImages() async {
    List<XFile>? result = await ImagePicker().pickMultiImage();
    selectedImages = result;
    setState(() {});
  }

  Future<List<String>> uploadImagesToFirebaseStorage(List<XFile> images) async {
    setState(() {
      isLoading = true;
    });
    final storage = firebase_storage.FirebaseStorage.instance;
    List<String> downloadURLs = [];

    for (int i = 0; i < images.length; i++) {
      final imagePath = 'images/image_$i.jpg';
      final imageFile = File(images[i].path);
      final task = storage.ref().child(imagePath).putFile(imageFile);

      await task.whenComplete(() async {
        final downloadURL = await task.snapshot.ref.getDownloadURL();
        downloadURLs.add(downloadURL);
      });
    }

    return downloadURLs;
  }

  Future<void> storeImageUrlsInFirestore(List<String> downloadURLs) async {
    final firestore = FirebaseFirestore.instance;

    final productID = const Uuid().v4();
    // Replace 'images' with your desired collection name
    final collectionRef = firestore.collection('product');

    final doucumentRef = await collectionRef.add({
      'productId': productID,
      'productTitle': productNameController.text,
      'productPrice': priceController.text,
      'productDescription': descriptionController.text,
      'productCategory': _categoryValue,
      'isSwitchReservation': widget.productsModel?.isSwitchReservation ?? false,
      'discount': discountController.text,
      'productImage': downloadURLs,
      'model': _modelValue,
      'createdAt': Timestamp.now(),
      'location': locationController.text,
      'imageCompany': userModel?.image ?? "",
      'userId': userModel!.vendorId,
      'companyName': userModel!.vendorName,
      'phoneNumber': userModel!.phoneNumber,
    });
    // await doucumentRef.update({
    //   'createdAt': FieldValue.serverTimestamp(),
    // });
    final usersDB = FirebaseFirestore.instance.collection("vendors");
    final auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user!.uid;
    // final vendorId = const Uuid().v4();
    try {
      await usersDB.doc(uid).update({
        "products": FieldValue.arrayUnion([
          {
            'productId': productID,
            'productTitle': productNameController.text,
            'productPrice': priceController.text,
            'productDescription': descriptionController.text,
            'productCategory': _categoryValue,
            'isSwitchReservation':
                widget.productsModel?.isSwitchReservation ?? false,
            'discount': discountController.text,
            'productImage': downloadURLs,
            'model': _modelValue,
            'createdAt': Timestamp.now(),
            'location': locationController.text,
            'imageCompany': userModel?.image ?? "",
            'userId': userModel!.vendorId,
            'companyName': userModel!.vendorName,
            'phoneNumber': userModel!.phoneNumber,
          }
        ]),
      });
      Fluttertoast.showToast(msg: "Item has been added successfully");
    } catch (e) {
      print(e);
    }
    setState(() {
      isLoading = false;
    });
    print('Image URLs stored in Firestore!');
  }

  @override
  void initState() {
    fetchUserInfo();
    if (widget.productsModel != null) {
      productNetworkImage = widget.productsModel!.imagesProduct;
    }
    if (widget.productsModel != null) {
      isEditing = true;
      _categoryValue = widget.productsModel!.categoryProduct;
      _modelValue = widget.productsModel!.modelProduct;
    }
    productNameController =
        TextEditingController(text: widget.productsModel?.nameProduct);
    priceController =
        TextEditingController(text: widget.productsModel?.priceProduct);
    descriptionController =
        TextEditingController(text: widget.productsModel?.descriptionProduct);
    locationController =
        TextEditingController(text: widget.productsModel?.locationVendor);
    discountController =
        TextEditingController(text: widget.productsModel?.discount);

    productNameFocusNode = FocusNode();
    priceFocusNode = FocusNode();
    descriptionFocusNode = FocusNode();
    locationFocusNode = FocusNode();
    discountFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    productNameController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    discountController.dispose();

    productNameFocusNode.dispose();
    priceFocusNode.dispose();
    descriptionFocusNode.dispose();
    locationFocusNode.dispose();
    discountFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingMangerView(
      isLoading: isLoading,
      child: Form(
        key: _key,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: MediaQuery.sizeOf(context).width < SizeConfig.tablet
                ? const EdgeInsetsDirectional.symmetric(horizontal: 24)
                : EdgeInsetsDirectional.only(
                    start: MediaQuery.sizeOf(context).width / 6,
                    end: MediaQuery.sizeOf(context).width / 6,
                  ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                UploadImageButton(
                  productNetworkImages: productNetworkImage,
                  selectedImages: selectedImages,
                  onTap: () {
                    pickImages();
                  },
                ),
                const Divider(
                  color: AppColor.kGrayOpacity,
                  height: 60,
                  thickness: .5,
                  endIndent: 16,
                  indent: 16,
                ),
                CustomTextFiled(
                  key: const ValueKey("Product Name"),
                  controller: productNameController,
                  focusNode: productNameFocusNode,
                  title: "Product Name".tr(context),
                  textInputType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFiled(
                          key: const ValueKey("Price"),
                          controller: priceController,
                          focusNode: priceFocusNode,
                          title: "Price".tr(context),
                          textInputType: TextInputType.number),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      // child: BrandDropdownButton(),
                      child: CustomTextFiled(
                          controller: discountController,
                          key: const ValueKey("Discount"),
                          focusNode: discountFocusNode,
                          title: "Discount".tr(context),
                          textInputType: TextInputType.number),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      // child: YearDropdownButton(),
                      child: CustomDropdown(
                        key: const ValueKey("Model"),
                        title: "Model",
                        value: _modelValue,
                        items: YearProvider.yearDropDownList,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: CustomTextFiled(
                        controller: locationController,
                        key: const ValueKey("Location"),
                        focusNode: locationFocusNode,
                        prefix: const Icon(IconlyBold.location,
                            color: AppColor.kSilver),
                        title: "Location".tr(context),
                        textInputType: TextInputType.streetAddress,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                CustomDropdown(
                  key: const ValueKey("Brand"),
                  title: "brand",
                  value: _categoryValue,
                  items: AppConstants.brandDropDownList(),
                ),
                const SizedBox(height: 15),
                TextFormFieldDescription(
                  descriptionController: descriptionController,
                  key: const ValueKey("Description"),
                  descriptionFocusNode: descriptionFocusNode,
                ),
                // const SizedBox(height: 45),
                const SizedBox(height: 15),
                SwitchReservation(
                  productModel: widget.productsModel,
                ),
                const SizedBox(height: 15),
                CustomButton(
                  title: isEditing
                      ? "Edit product".tr(context)
                      : "Add Product".tr(context),
                  onPressed: () async {
                    if (productNameController.text.isEmpty ||
                        descriptionController.text.isEmpty ||
                        priceController.text.isEmpty ||
                        locationController.text.isEmpty ||
                        discountController.text.isEmpty ||
                        selectedImages.isEmpty ||
                        _categoryValue == null ||
                        _modelValue == null) {
                      if (!mounted) return;
                      await AlertDialogMethods.showError(
                        context: context,
                        subtitle: "Please fill all fields".tr(context),
                        titleBottom: "Ok",
                        lottileAnimation: Assets.imagesErrorMas,
                        function: () {
                          Navigator.of(context).pop();
                        },
                      );
                    } else {
                      List<String> downloadURLs =
                          await uploadImagesToFirebaseStorage(selectedImages);
                      await storeImageUrlsInFirestore(downloadURLs);
                    }
                  },
                ),
                const SizedBox(height: 45),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
