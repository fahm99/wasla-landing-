import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/waitlist_model.dart';
import '../../services/supabase_service.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  List<WaitlistEntry> _waitlist = [];
  bool _isLoading = true;
  String? _error;
  final Set<String> _selectedIds = {};
  bool _isSendingEmail = false;

  @override
  void initState() {
    super.initState();
    _loadWaitlist();
  }

  Future<void> _loadWaitlist() async {
    try {
      setState(() => _isLoading = true);
      final data = await SupabaseService.getWaitlist();
      setState(() {
        _waitlist = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _sendBulkEmail() async {
    if (_selectedIds.isEmpty) return;

    try {
      setState(() => _isSendingEmail = true);

      // هنا يمكنك استدعاء خدمة إرسال الإيميل
      await SupabaseService.sendBulkEmail(_selectedIds.toList());

      setState(() {
        _isSendingEmail = false;
        _selectedIds.clear();
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'تم إرسال الإيميلات بنجاح!',
              style: GoogleFonts.lexend(),
            ),
            backgroundColor: Colors.green,
          ),
        );
      }

      await _loadWaitlist();
    } catch (e) {
      setState(() => _isSendingEmail = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'فشل في إرسال الإيميلات: $e',
              style: GoogleFonts.lexend(),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  String _getUserTypeLabel(String value) {
    switch (value) {
      case 'student':
        return 'طالب';
      case 'university':
        return 'جامعة';
      case 'institute':
        return 'معهد';
      case 'training_center':
        return 'مركز تدريبي';
      case 'trainer':
        return 'مدرب';
      default:
        return value;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.primaryContainer,
        foregroundColor: Colors.white,
        title: Text(
          'لوحة تحكم المسؤول - قائمة الانتظار',
          style: GoogleFonts.manrope(
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadWaitlist,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline,
                          size: 64, color: colorScheme.error),
                      const SizedBox(height: 16),
                      Text(
                        'حدث خطأ في تحميل البيانات',
                        style: GoogleFonts.lexend(fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: _loadWaitlist,
                        child: const Text('إعادة المحاولة'),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    // شريط الأدوات
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Text(
                            'المحدد: ${_selectedIds.length}',
                            style: GoogleFonts.lexend(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 16),
                          if (_selectedIds.isNotEmpty)
                            ElevatedButton.icon(
                              onPressed:
                                  _isSendingEmail ? null : _sendBulkEmail,
                              icon: _isSendingEmail
                                  ? const SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Icon(Icons.send),
                              label: Text(
                                'إرسال إيميل للمحددين',
                                style: GoogleFonts.lexend(),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: colorScheme.primaryContainer,
                                foregroundColor: Colors.white,
                              ),
                            ),
                          const Spacer(),
                          Text(
                            'إجمالي المسجلين: ${_waitlist.length}',
                            style: GoogleFonts.lexend(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // جدول البيانات
                    Expanded(
                      child: _waitlist.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.inbox_outlined,
                                    size: 64,
                                    color: colorScheme.outline,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'لا يوجد مسجلين حالياً',
                                    style: GoogleFonts.lexend(
                                      fontSize: 18,
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : ListView.builder(
                              itemCount: _waitlist.length,
                              itemBuilder: (context, index) {
                                final entry = _waitlist[index];
                                final isSelected =
                                    _selectedIds.contains(entry.id);

                                return Card(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  child: ListTile(
                                    leading: Checkbox(
                                      value: isSelected,
                                      onChanged: entry.emailSent
                                          ? null
                                          : (value) {
                                              setState(() {
                                                if (value == true) {
                                                  _selectedIds.add(entry.id!);
                                                } else {
                                                  _selectedIds.remove(entry.id);
                                                }
                                              });
                                            },
                                    ),
                                    title: Text(
                                      entry.email,
                                      style: GoogleFonts.manrope(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 4),
                                        Text(
                                          'النوع: ${_getUserTypeLabel(entry.userType)}',
                                          style: GoogleFonts.lexend(
                                            fontSize: 12,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          'تاريخ التسجيل: ${_formatDate(entry.createdAt)}',
                                          style: GoogleFonts.lexend(
                                            fontSize: 12,
                                            color: colorScheme.onSurfaceVariant,
                                          ),
                                        ),
                                      ],
                                    ),
                                    trailing: entry.emailSent
                                        ? Chip(
                                            label: Text(
                                              'تم الإرسال',
                                              style: GoogleFonts.lexend(
                                                fontSize: 12,
                                                color: Colors.white,
                                              ),
                                            ),
                                            backgroundColor: Colors.green,
                                          )
                                        : Chip(
                                            label: Text(
                                              'في الانتظار',
                                              style: GoogleFonts.lexend(
                                                fontSize: 12,
                                              ),
                                            ),
                                            backgroundColor:
                                                colorScheme.secondaryContainer,
                                          ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
