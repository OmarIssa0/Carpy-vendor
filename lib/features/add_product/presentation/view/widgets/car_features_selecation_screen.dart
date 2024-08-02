// import 'package:car_vendor/core/utils/app_color.dart';
// import 'package:car_vendor/core/widgets/custom_text_filed.dart';
// import 'package:car_vendor/features/add_product/presentation/view_model/model/car_specification_model.dart';
// import 'package:car_vendor/features/lang/app_localization.dart';
// import 'package:flutter/material.dart';

// class CarFeaturesSelectionScreen extends StatefulWidget {
//   const CarFeaturesSelectionScreen({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _CarFeaturesSelectionScreenState createState() =>
//       _CarFeaturesSelectionScreenState();
// }

// class _CarFeaturesSelectionScreenState
//     extends State<CarFeaturesSelectionScreen> {
//   List<CarFeature> allCarFeatures = [
//     CarFeature(name: 'أنظمة المساعدة على القيادة'),
//     CarFeature(name: 'أجهزة استشعار وقوف السيارات'),
//     CarFeature(name: 'أربعة أبواب'),
//     CarFeature(name: 'أضواء النهار'),
//     CarFeature(name: 'أضواء زينون'),
//     CarFeature(name: 'أضواء ليد'),
//     CarFeature(name: 'أنظمة الملاحة'),
//     CarFeature(name: 'إضاءة داخلية'),
//     CarFeature(name: 'إضاءة مخفية'),
//     CarFeature(name: 'إصلاحات الطوارئ'),
//     CarFeature(name: 'إنذار ضد السرقة'),
//     CarFeature(name: 'باب خلفي كهربائي'),
//     CarFeature(name: 'باقة الأمان'),
//     CarFeature(name: 'تدفئة المرايا الجانبية'),
//     CarFeature(name: 'تدفئة المقاعد الأمامية'),
//     CarFeature(name: 'تدفئة المقاعد الخلفية'),
//     CarFeature(name: 'تبريد المقاعد'),
//     CarFeature(name: 'تحكم آلي بالمناخ'),
//     CarFeature(name: 'تحكم الصوت من المقود'),
//     CarFeature(name: 'تزيين داخلي خشبي'),
//     CarFeature(name: 'تعديل مقعد السائق كهربائياً'),
//     CarFeature(name: 'تعديل مقعد الراكب كهربائياً'),
//     CarFeature(name: 'تعديل وضعية المقود'),
//     CarFeature(name: 'تعديل كهربائي للمرايا'),
//     CarFeature(name: 'جنوط رياضية'),
//     CarFeature(name: 'حساسات الاصطفاف الأمامية'),
//     CarFeature(name: 'حساسات الاصطفاف الخلفية'),
//     CarFeature(name: 'حزام أمان ثلاثي النقاط'),
//     CarFeature(name: 'حامل أكواب'),
//     CarFeature(name: 'حامل حقائب'),
//     CarFeature(name: 'دخول ذكي بدون مفتاح'),
//     CarFeature(name: 'دفع رباعي'),
//     CarFeature(name: 'رادار التنبيه من الاصطدام'),
//     CarFeature(name: 'زجاج حراري'),
//     CarFeature(name: 'ستائر جانبية'),
//     CarFeature(name: 'سقف بانورامي'),
//     CarFeature(name: 'سقف قابل للطي'),
//     CarFeature(name: 'شاشة تعمل باللمس'),
//     CarFeature(name: 'شاشة عرض معلومات'),
//     CarFeature(name: 'شاحن لاسلكي'),
//     CarFeature(name: 'شاشة ملاحة'),
//     CarFeature(name: 'شاشة عرض رأسية'),
//     CarFeature(name: 'صندوق تبريد'),
//     CarFeature(name: 'فرش جلد'),
//     CarFeature(name: 'فرش مخملي'),
//     CarFeature(name: 'فتحات تكييف خلفية'),
//     CarFeature(name: 'قفل مركزي للأبواب'),
//     CarFeature(name: 'كاميرا خلفية'),
//     CarFeature(name: 'كاميرات محيطية'),
//     CarFeature(name: 'ماكينة القهوة'),
//     CarFeature(name: 'مقاعد رياضية'),
//     CarFeature(name: 'مقاعد قابلة للطي'),
//     CarFeature(name: 'مقاعد كهربائية'),
//     CarFeature(name: 'مقاعد مساج'),
//     CarFeature(name: 'مقود رياضي'),
//     CarFeature(name: 'مكيف أوتوماتيكي'),
//     CarFeature(name: 'منبه النقطة العمياء'),
//     CarFeature(name: 'نظام التشغيل بدون مفتاح'),
//     CarFeature(name: 'نظام التحكم بالثبات'),
//     CarFeature(name: 'نظام الكشف عن المشاة'),
//     CarFeature(name: 'نظام المساعدة على النزول من المنحدرات'),
//     CarFeature(name: 'نظام المكابح التلقائي'),
//     CarFeature(name: 'نظام مراقبة ضغط الإطارات'),
//     CarFeature(name: 'نظام توزيع قوة الفرامل'),
//     CarFeature(name: 'نظام دفع أمامي'),
//     CarFeature(name: 'نظام دفع خلفي'),
//     CarFeature(name: 'نظام صوت محيطي'),
//     CarFeature(name: 'واي فاي'),
//   ];

