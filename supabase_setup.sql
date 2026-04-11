-- إنشاء جدول قائمة الانتظار
CREATE TABLE IF NOT EXISTS waitlist (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  email TEXT NOT NULL UNIQUE,
  user_type TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  email_sent BOOLEAN DEFAULT FALSE,
  email_sent_at TIMESTAMP WITH TIME ZONE
);

-- إنشاء فهرس للبريد الإلكتروني لتسريع البحث
CREATE INDEX IF NOT EXISTS idx_waitlist_email ON waitlist(email);

-- إنشاء فهرس لتاريخ الإنشاء
CREATE INDEX IF NOT EXISTS idx_waitlist_created_at ON waitlist(created_at DESC);

-- تفعيل Row Level Security
ALTER TABLE waitlist ENABLE ROW LEVEL SECURITY;

-- حذف السياسات القديمة إن وجدت
DROP POLICY IF EXISTS "Enable read access for all users" ON waitlist;
DROP POLICY IF EXISTS "Enable insert access for all users" ON waitlist;
DROP POLICY IF EXISTS "Enable update access for all users" ON waitlist;

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

-- عرض البيانات
SELECT * FROM waitlist ORDER BY created_at DESC;
