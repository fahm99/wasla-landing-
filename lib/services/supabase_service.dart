import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/waitlist_model.dart';

class SupabaseService {
  static final SupabaseClient _client = Supabase.instance.client;

  // إضافة مستخدم جديد للقائمة
  static Future<void> addToWaitlist(WaitlistEntry entry) async {
    try {
      await _client.from('waitlist').insert(entry.toJson());
    } catch (e) {
      throw Exception('فشل في إضافة المستخدم: $e');
    }
  }

  // جلب كل المنتظرين
  static Future<List<WaitlistEntry>> getWaitlist() async {
    try {
      final response = await _client
          .from('waitlist')
          .select()
          .order('created_at', ascending: false);

      return (response as List)
          .map((json) => WaitlistEntry.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('فشل في جلب البيانات: $e');
    }
  }

  // تحديث حالة إرسال الإيميل
  static Future<void> markEmailAsSent(String id) async {
    try {
      await _client.from('waitlist').update({
        'email_sent': true,
        'email_sent_at': DateTime.now().toIso8601String(),
      }).eq('id', id);
    } catch (e) {
      throw Exception('فشل في تحديث الحالة: $e');
    }
  }

  // إرسال إيميل جماعي (يتم تسجيله في قاعدة البيانات)
  static Future<void> sendBulkEmail(List<String> ids) async {
    try {
      // هنا يمكنك استدعاء Edge Function لإرسال الإيميلات
      await _client.rpc('send_bulk_email', params: {
        'user_ids': ids,
      });

      // تحديث الحالة للمستخدمين
      for (var id in ids) {
        await markEmailAsSent(id);
      }
    } catch (e) {
      throw Exception('فشل في إرسال الإيميلات: $e');
    }
  }

  // التحقق من وجود الإيميل مسبقاً
  static Future<bool> checkEmailExists(String email) async {
    try {
      final response = await _client
          .from('waitlist')
          .select()
          .eq('email', email)
          .maybeSingle();

      return response != null;
    } catch (e) {
      return false;
    }
  }
}
