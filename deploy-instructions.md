# تعليمات النشر على Vercel

## الطريقة الأولى: عبر واجهة Vercel (موصى بها)

1. اذهب إلى https://vercel.com/signup
2. سجل دخول بحساب GitHub
3. اضغط "Add New Project"
4. اختر repository: `fahm99/wasla-landing-`
5. اضغط "Deploy"

## الطريقة الثانية: عبر CLI

### 1. تثبيت Vercel CLI
```bash
npm install -g vercel
```

### 2. تسجيل الدخول
```bash
vercel login
```

### 3. نشر المشروع
```bash
vercel
```

### 4. للنشر على الإنتاج
```bash
vercel --prod
```

## بعد النشر

سيكون موقعك متاحاً على رابط مثل:
- https://wasla-landing.vercel.app
- أو يمكنك ربط نطاق خاص بك

## ملاحظات مهمة

1. تأكد من تحديث بيانات Supabase في `services/supabaseClient.js`
2. تأكد من إعداد جدول `waitlist` في Supabase
3. تأكد من تفعيل Row Level Security في Supabase

## الميزات المجانية في Vercel

- نطاق فرعي مجاني (.vercel.app)
- SSL مجاني
- نشر تلقائي عند كل push
- 100 GB Bandwidth شهرياً
- غير محدود من المشاريع

## روابط مفيدة

- لوحة تحكم Vercel: https://vercel.com/dashboard
- توثيق Vercel: https://vercel.com/docs
- دعم Vercel: https://vercel.com/support
