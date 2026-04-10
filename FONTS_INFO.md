# الخطوط المستخدمة في التطبيق

تم تحديث التطبيق لاستخدام خطوط احترافية من Google Fonts تدعم اللغة العربية بشكل ممتاز.

## الخطوط الرئيسية

### 1. Tajawal (تجوال)
- **الاستخدام**: العناوين الكبيرة والشعار
- **المميزات**: خط عربي حديث وأنيق، مثالي للعناوين
- **الأوزان**: 700, 800

### 2. Cairo (القاهرة)
- **الاستخدام**: العناوين المتوسطة والصغيرة، الأزرار
- **المميزات**: خط عربي واضح ومقروء، احترافي جداً
- **الأوزان**: 600, 700

### 3. IBM Plex Sans Arabic
- **الاستخدام**: النصوص العادية والفقرات
- **المميزات**: خط احترافي من IBM، ممتاز للقراءة الطويلة
- **الأوزان**: 400, 500

## كيفية الاستخدام

تم إنشاء ملف `lib/utils/app_theme.dart` الذي يحتوي على جميع أنماط الخطوط المعرفة مسبقاً:

```dart
import '../../../utils/app_theme.dart';

// للعناوين الكبيرة
Text('عنوان', style: AppTheme.heroTitle)

// للعناوين المتوسطة
Text('عنوان', style: AppTheme.sectionTitle)

// للعناوين الصغيرة
Text('عنوان', style: AppTheme.cardTitle)

// للنصوص العادية
Text('نص', style: AppTheme.bodyText)

// للأزرار
Text('زر', style: AppTheme.buttonText)

// للشعار
Text('وصلة', style: AppTheme.logoText)
```

## الملفات المحدثة

- ✅ `lib/utils/app_theme.dart` - ملف الخطوط الجديد
- ✅ `lib/theme/app_theme.dart` - Theme الرئيسي
- ✅ `lib/screens/home/sections/header_section.dart`
- ✅ `lib/screens/home/sections/hero_section.dart`
- ✅ `lib/screens/home/sections/how_it_works_section.dart`
- ✅ `lib/screens/home/sections/features_section.dart`
- ✅ `lib/screens/home/sections/for_providers_section.dart`
- ✅ `lib/screens/home/sections/cta_section.dart`
- ✅ `lib/screens/home/sections/footer_section.dart`
- ✅ `lib/screens/home/sections/app_preview_section.dart`
- ✅ `lib/screens/home/widgets/waitlist_dialog.dart`

## المزايا

1. **دعم ممتاز للعربية**: جميع الخطوط مصممة خصيصاً للغة العربية
2. **احترافية عالية**: خطوط من Google Fonts و IBM
3. **قابلية القراءة**: خطوط واضحة ومريحة للعين
4. **تناسق**: نظام موحد للخطوط في كل التطبيق
5. **سهولة الصيانة**: جميع الأنماط في مكان واحد

## ملاحظات

- الخطوط يتم تحميلها تلقائياً من Google Fonts
- لا حاجة لإضافة ملفات خطوط يدوياً
- يمكن تخصيص الأحجام والأوزان حسب الحاجة باستخدام `.copyWith()`
