# إعداد GitHub Pages

تم رفع المشروع بنجاح! الآن اتبع الخطوات التالية لتفعيل GitHub Pages:

## الخطوات:

### 1. الذهاب إلى إعدادات المستودع
- افتح المستودع: https://github.com/fahm99/wasla-landing-
- اضغط على **Settings** (الإعدادات)

### 2. تفعيل GitHub Pages
- في القائمة الجانبية، اضغط على **Pages**
- في قسم **Source**:
  - اختر **GitHub Actions** من القائمة المنسدلة
  
### 3. تشغيل الـ Workflow
- اذهب إلى تبويب **Actions** في المستودع
- سترى workflow اسمه "Deploy to GitHub Pages"
- اضغط على **Run workflow** إذا لم يبدأ تلقائياً

### 4. الانتظار حتى ينتهي البناء
- سيستغرق البناء حوالي 2-3 دقائق
- عند الانتهاء، سيظهر علامة ✓ خضراء

### 5. الوصول للموقع
بعد اكتمال البناء، سيكون الموقع متاحاً على:
```
https://fahm99.github.io/wasla-landing-/
```

## ملاحظات مهمة:

### إذا واجهت مشكلة في الـ Permissions:
1. اذهب إلى **Settings** > **Actions** > **General**
2. في قسم **Workflow permissions**:
   - اختر **Read and write permissions**
   - فعّل **Allow GitHub Actions to create and approve pull requests**
3. احفظ التغييرات

### لتحديث الموقع:
كل مرة تقوم بعمل push للـ main branch، سيتم بناء ونشر الموقع تلقائياً!

```bash
git add .
git commit -m "تحديث الموقع"
git push
```

## التحقق من الحالة:
- تبويب **Actions**: لمتابعة حالة البناء
- تبويب **Settings > Pages**: لرؤية رابط الموقع المباشر

## الملفات المهمة:
- `.github/workflows/deploy.yml` - ملف الـ CI/CD
- `build/web/` - ملفات الموقع المبنية
- `.nojekyll` - لتعطيل Jekyll في GitHub Pages

---

✅ تم إعداد كل شيء بنجاح!
🚀 الموقع جاهز للنشر!
