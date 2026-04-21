import { createClient } from '@supabase/supabase-js';

// Supabase configuration - Use environment variables
// Provide fallback values for build time to prevent prerender errors
const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL || 'https://hmgisljihrsztskvmbfd.supabase.co';
const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhtZ2lzbGppaHJzenRza3ZtYmZkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzU1NjAyNjEsImV4cCI6MjA5MTEzNjI2MX0.Aunodx4B6O9hgSeEtJa3iKg9ydbxYK601kYUIINpr2g';

// Create and export the Supabase client
export const supabase = createClient(supabaseUrl, supabaseAnonKey);

// Waitlist service functions
export interface WaitlistEntry {
  id: string;
  email: string;
  user_type: string;
  created_at: string;
  email_sent: boolean;
  email_sent_at?: string;
}

export const waitlistService = {
  /**
   * Add a new user to the waitlist
   */
  async addToWaitlist(email: string, userType: string): Promise<{ success: boolean; data?: WaitlistEntry[]; error?: Error }> {
    try {
      const { data, error } = await supabase
        .from('waitlist')
        .insert([
          {
            email: email,
            user_type: userType,
            email_sent: false
          }
        ])
        .select();

      if (error) {
        console.error('Supabase error:', error);
        return { success: false, error: error as Error };
      }

      return { success: true, data: data as WaitlistEntry[] };
    } catch (error) {
      console.error('Error adding to waitlist:', error);
      return { success: false, error: error as Error };
    }
  },

  /**
   * Check if an email already exists in the waitlist
   */
  async checkEmailExists(email: string): Promise<boolean> {
    try {
      const { data, error } = await supabase
        .from('waitlist')
        .select('*')
        .eq('email', email)
        .maybeSingle();

      if (error) throw error;
      return data !== null;
    } catch (error) {
      console.error('Error checking email:', error);
      return false;
    }
  },

  /**
   * Get all waitlist entries (for admin)
   */
  async getWaitlist(): Promise<WaitlistEntry[]> {
    try {
      const { data, error } = await supabase
        .from('waitlist')
        .select('*')
        .order('created_at', { ascending: false });

      if (error) throw error;
      return data as WaitlistEntry[];
    } catch (error) {
      console.error('Error fetching waitlist:', error);
      throw error;
    }
  },

  /**
   * Mark an email as sent (for admin)
   */
  async markEmailAsSent(id: string): Promise<{ success: boolean; error?: Error }> {
    try {
      const { error } = await supabase
        .from('waitlist')
        .update({
          email_sent: true,
          email_sent_at: new Date().toISOString()
        })
        .eq('id', id);

      if (error) throw error;
      return { success: true };
    } catch (error) {
      console.error('Error marking email as sent:', error);
      return { success: false, error: error as Error };
    }
  }
};
