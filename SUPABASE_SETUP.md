# إعداد Supabase لمشروع Wasla

## 📋 الخطوات المطلوبة

### 1. إنشاء حساب Supabase (إذا لم يكن لديك)

1. اذهب إلى: https://supabase.com
2. اضغط "Start your project"
3. سجل دخول بحساب GitHub

### 2. إنشاء مشروع جديد (أو استخدام المشروع الحالي)

المشروع الحالي:
- URL: `https://hmgisljihrsztskvmbfd.supabase.co`
- Project ID: `hmgisljihrsztskvmbfd`

### 3. إنشاء جدول قائمة الانتظار

#### الطريقة الأولى: عبر SQL Editor (موصى بها)

1. اذهب إلى لوحة تحكم Supabase
2. اضغط على "SQL Editor" من القائمة الجانبية
3. اضغط "New query"
4. انسخ والصق الكود من ملف `supabase_setup.sql`
5. اضغط "Run" أو اضغط `Ctrl+Enter`

#### الطريقة الثانية: عبر Table Editor

1. اذهب إلى "Table Editor"
2. اضغط "Create a new table"
3. اسم الجدول: `waitlist`
4. أضف الأعمدة التالية:

| Column Name | Type | Default Value | Extra |
|------------|------|---------------|-------|
| id | uuid | gen_random_uuid() | Primary Key |
| email | text | - | Unique, Not Null |
| user_type | text | - | Not Null |
| created_at | timestamptz | now() | - |
| email_sent | boolean | false | - |
| email_sent_at | timestamptz | - | Nullable |

### 4. تفعيل Row Level Security (RLS)

#### عبر SQL Editor:

```sql
-- تفعيل RLS
ALTER TABLE waitlist ENABLE ROW LEVEL SECURITY;

-- السماح بالقراءة للجميع
CREATE POLICY "Enable read access for all users" 
ON waitlist FOR SELECT 
USING (true);

-- السماح بالإضافة للجميع
CREATE POLICY "Enable insert access for all users" 
ON waitlist FOR INSERT 
WITH CHECK (true);

-- السماح بالتحديث للجميع
CREATE POLICY "Enable update access for all users" 
ON waitlist FOR UPDATE 
USING (true);
```

#### عبر الواجهة:

1. اذهب إلى "Authentication" > "Policies"
2. اختر جدول `waitlist`
3. اضغط "New Policy"
4. اختر "Enable read access for all users"
5. كرر للـ INSERT و UPDATE

### 5. الحصول على مفاتيح API

1. اذهب إلى "Settings" > "API"
2. ستجد:
   - **Project URL**: `https://hmgisljihrsztskvmbfd.supabase.co`
   - **anon public key**: انسخه

### 6. تحديث المفاتيح في الكود

افتح ملف `services/supabaseClient.js` وتأكد من:

```javascript
const SUPABASE_URL = 'https://hmgisljihrsztskvmbfd.supabase.co';
const SUPABASE_ANON_KEY = 'YOUR_ANON_KEY_HERE'; // ضع المفتاح الصحيح هنا
```

⚠️ **مهم جداً**: تأكد من نسخ المفتاح الكامل بدون أي مسافات أو أحرف إضافية!

### 7. اختبار الاتصال

1. افتح الموقع: https://wasla-landing.vercel.app
2. افتح Console في المتصفح (F12)
3. حاول التسجيل في قائمة الانتظار
4. تحقق من الرسائل في Console

## 🔍 استكشاف الأخطاء

### الخطأ: "JWT expired" أو "Invalid API key"

**الحل:**
1. اذهب إلى Supabase Dashboard
2. Settings > API
3. انسخ `anon public` key الجديد
4. حدّث `SUPABASE_ANON_KEY` في `services/supabaseClient.js`

### الخطأ: "relation waitlist does not exist"

**الحل:**
- الجدول غير موجود، قم بإنشائه باستخدام `supabase_setup.sql`

### الخطأ: "new row violates row-level security policy"

**الحل:**
1. تأكد من تفعيل RLS policies
2. تأكد من إضافة policy للـ INSERT

### الخطأ: "duplicate key value violates unique constraint"

**الحل:**
- البريد الإلكتروني مسجل مسبقاً (هذا طبيعي)

## ✅ التحقق من نجاح الإعداد

### 1. اختبار الإضافة

```javascript
// في Console المتصفح
await waitlistService.addToWaitlist('test@example.com', 'student');
```

### 2. اختبار القراءة

```javascript
// في Console المتصفح
await waitlistService.getWaitlist();
```

### 3. عرض البيانات في Supabase

1. اذهب إلى "Table Editor"
2. اختر جدول `waitlist`
3. يجب أن ترى البيانات المضافة

## 📊 مراقبة الاستخدام

- اذهب إلى "Settings" > "Usage"
- تحقق من:
  - Database size
  - API requests
  - Bandwidth

الخطة المجانية تشمل:
- 500 MB Database
- 2 GB Bandwidth
- 50,000 Monthly Active Users

## 🔐 الأمان

### ملاحظات مهمة:

1. ✅ المفتاح `anon public` آمن للاستخدام في الواجهة الأمامية
2. ✅ RLS يحمي البيانات حتى مع المفتاح العام
3. ⚠️ لا تشارك `service_role` key أبداً
4. ⚠️ لا تضع `service_role` key في الكود

## 📝 الخطوات التالية

بعد إعداد Supabase بنجاح:

1. ✅ اختبر التسجيل في قائمة الانتظار
2. ✅ اختبر لوحة الإدارة
3. ✅ تحقق من البيانات في Supabase
4. ⏳ إعداد Email notifications (اختياري)
5. ⏳ إضافة Analytics (اختياري)

## 🆘 الدعم

إذا واجهت أي مشاكل:

1. تحقق من Console في المتصفح (F12)
2. تحقق من Logs في Supabase Dashboard
3. راجع التوثيق: https://supabase.com/docs

---

تم إعداد الدليل بنجاح! 🎉