//   List<CarFeature> filteredCarFeatures = [];

//   String searchQuery = '';
//   late TextEditingController _searchController;

//   @override
//   void initState() {
//     super.initState();
//     filteredCarFeatures = allCarFeatures;
//     _searchController = TextEditingController();
//   }

//   @override
//   dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   void updateSearchQuery(String query) {
//     setState(() {
//       searchQuery = query;
//       filteredCarFeatures = allCarFeatures
//           .where((feature) =>
//               feature.name.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios_new_rounded),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: Text('Select Car Features'.tr(context)),
//       ),
//       body: SingleChildScrollView(
//         physics: const BouncingScrollPhysics(),
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: CustomTextFiled(
//                 controller: _searchController,
//                 title: "Search".tr(context),
//                 textInputType: TextInputType.text,
//                 onChanged: (value) {
//                   updateSearchQuery(value);
//                 },
//                 prefix: const Icon(Icons.search),
//                 suffixIcon: IconButton(
//                   icon: const Icon(
//                     Icons.clear,
//                     color: Colors.red,
//                   ),
//                   onPressed: () {
//                     searchQuery = '';
//                     _searchController.clear();
//                     updateSearchQuery('');
//                   },
//                 ),
//               ),
//             ),
//             // Expanded(
//             //   child: ListView.builder(
//             //     itemCount: filteredCarFeatures.length,
//             //     itemBuilder: (context, index) {
//             //       return CheckboxListTile(
//             //         title: Text(filteredCarFeatures[index].name),
//             //         value: filteredCarFeatures[index].isSelected,
//             //         onChanged: (bool? value) {
//             //           setState(() {
//             //             filteredCarFeatures[index].isSelected = value!;
//             //           });
//             //         },
//             //       );
//             //     },
//             //   ),
//             // ),
//             Column(
//               children: filteredCarFeatures.map((feature) {
//                 return CheckboxListTile(
//                   title: Text(feature.name),
//                   value: feature.isSelected,
//                   onChanged: (bool? value) {
//                     setState(() {
//                       feature.isSelected = value!;
//                     });
//                   },
//                 );
//               }).toList(),
//             ),
//             const SizedBox(height: 65)
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: AppColor.kBackGroundColorSplash,
//         onPressed: () {
//           // قم بتنفيذ العمليات اللازمة عند الضغط على الزر
//           List<CarFeature> selectedFeatures = filteredCarFeatures
//               .where((feature) => feature.isSelected)
//               .toList();
//           print(
//               'Selected Features: ${selectedFeatures.map((e) => e.name).join(', ')}');
//         },
//         child: const Icon(Icons.check, color: Colors.white),
//       ),
//     );
//   }
// }

import 'package:car_vendor/core/utils/app_color.dart';
import 'package:car_vendor/core/widgets/custom_text_filed.dart';
import 'package:car_vendor/features/add_product/presentation/view_model/provider/car_specification_proovider.dart';
import 'package:car_vendor/features/lang/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class CarFeaturesSelectionScreen extends StatefulWidget {
  const CarFeaturesSelectionScreen({super.key});

  @override
  _CarFeaturesSelectionScreenState createState() =>
      _CarFeaturesSelectionScreenState();
}

class _CarFeaturesSelectionScreenState
    extends State<CarFeaturesSelectionScreen> {
  late TextEditingController _searchController;

  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var carFeaturesProvider = Provider.of<CarFeaturesProvider>(context);

    var filteredCarFeatures = carFeaturesProvider.allCarFeatures
        .where((feature) =>
            feature.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Select Car Features'.tr(context)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child:
                //  TextField(
                //   decoration: const InputDecoration(
                //     labelText: 'Search',
                //     border: OutlineInputBorder(),
                //   ),
                //   onChanged: (value) {
                //     setState(() {
                //       searchQuery = value;
                //     });
                //   },
                // ),
                CustomTextFiled(
              controller: _searchController,
              title: 'Search'.tr(context),
              textInputType: TextInputType.text,
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              prefix: const Icon(IconlyLight.search),
              suffixIcon: IconButton(
                icon: const Icon(
                  Icons.clear,
                  color: Colors.red,
                ),
                onPressed: () {
                  searchQuery = '';
                  _searchController.clear();
                  setState(() {});
                },
              ),
              textInputAction: TextInputAction.search,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredCarFeatures.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  title: Text(filteredCarFeatures[index].name),
                  value: filteredCarFeatures[index].isSelected,
                  onChanged: (bool? value) {
                    carFeaturesProvider.toggleFeatureSelection(
                        carFeaturesProvider.allCarFeatures
                            .indexOf(filteredCarFeatures[index]));
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.kBackGroundColorSplash,
        onPressed: () {
          // يمكنك تنفيذ العمليات اللازمة عند الضغط على الزر
          List<String> selectedFeatures =
              carFeaturesProvider.selectedFeatureNames;
          Navigator.pop(context);
          // log('Selected Features: ${selectedFeatures.join(', ')}');
        },
        child: const Icon(Icons.check, color: Colors.white),
      ),
    );
  }
}
