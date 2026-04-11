-- Create waitlist table for storing email subscriptions
CREATE TABLE IF NOT EXISTS waitlist (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  email TEXT NOT NULL UNIQUE,
  user_type TEXT NOT NULL DEFAULT 'student',
  email_sent BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create index for faster email lookups
CREATE INDEX IF NOT EXISTS idx_waitlist_email ON waitlist(email);

-- Enable Row Level Security
ALTER TABLE waitlist ENABLE ROW LEVEL SECURITY;

-- Policy: Allow anyone to insert (for signup)
CREATE POLICY "Allow public insert" ON waitlist
  FOR INSERT
  WITH CHECK (true);

-- Policy: Allow anyone to read (for admin - adjust in production)
CREATE POLICY "Allow public read" ON waitlist
  FOR SELECT
  USING (true);

-- Policy: Allow anyone to update (for marking emails as sent)
CREATE POLICY "Allow public update" ON waitlist
  FOR UPDATE
  USING (true);
