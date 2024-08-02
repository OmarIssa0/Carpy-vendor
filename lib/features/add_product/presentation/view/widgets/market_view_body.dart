import 'dart:developer';

import 'package:car_vendor/core/constant/my_const.dart';
import 'package:car_vendor/core/utils/animation_nav.dart';
import 'package:car_vendor/core/utils/app_color.dart';
import 'package:car_vendor/core/utils/app_image.dart';
import 'package:car_vendor/core/utils/app_styles.dart';
import 'package:car_vendor/core/utils/size_config.dart';
import 'package:car_vendor/core/widgets/alert_dialog.dart';
import 'package:car_vendor/core/widgets/custom_button.dart';
import 'package:car_vendor/core/widgets/custom_text_filed.dart';
import 'package:car_vendor/features/add_product/presentation/view/widgets/car_features_selecation_screen.dart';
import 'package:car_vendor/features/add_product/presentation/view/widgets/custom_dropdown_button.dart';
import 'package:car_vendor/features/add_product/presentation/view/widgets/text_form_field_description.dart';
import 'package:car_vendor/features/add_product/presentation/view/widgets/upload_image_button.dart';
import 'package:car_vendor/features/add_product/presentation/view_model/provider/add_products.dart';
import 'package:car_vendor/features/add_product/presentation/view_model/provider/car_specification_proovider.dart';
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
  final TextEditingController discountController = TextEditingController();

  final FocusNode productNameFocusNode = FocusNode();
  final FocusNode priceFocusNode = FocusNode();
  final FocusNode descriptionFocusNode = FocusNode();
  final FocusNode discountFocusNode = FocusNode();
  final FocusNode modelFocusNode = FocusNode();
  final FocusNode brandFocusNode = FocusNode();
  final FocusNode switchReservationFocusNode = FocusNode();

  String? _brandCar;
  String? _modelValue;
  String? _categoryAd;
  String? _colorCar;
  String? kilometer;
  // bool isSwitchReservation = false;
  List productNetworkImage = [];
  // List selectedFeatures = [];
  bool isEditing = false;
  bool isReservation = false;

  AddProductsProvider? _provider;
  CarFeaturesProvider? carFeaturesProvider;

  @override
  void initState() {
    super.initState();
    Provider.of<UserProvider>(context, listen: false).getUser();

    if (widget.productsModel != null) {
      isEditing = true;
    }
    if (widget.productsModel != null) {
      productNetworkImage = widget.productsModel!.imagesProduct;
      productNameController.text = widget.productsModel!.nameProduct;
      priceController.text = widget.productsModel!.priceProduct;
      descriptionController.text = widget.productsModel!.descriptionProduct;

      discountController.text = widget.productsModel!.discount ?? "";
      _colorCar = widget.productsModel?.color ?? "";
      _brandCar = widget.productsModel!.categoryProduct;
      kilometer = widget.productsModel?.kilometer ?? "";
      _modelValue = widget.productsModel!.modelProduct;
      // selectedFeatures = widget.productsModel!.selectedFeatures ?? [];
      _categoryAd = widget.productsModel!.categoryTypeAd;
      isReservation = widget.productsModel!.isSwitchReservation;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _provider ??= Provider.of<AddProductsProvider>(context, listen: false);
    carFeaturesProvider ??=
        Provider.of<CarFeaturesProvider>(context, listen: false);
  }

  @override
  void dispose() {
    // final productProvider =
    //     Provider.of<NEWProductProvider>(context, listen: false);
    productNameController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    discountController.dispose();
    modelFocusNode.dispose();

    productNameFocusNode.dispose();
    priceFocusNode.dispose();
    descriptionFocusNode.dispose();
    discountFocusNode.dispose();
    switchReservationFocusNode.dispose();

    brandFocusNode.dispose();
    productNetworkImage.clear();
    // selectedFeatures.clear();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _provider?.clearImages();
      carFeaturesProvider?.clearSelectedFeatures();
    });

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<AddProductsProvider>(context);
    var carFeaturesProvider = Provider.of<CarFeaturesProvider>(context);
    String selectedFeaturesText =
        carFeaturesProvider.selectedFeatureNames.toList().join(', ');

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
                // const AdMobBanner(),
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
                  readOnly: isEditing,
                  key: const ValueKey("Product Name"),
                  controller: productNameController,
                  focusNode: productNameFocusNode,
                  title: "Product Name".tr(context),
                  textInputType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(priceFocusNode);
                  },
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFiled(
                        textInputAction: TextInputAction.next,
                        readOnly: isEditing,
                        key: const ValueKey("Price"),
                        controller: priceController,
                        focusNode: priceFocusNode,
                        title: "Price".tr(context),
                        textInputType: TextInputType.number,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context)
                              .requestFocus(discountFocusNode);
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: CustomTextFiled(
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).requestFocus(modelFocusNode);
                        },
                        readOnly: isEditing,
                        controller: discountController,
                        key: const ValueKey("Price before discount"),
                        focusNode: discountFocusNode,
                        title: "Price before discount".tr(context),
                        textInputType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: CustomDropdown(
                        child: DropdownButton(
                          focusNode: modelFocusNode,
                          isExpanded: true,
                          underline: const SizedBox(),
                          icon: const Icon(IconlyLight.arrow_down_2),
                          dropdownColor: Colors.white,

                          value: _modelValue,
                          hint: Text(
                            _modelValue ?? "Model".tr(context),
                            style: const TextStyle(
                              color: AppColor.kSilver,
                              fontSize: 16,
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
                      child: CustomDropdown(
                        child: DropdownButton(
                          isExpanded: true,
                          underline: const SizedBox(),
                          icon: const Icon(IconlyLight.arrow_down_2),
                          dropdownColor: Colors.white,
                          // value: _yearValue,
                          value: _categoryAd,
                          hint: Text(
                            _categoryAd ?? "Product category".tr(context),
                            style: const TextStyle(
                              color: AppColor.kSilver,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          items: AppConstants.categoryDropDownList(),
                          onChanged: (value) {
                            setState(() {
                              _categoryAd = value;
                            });
                          },
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 15),
                CustomDropdown(
                  child: DropdownButton(
                    focusNode: brandFocusNode,
                    isExpanded: true,
                    underline: const SizedBox(),
                    icon: const Icon(IconlyLight.arrow_down_2),
                    dropdownColor: Colors.white,
                    // value: _yearValue,
                    value: _brandCar,
                    hint: Text(
                      _brandCar ?? "brand".tr(context),
                      style: const TextStyle(
                        color: AppColor.kSilver,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    items: AppConstants.brandDropDownList(),
                    onChanged: (value) {
                      setState(() {
                        _brandCar = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                    height: _categoryAd == "مركبات للبيع" ||
                            _categoryAd == "استئجار المركبات"
                        ? 15
                        : 0),

                _categoryAd == "مركبات للبيع" ||
                        _categoryAd == "استئجار المركبات"
                    ? GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            AnimationNav.navigatorAnimation(
                              child: const CarFeaturesSelectionScreen(),
                            ),
                          );
                          FocusScope.of(context).unfocus();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 1),
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                            border: Border.all(
                              color: AppColor.kSilver.withOpacity(.2),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  selectedFeaturesText.isNotEmpty
                                      ? selectedFeaturesText
                                      : 'Select Car Features'.tr(context),
                                  style: TextStyle(
                                    color: selectedFeaturesText.isNotEmpty
                                        ? AppColor.kBlack
                                        : AppColor.kSilver,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const Icon(
                                IconlyLight.arrow_down_2,
                              ),
                            ],
                          ),
                        ),
                      )
                    : const SizedBox(),
                SizedBox(
                    height: _categoryAd == "مركبات للبيع" ||
                            _categoryAd == "استئجار المركبات"
                        ? 15
                        : 0),

                _categoryAd == "مركبات للبيع" ||
                        _categoryAd == "استئجار المركبات"
                    ? Row(
                        children: [
                          Expanded(
                            child: CustomDropdown(
                              child: DropdownButton(
                                isExpanded: true,
                                underline: const SizedBox(),
                                icon: const Icon(IconlyLight.arrow_down_2),
                                dropdownColor: Colors.white,
                                // value: _yearValue,
                                value: _colorCar,
                                hint: Text(
                                  _colorCar ?? "Color".tr(context),
                                  style: const TextStyle(
                                    color: AppColor.kSilver,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),

                                items: AppConstants.colorDropDownList(),
                                onChanged: (value) {
                                  setState(() {
                                    _colorCar = value;
                                  });
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: CustomDropdown(
                              child: DropdownButton(
                                isExpanded: true,
                                underline: const SizedBox(),
                                icon: const Icon(IconlyLight.arrow_down_2),
                                dropdownColor: Colors.white,
                                // value: _yearValue,
                                value: kilometer,
                                hint: Text(
                                  kilometer ?? "kilometer".tr(context),
                                  style: const TextStyle(
                                    color: AppColor.kSilver,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),

                                items: AppConstants.kilometerListDropDown(),
                                onChanged: (value) {
                                  setState(() {
                                    kilometer = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
                const SizedBox(height: 15),
                TextFormFieldDescription(
                  onFieldSubmitted: (p0) {
                    FocusScope.of(context)
                        .requestFocus(switchReservationFocusNode);
                  },
                  readOnly: isEditing,
                  descriptionController: descriptionController,
                  key: const ValueKey("Description"),
                  descriptionFocusNode: descriptionFocusNode,
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Add a reservation'.tr(context),
                      style: AppStyles.semiBold16,
                    ),
                    Switch(
                      focusNode: switchReservationFocusNode,
                      activeTrackColor: Colors.green,
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: Colors.red,
                      value: isReservation,
                      onChanged: (value) {
                        setState(() {
                          isReservation = value;
                        });
                      },
                    ),
                  ],
                ),
                // const SizedBox(
                //   height: 450,
                //   child: SpecificationSelector(),
                // ),
                const SizedBox(height: 15),
                isEditing
                    ? CustomButton(
                        title: "Delete Product".tr(context),
                        onPressed: () async {
                          AlertDialogMethods.showDialogWaring(
                            context: context,
                            isError: false,
                            subtitle: "Do you want to delete this product"
                                .tr(context),
                            titleBottom: "Delete".tr(context),
                            lottileAnimation: Assets.imagesDelete,
                            function: () {
                              productProvider.deleteProductFromFirestore(
                                  context, widget.productsModel!.productsId);
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            },
                          );
                        },
                      )
                    : CustomButton(
                        title: "Add Product".tr(context),
                        onPressed: () async {
                          if (productNameController.text.isEmpty ||
                              descriptionController.text.isEmpty ||
                              priceController.text.isEmpty ||
                              _brandCar == null ||
                              _modelValue == null ||
                              _categoryAd == null) {
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
                              // ignore: use_build_context_synchronously
                              context,
                              downloadURLs,
                              productNameController,
                              priceController,
                              descriptionController,
                              discountController,
                              _brandCar,
                              _modelValue,
                              isReservation,
                              _categoryAd,
                              _colorCar,
                              kilometer,
                            );
                            productNameController.clear();
                            priceController.clear();
                            descriptionController.clear();
                            discountController.clear();
                            _modelValue = null;
                            _brandCar = null;
                            _categoryAd = null;
                            productNetworkImage.clear();
                            productProvider.selectedImages.clear();

                            if (!context.mounted) return;
                            AlertDialogMethods.showDialogForgotPassword(
                              context: context,
                              subtitle: "Add product successfully".tr(context),
                              titleBottom: "OK",
                              lottileAnimation: Assets.imagesDone,
                              function: () {
                                Navigator.of(context).pop();
                              },
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
