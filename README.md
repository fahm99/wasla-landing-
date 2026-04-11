# Wasla (وصلة) - Landing Page

منصة تعليمية تربط بين الطلاب والمدربين في بيئة احترافية

## 🚀 المميزات

- تصميم متجاوب بالكامل (Fully Responsive)
- دعم اللغة العربية (RTL)
- تكامل مع Supabase
- لوحة تحكم للإدارة
- نظام قائمة انتظار

## 🛠️ التقنيات المستخدمة

- Next.js 16 (App Router)
- TypeScript
- Supabase (Backend)
- Font Awesome Icons
- Google Fonts (Cairo, Tajawal, IBM Plex Sans Arabic)

## 📦 التثبيت والتشغيل

### متطلبات التشغيل

- Node.js 18+
- حساب Supabase (للباكيند)

### خطوات التشغيل المحلي

1. استنساخ المشروع:
```bash
git clone https://github.com/fahm99/wasla-next.git
cd wasla-next
```

2. تثبيت المتطلبات:
```bash
npm install
```

3. إعداد المتغيرات البيئية:
```bash
cp .env.local .env
# ثم قم بتحديث المتغيرات في الملف
```

4. تشغيل السيرفر:
```bash
npm run dev
```

5. افتح http://localhost:3000

## 🗄️ إعداد Supabase

### إنشاء جدول waitlist

```sql
CREATE TABLE waitlist (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  email TEXT NOT NULL UNIQUE,
  user_type TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  email_sent BOOLEAN DEFAULT FALSE,
  email_sent_at TIMESTAMP WITH TIME ZONE
);

-- إضافة Row Level Security
ALTER TABLE waitlist ENABLE ROW LEVEL SECURITY;

-- السماح بالقراءة والكتابة للجميع
CREATE POLICY "Enable read access for all users" ON waitlist
  FOR SELECT USING (true);

CREATE POLICY "Enable insert access for all users" ON waitlist
  FOR INSERT WITH CHECK (true);

CREATE POLICY "Enable update access for all users" ON waitlist
  FOR UPDATE USING (true);
```

### المتغيرات البيئية المطلوبة

```env
NEXT_PUBLIC_SUPABASE_URL=your_supabase_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key
```

## 📱 الصفحات

- **الصفحة الرئيسية** (`/`): صفحة الهبوط الرئيسية
- **لوحة الإدارة** (`/admin`): إدارة قائمة الانتظار

## 🚀 النشر على Vercel

```bash
# تسجيل الدخول
vercel login

# نشر
vercel

# نشر للإنتاج
vercel --prod
```

## 🎨 التصميم

التصميم يتبع Material Design 3 مع دعم كامل للغة العربية:
- نظام ألوان متناسق
- خطوط عربية احترافية
- تجاوب كامل مع جميع الشاشات (360px - 1920px+)

## 📄 الترخيص

هذا المشروع مرخص تحت MIT License

## 👥 المساهمة

نرحب بالمساهمات! يرجى فتح Issue أو Pull Request

## 📞 التواصل

للاستفسارات والدعم، يرجى التواصل عبر GitHub Issues
