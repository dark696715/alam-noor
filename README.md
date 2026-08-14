# 🌟 عالم نور (Alam Noor)

تطبيق تعليمي تفاعلي وجذاب للأطفال من السنة التحضيرية إلى السنة الخامسة ابتدائي.

## المميزات الحالية (النسخة الأولى)

✅ شاشة افتتاحية سحرية جذابة  
✅ اختيار المستوى الدراسي (تحضيري → 5)  
✅ اختيار الشخصية / البطل  
✅ إدخال اسم الطفل  
✅ الصفحة الرئيسية مع نظام النجوم والمستويات  
✅ 6 عوالم معرفية ملونة:
   - عالم الحروف (العربية)
   - قلعة الأرقام (الرياضيات)
   - مختبر العلوم
   - مدينة الفرنسية
   - حديقة الإيمان
   - رحلة التاريخ
✅ شاشة تفاصيل كل عالم مع أنشطة  
✅ تمارين تفاعلية مع أسئلة متعددة الخيارات  
✅ نظام نقاط ونجوم وكونفيتي عند النجاح  
✅ تصميم RTL كامل باللغة العربية  
✅ رسوم متحركة سلسة (flutter_animate)

## التقنيات المستخدمة

- **Flutter** + Dart
- **Provider** لإدارة الحالة
- **google_fonts** (خط Cairo)
- **flutter_animate** للحركات
- **confetti** للاحتفال

## كيفية التشغيل

1. تأكد من تثبيت Flutter SDK (3.16+)
2. انسخ المجلد إلى جهازك
3. نفذ الأوامر:

```bash
cd alam_noor
flutter pub get
flutter run
```

## الخطوات القادمة المقترحة

- [ ] إضافة محتوى حقيقي (كتب + فيديوهات)
- [ ] تمارين كتابة الحروف باللمس
- [ ] نظام الصوت والتشجيع الصوتي
- [ ] لوحة تحكم للوالدين
- [ ] حفظ التقدم محلياً (Hive / SharedPreferences)
- [ ] ربط Firebase
- [ ] شخصيات متحركة بـ Rive أو Lottie
- [ ] ألعاب ذاكرة ومطابقة
- [ ] وضع غير متصل بالإنترنت كامل

## هيكل المشروع

```
lib/
├── main.dart
├── theme/
│   └── app_theme.dart
├── models/
│   ├── character.dart
│   ├── subject_world.dart
│   └── user_progress.dart
├── services/
│   └── progress_provider.dart
└── screens/
    ├── onboarding/
    │   ├── splash_screen.dart
    │   ├── welcome_screen.dart
    │   ├── grade_selection_screen.dart
    │   └── character_selection_screen.dart
    ├── home/
    │   └── home_screen.dart
    ├── worlds/
    │   └── world_detail_screen.dart
    └── exercises/
        └── exercise_screen.dart
```

---

صُمم بحب للأطفال ❤️  
عالم نور - مغامرة التعلم السحرية
