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
import 'package:car_vendor/features/add_product/presentation/view_model/provider/add_products.dart';
import 'package:car_vendor/features/auth/presentation/manger/provider/user_provider.dart';
import 'package:car_vendor/features/lang/app_localization.dart';
import 'package:car_vendor/features/my_product/presentation/view_model/model/products_model.dart';
import 'package:car_vendor/loading_manger.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class MarketViewBody extends StatefulWidget {
  const MarketViewBody({super.key, this.productsModel});

  final ProductsModel? productsModel;
  @override
  State<MarketViewBody> createState() => _MarketViewBodyState();
}

class _MarketViewBodyState extends State<MarketViewBody> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController discountController = TextEditingController();

  final FocusNode productNameFocusNode = FocusNode();
  final FocusNode priceFocusNode = FocusNode();
  final FocusNode descriptionFocusNode = FocusNode();
  final FocusNode locationFocusNode = FocusNode();
  final FocusNode discountFocusNode = FocusNode();

  String? _categoryValue;
  String? _modelValue;
  bool isSwitchReservation = false;
  List productNetworkImage = [];
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    Provider.of<UserProvider>(context, listen: false).getUser();

    if (widget.productsModel != null) {
      isEditing = true;
    }
    if (widget.productsModel != null) {
      productNetworkImage = widget.productsModel!.imagesProduct;
      productNameController.text = widget.productsModel!.nameProduct ?? "";
      priceController.text = widget.productsModel!.priceProduct ?? "";
      descriptionController.text =
          widget.productsModel!.descriptionProduct ?? "";
      locationController.text = widget.productsModel!.locationVendor ?? "";
      discountController.text = widget.productsModel!.discount ?? "";
      _categoryValue = widget.productsModel!.categoryProduct;
      _modelValue = widget.productsModel!.modelProduct;
      isSwitchReservation = widget.productsModel!.isSwitchReservation;
    }
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<NEWProductProvider>(context);
    // final userProvider = Provider.of<UserProvider>(context);
    return LoadingMangerView(
      isLoading: productProvider.isLoading,
      child: Form(
        key: _formKey,
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
                  selectedImages: productProvider.selectedImages,
                  onTap: () {
                    productProvider.pickImages();
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
                      child: CustomDropdown(
                        child: DropdownButton(
                          isExpanded: true,
                          underline: const SizedBox(),
                          icon: const Icon(IconlyLight.arrow_down_2),
                          dropdownColor: Colors.white,
                          // value: _yearValue,
                          value: _modelValue,
                          hint: Text(
                            _modelValue ?? "Model".tr(context),
                            style: const TextStyle(
                              color: AppColor.kSilver,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          // items: YearProvider.yearDropDownList,
                          items: YearProvider.yearDropDownList,
                          onChanged: (value) {
                            setState(() {
                              _modelValue = value;
                            });
                          },
                        ),
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
                  child: DropdownButton(
                    isExpanded: true,
                    underline: const SizedBox(),
                    icon: const Icon(IconlyLight.arrow_down_2),
                    dropdownColor: Colors.white,
                    // value: _yearValue,
                    value: _categoryValue,
                    hint: Text(
                      _categoryValue ?? "Model".tr(context),
                      style: const TextStyle(
                        color: AppColor.kSilver,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    // items: YearProvider.yearDropDownList,
                    items: AppConstants.brandDropDownList(),
                    onChanged: (value) {
                      setState(() {
                        _categoryValue = value;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 15),
                TextFormFieldDescription(
                  descriptionController: descriptionController,
                  key: const ValueKey("Description"),
                  descriptionFocusNode: descriptionFocusNode,
                ),
                const SizedBox(height: 15),
                SwitchReservation(
                  productModel: widget.productsModel,
                ),
                const SizedBox(height: 15),
                isEditing
                    ? CustomButton(
                        title: "Delete Product".tr(context),
                        onPressed: () async {
                          // if (productNameController.text.isEmpty ||
                          //     descriptionController.text.isEmpty ||
                          //     priceController.text.isEmpty ||
                          //     locationController.text.isEmpty ||
                          //     discountController.text.isEmpty ||
                          //     // productProvider.selectedImages.isEmpty ||
                          //     _categoryValue == null ||
                          //     _modelValue == null) {
                          //   if (!mounted) return;
                          //   await AlertDialogMethods.showError(
                          //     context: context,
                          //     subtitle: "Please fill all fields".tr(context),
                          //     titleBottom: "Ok",
                          //     lottileAnimation: Assets.imagesErrorMas,
                          //     function: () {
                          //       Navigator.of(context).pop();
                          //     },
                          //   );
                          // } else {
                          //   List<String> downloadURLs = await productProvider
                          //       .uploadImagesToFirebaseStorage();
                          //   await productProvider.updateProductInFirestore(
                          //     context,
                          //     widget.productsModel!.productsId,
                          //     downloadURLs,
                          //     productNameController,
                          //     priceController,
                          //     descriptionController,
                          //     locationController,
                          //     discountController,
                          //     _categoryValue,
                          //     _modelValue,
                          //     isSwitchReservation,
                          //     widget.productsModel?.imagesProduct.cast<String>(),
                          //   );
                          // }
                          productProvider.deleteProductFromFirestore(
                              context, widget.productsModel!.productsId);
                        },
                      )
                    : CustomButton(
                        title: "Add Product".tr(context),
                        onPressed: () async {
                          if (productNameController.text.isEmpty ||
                              descriptionController.text.isEmpty ||
                              priceController.text.isEmpty ||
                              locationController.text.isEmpty ||
                              discountController.text.isEmpty ||
                              // productProvider.selectedImages.isEmpty ||
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
                            List<String> downloadURLs = await productProvider
                                .uploadImagesToFirebaseStorage();
                            await productProvider.storeImageUrlsInFirestore(
                              context,
                              downloadURLs,
                              productNameController,
                              priceController,
                              descriptionController,
                              locationController,
                              discountController,
                              _categoryValue,
                              _modelValue,
                              isSwitchReservation,
                            );
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
