-- إنشاء جدول قائمة الانتظار
create table public.waitlist (
  id uuid default gen_random_uuid() primary key,
  email text not null unique,
  user_type text not null,
  created_at timestamp with time zone default timezone('utc'::text, now()) not null,
  email_sent boolean default false,
  email_sent_at timestamp with time zone
);

-- إضافة فهارس
create index idx_waitlist_email on public.waitlist(email);
create index idx_waitlist_created_at on public.waitlist(created_at desc);

-- تفعيل RLS (Row Level Security)
alter table public.waitlist enable row level security;

-- سياسة السماح بإدراج البيانات للجميع
create policy "Allow insert for everyone" on public.waitlist
  for insert with check (true);

-- سياسة السماح بالقراءة فقط للمستخدمين المسجلين (للأدمن)
create policy "Allow select for authenticated users" on public.waitlist
  for select using (auth.role() = 'authenticated');

-- سياسة السماح بالتحديث للمستخدمين المسجلين فقط
create policy "Allow update for authenticated users" on public.waitlist
  for update using (auth.role() = 'authenticated');
