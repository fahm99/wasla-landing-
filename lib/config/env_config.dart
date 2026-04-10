class EnvConfig {
  // ⚠️ ملاحظة: هذه المفاتيح العامة (Public Keys) آمنة للنشر
  // Supabase Anon Key مصمم ليكون عاماً ويعمل مع Row Level Security (RLS)

  static const String supabaseUrl = 'https://hmgisljihrsztskvmbfd.supabase.co';
  static const String supabaseAnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhtZ2lzbGppaHJzenRza3ZtYmZkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzQ1MzI4NzksImV4cCI6MjA1MDEwODg3OX0.sb_publishable_-ZiqWMN8A8uZdjO6S0prlQ_6GVN6my8';

  // للتطوير المحلي، يمكن استخدام .env
  static bool get isProduction => const bool.fromEnvironment('dart.vm.product');
}
