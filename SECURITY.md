# الأمان والخصوصية

## حول المفاتيح العامة (Public Keys)

### ✅ آمن للنشر:
- `SUPABASE_URL` - رابط المشروع العام
- `SUPABASE_ANON_KEY` - المفتاح العام (Anon Key)

هذه المفاتيح **مصممة** لتكون عامة ويمكن نشرها بأمان لأن:

1. **Row Level Security (RLS)**: Supabase يستخدم RLS لحماية البيانات
2. **الصلاحيات المحدودة**: Anon Key له صلاحيات محدودة جداً
3. **التحقق من الهوية**: يتم التحقق من كل عملية على مستوى قاعدة البيانات

### ⚠️ لا تنشر أبداً:
- `SUPABASE_SERVICE_ROLE_KEY` - المفتاح السري (Service Role Key)
- كلمات المرور
- المفاتيح الخاصة (Private Keys)

## إعدادات الأمان في Supabase

تأكد من تفعيل Row Level Security (RLS) على جدول `waitlist`:

```sql
-- تفعيل RLS
ALTER TABLE waitlist ENABLE ROW LEVEL SECURITY;

-- السماح بالإدراج للجميع (للتسجيل في قائمة الانتظار)
CREATE POLICY "Allow public insert" ON waitlist
  FOR INSERT
  TO anon
  WITH CHECK (true);

-- السماح بالقراءة للمسؤولين فقط
CREATE POLICY "Allow authenticated read" ON waitlist
  FOR SELECT
  TO authenticated
  USING (true);
```

## كيف يعمل النظام

1. **في التطوير المحلي**: يستخدم ملف `.env`
2. **في الإنتاج (GitHub Pages)**: يستخدم `lib/config/env_config.dart`
3. **الحماية**: RLS في Supabase يحمي البيانات

## التحقق من الأمان

- ✅ ملف `.env` في `.gitignore`
- ✅ RLS مفعل على جميع الجداول
- ✅ استخدام Anon Key فقط في الواجهة الأمامية
- ✅ التحقق من الصلاحيات على مستوى قاعدة البيانات

## للمزيد من المعلومات

راجع [Supabase Security Best Practices](https://supabase.com/docs/guides/auth/row-level-security)
