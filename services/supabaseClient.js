/**
 * Supabase Client Configuration
 * Using Supabase JS Client for connecting to the backend
 */

// Supabase configuration
const SUPABASE_URL = 'https://hmgisljihrsztskvmbfd.supabase.co';
const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhtZ2lzbGppaHJzenRza3ZtYmZkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzQ1MzI4NzksImV4cCI6MjA1MDEwODg3OX0.sb_publishable_-ZiqWMN8A8uZdjO6S0prlQ_6GVN6my8';

// Initialize Supabase client
let supabase;

async function initSupabase() {
    try {
        if (typeof window.supabase === 'undefined') {
            throw new Error('Supabase library not loaded. Please check your internet connection.');
        }
        
        if (!supabase) {
            supabase = window.supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);
            console.log('Supabase client initialized successfully');
        }
        
        return supabase;
    } catch (error) {
        console.error('Failed to initialize Supabase:', error);
        throw error;
    }
}

// Waitlist service functions
const waitlistService = {
  /**
   * Add a new user to the waitlist
   * @param {string} email - User's email address
   * @param {string} userType - Type of user (student, trainer, university, etc.)
   * @returns {Promise} - Result of the insert operation
   */
  async addToWaitlist(email, userType) {
    try {
      if (!supabase) await initSupabase();
      
      console.log('Adding to waitlist:', { email, userType });
      
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
        throw error;
      }
      
      console.log('Successfully added to waitlist:', data);
      return { success: true, data };
    } catch (error) {
      console.error('Error adding to waitlist:', error);
      
      // رسائل خطأ مفصلة
      if (error.code === '23505') {
        throw new Error('هذا البريد الإلكتروني مسجل مسبقاً');
      } else if (error.message.includes('JWT')) {
        throw new Error('خطأ في الاتصال بقاعدة البيانات. يرجى التحقق من إعدادات Supabase');
      } else if (error.message.includes('relation')) {
        throw new Error('جدول قائمة الانتظار غير موجود. يرجى إنشاؤه في Supabase');
      }
      
      throw error;
    }
  },

  /**
   * Check if an email already exists in the waitlist
   * @param {string} email - Email to check
   * @returns {Promise<boolean>} - True if email exists
   */
  async checkEmailExists(email) {
    if (!supabase) await initSupabase();
    
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
   * @returns {Promise<Array>} - Array of waitlist entries
   */
  async getWaitlist() {
    if (!supabase) await initSupabase();
    
    try {
      const { data, error } = await supabase
        .from('waitlist')
        .select('*')
        .order('created_at', { ascending: false });
      
      if (error) throw error;
      return data;
    } catch (error) {
      console.error('Error fetching waitlist:', error);
      throw error;
    }
  },

  /**
   * Mark an email as sent (for admin)
   * @param {string} id - Entry ID
   * @returns {Promise} - Result of the update operation
   */
  async markEmailAsSent(id) {
    if (!supabase) await initSupabase();
    
    try {
      const { data, error } = await supabase
        .from('waitlist')
        .update({
          email_sent: true,
          email_sent_at: new Date().toISOString()
        })
        .eq('id', id);
      
      if (error) throw error;
      return { success: true, data };
    } catch (error) {
      console.error('Error marking email as sent:', error);
      throw error;
    }
  }
};

// Export for global use
window.waitlistService = waitlistService;
window.initSupabase = initSupabase;
 