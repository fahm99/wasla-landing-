# Wasla (وصلة) - Landing Page

منصة تعليمية تربط بين الطلاب والمدربين في بيئة احترافية

## 🚀 المميزات

- تصميم متجاوب بالكامل (Fully Responsive)
- دعم اللغة العربية (RTL)
- تكامل مع Supabase
- لوحة تحكم للإدارة
- نظام قائمة انتظار

## 🛠️ التقنيات المستخدمة

- HTML5
- CSS3 (Custom Properties)
- Vanilla JavaScript
- Supabase (Backend)
- Font Awesome Icons
- Google Fonts (Cairo, Tajawal, IBM Plex Sans Arabic)

## 📦 التثبيت والتشغيل

### متطلبات التشغيل
- متصفح ويب حديث
- حساب Supabase (للباكيند)

### خطوات التشغيل المحلي

1. استنساخ المشروع:
```bash
git clone https://github.com/fahm99/wasla-landing-.git
cd wasla-landing-
```

2. افتح ملف `index.html` في المتصفح

أو استخدم خادم محلي:
```bash
# باستخدام Python
python -m http.server 8000

# باستخدام Node.js
npx serve
```

## 🗄️ إعداد قاعدة البيانات

قم بإنشاء جدول `waitlist` في Supabase:

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

## 🔧 التكوين

قم بتحديث بيانات Supabase في ملف `services/supabaseClient.js`:

```javascript
const SUPABASE_URL = 'YOUR_SUPABASE_URL';
const SUPABASE_ANON_KEY = 'YOUR_SUPABASE_ANON_KEY';
```

## 📱 الصفحات

- **الصفحة الرئيسية** (`index.html`): صفحة الهبوط الرئيسية
- **لوحة الإدارة** (`pages/admin.html`): إدارة قائمة الانتظار

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
