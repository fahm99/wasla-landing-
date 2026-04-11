# إعداد GitHub Secrets لـ Supabase

## المشكلة
ملف `.env` يحتوي على بيانات Supabase الحساسة ولا يجب رفعه إلى GitHub.

## الحل: استخدام GitHub Secrets

### الخطوات:

#### 1. الذهاب إلى إعدادات المستودع
- افتح: https://github.com/fahm99/wasla-landing-
- اضغط على **Settings** (الإعدادات)

#### 2. إضافة Secrets
- في القائمة الجانبية، اضغط على **Secrets and variables** > **Actions**
- اضغط على **New repository secret**

#### 3. إضافة SUPABASE_URL
- **Name**: `SUPABASE_URL`
- **Secret**: `https://hmgisljihrsztskvmbfd.supabase.co`
- اضغط **Add secret**

#### 4. إضافة SUPABASE_ANON_KEY
- اضغط **New repository secret** مرة أخرى
- **Name**: `SUPABASE_ANON_KEY`
- **Secret**: `sb_publishable_-ZiqWMN8A8uZdjO6S0prlQ_6GVN6my8`
- اضغط **Add secret**

### كيف يعمل؟

عند تشغيل GitHub Actions، سيتم:
1. إنشاء ملف `.env` تلقائياً من الـ Secrets
2. بناء التطبيق مع البيانات الصحيحة
3. نشر الموقع على GitHub Pages

### التحقق:
بعد إضافة الـ Secrets:
1. اذهب إلى تبويب **Actions**
2. اضغط على **Run workflow** > **Run workflow**
3. انتظر حتى ينتهي البناء (2-3 دقائق)
4. الموقع سيكون متاحاً على: https://fahm99.github.io/wasla-landing-/

## ملاحظات مهمة:

### الأمان:
- ✅ الـ Secrets مشفرة ولا يمكن رؤيتها بعد إضافتها
- ✅ لا يتم رفع ملف `.env` إلى GitHub
- ✅ البيانات آمنة ومحمية

### للتطوير المحلي:
احتفظ بملف `.env` في جهازك المحلي فقط:
```env
SUPABASE_URL=https://hmgisljihrsztskvmbfd.supabase.co
SUPABASE_ANON_KEY=sb_publishable_-ZiqWMN8A8uZdjO6S0prlQ_6GVN6my8
```

### إذا غيرت بيانات Supabase:
1. حدّث الـ Secrets في GitHub
2. أعد تشغيل الـ workflow

---

✅ بهذه الطريقة، التطبيق سيعمل على GitHub Pages ويتصل بقاعدة البيانات بشكل آمن!
