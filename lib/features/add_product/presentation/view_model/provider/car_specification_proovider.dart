import 'package:car_vendor/features/add_product/presentation/view_model/model/car_specification_model.dart';
import 'package:flutter/material.dart';

class CarFeaturesProvider with ChangeNotifier {
  List<CarFeature> allCarFeatures = [
    CarFeature(name: 'أنظمة المساعدة على القيادة'),
    CarFeature(name: 'أجهزة استشعار وقوف السيارات'),
    CarFeature(name: 'أربعة أبواب'),
    CarFeature(name: 'أضواء النهار'),
    CarFeature(name: 'أضواء زينون'),
    CarFeature(name: 'أضواء ليد'),
    CarFeature(name: 'أنظمة الملاحة'),
    CarFeature(name: 'إضاءة داخلية'),
    CarFeature(name: 'إضاءة مخفية'),
    CarFeature(name: 'إصلاحات الطوارئ'),
    CarFeature(name: 'إنذار ضد السرقة'),
    CarFeature(name: 'باب خلفي كهربائي'),
    CarFeature(name: 'باقة الأمان'),
    CarFeature(name: 'تدفئة المرايا الجانبية'),
    CarFeature(name: 'تدفئة المقاعد الأمامية'),
    CarFeature(name: 'تدفئة المقاعد الخلفية'),
    CarFeature(name: 'تبريد المقاعد'),
    CarFeature(name: 'تحكم آلي بالمناخ'),
    CarFeature(name: 'تحكم الصوت من المقود'),
    CarFeature(name: 'تزيين داخلي خشبي'),
    CarFeature(name: 'تعديل مقعد السائق كهربائياً'),
    CarFeature(name: 'تعديل مقعد الراكب كهربائياً'),
    CarFeature(name: 'تعديل وضعية المقود'),
    CarFeature(name: 'تعديل كهربائي للمرايا'),
    CarFeature(name: 'جنوط رياضية'),
    CarFeature(name: 'حساسات الاصطفاف الأمامية'),
    CarFeature(name: 'حساسات الاصطفاف الخلفية'),
    CarFeature(name: 'حزام أمان ثلاثي النقاط'),
    CarFeature(name: 'حامل أكواب'),
    CarFeature(name: 'حامل حقائب'),
    CarFeature(name: 'دخول ذكي بدون مفتاح'),
    CarFeature(name: 'دفع رباعي'),
    CarFeature(name: 'رادار التنبيه من الاصطدام'),
    CarFeature(name: 'زجاج حراري'),
    CarFeature(name: 'ستائر جانبية'),
    CarFeature(name: 'سقف بانورامي'),
    CarFeature(name: 'سقف قابل للطي'),
    CarFeature(name: 'شاشة تعمل باللمس'),
    CarFeature(name: 'شاشة عرض معلومات'),
    CarFeature(name: 'شاحن لاسلكي'),
    CarFeature(name: 'شاشة ملاحة'),
    CarFeature(name: 'شاشة عرض رأسية'),
    CarFeature(name: 'صندوق تبريد'),
    CarFeature(name: 'فرش جلد'),
    CarFeature(name: 'فرش مخملي'),
    CarFeature(name: 'فتحات تكييف خلفية'),
    CarFeature(name: 'قفل مركزي للأبواب'),
    CarFeature(name: 'كاميرا خلفية'),
    CarFeature(name: 'كاميرات محيطية'),
    CarFeature(name: 'ماكينة القهوة'),
    CarFeature(name: 'مقاعد رياضية'),
    CarFeature(name: 'مقاعد قابلة للطي'),
    CarFeature(name: 'مقاعد كهربائية'),
    CarFeature(name: 'مقاعد مساج'),
    CarFeature(name: 'مقود رياضي'),
    CarFeature(name: 'مكيف أوتوماتيكي'),
    CarFeature(name: 'منبه النقطة العمياء'),
    CarFeature(name: 'نظام التشغيل بدون مفتاح'),
    CarFeature(name: 'نظام التحكم بالثبات'),
    CarFeature(name: 'نظام الكشف عن المشاة'),
    CarFeature(name: 'نظام المساعدة على النزول من المنحدرات'),
    CarFeature(name: 'نظام المكابح التلقائي'),
    CarFeature(name: 'نظام مراقبة ضغط الإطارات'),
    CarFeature(name: 'نظام توزيع قوة الفرامل'),
    CarFeature(name: 'نظام دفع أمامي'),
    CarFeature(name: 'نظام دفع خلفي'),
    CarFeature(name: 'نظام صوت محيطي'),
    CarFeature(name: 'واي فاي'),
  ];

  List<String> get selectedFeatureNames => allCarFeatures
      .where((feature) => feature.isSelected)
      .map((feature) => feature.name)
      .toList();

  void toggleFeatureSelection(int index) {
    allCarFeatures[index].isSelected = !allCarFeatures[index].isSelected;
    notifyListeners();
  }

  void clearSelectedFeatures() {
    selectedFeatureNames.clear();
    for (var feature in allCarFeatures) {
      feature.isSelected = false;
    }

    notifyListeners();
  }

  @override
  void dispose() {
    selectedFeatureNames.clear();
    super.dispose();
  }
}
