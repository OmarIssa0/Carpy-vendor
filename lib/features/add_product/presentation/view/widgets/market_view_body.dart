import 'package:car_vendor/core/constant/my_const.dart';
import 'package:car_vendor/core/utils/app_color.dart';
import 'package:car_vendor/core/utils/size_config.dart';
import 'package:car_vendor/core/widgets/custom_button.dart';
import 'package:car_vendor/core/widgets/custom_text_filed.dart';
import 'package:car_vendor/features/add_product/presentation/view/widgets/custom_dropdown_button.dart';
import 'package:car_vendor/features/add_product/presentation/view/widgets/switch_reseration.dart';
import 'package:car_vendor/features/add_product/presentation/view/widgets/text_form_field_description.dart';
import 'package:car_vendor/features/add_product/presentation/view/widgets/upload_image_button.dart';
import 'package:car_vendor/features/lang/app_localization.dart';
import 'package:car_vendor/features/my_product/presentation/view_model/model/products_model.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';

class MarketViewBody extends StatefulWidget {
  const MarketViewBody({super.key, this.productsModel});

  final ProductsModel? productsModel;
  @override
  State<MarketViewBody> createState() => _MarketViewBodyState();
}

class _MarketViewBodyState extends State<MarketViewBody> {
  List productNetworkImage = [];
  final formKey = GlobalKey<FormState>();
  bool isEditing = false;
  String? _categoryValue;
  String? _modelValue;

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
  Future<void> pickImages() async {
    List<XFile>? result = await ImagePicker().pickMultiImage();
    selectedImages = result;
    setState(() {});
  }

  @override
  void initState() {
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
    return Form(
      key: formKey,
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
                onPressed: () {},
              ),
              const SizedBox(height: 45),
            ],
          ),
        ),
      ),
    );
  }
}
