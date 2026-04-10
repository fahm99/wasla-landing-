import 'package:flutter/material.dart';
import '../../../models/waitlist_model.dart';
import '../../../services/supabase_service.dart';
import '../../../utils/app_theme.dart';

class WaitlistDialog extends StatefulWidget {
  final String? initialUserType;

  const WaitlistDialog({super.key, this.initialUserType});

  @override
  State<WaitlistDialog> createState() => _WaitlistDialogState();
}

class _WaitlistDialogState extends State<WaitlistDialog> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  String? _selectedUserType;
  bool _isLoading = false;
  bool _isSuccess = false;

  final List<Map<String, String>> _userTypes = [
    {'value': 'student', 'label': 'طالب'},
    {'value': 'university', 'label': 'جامعة'},
    {'value': 'institute', 'label': 'معهد'},
    {'value': 'training_center', 'label': 'مركز تدريبي'},
    {'value': 'trainer', 'label': 'مدرب'},
  ];

  @override
  void initState() {
    super.initState();
    _selectedUserType = widget.initialUserType;
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // التحقق من وجود الإيميل مسبقاً
      final exists =
          await SupabaseService.checkEmailExists(_emailController.text.trim());

      if (exists) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'هذا البريد الإلكتروني مسجل مسبقاً!',
                style: AppTheme.bodyText,
              ),
              backgroundColor: Colors.orange,
            ),
          );
        }
        setState(() => _isLoading = false);
        return;
      }

      final entry = WaitlistEntry(
        email: _emailController.text.trim(),
        userType: _selectedUserType!,
        createdAt: DateTime.now(),
      );

      await SupabaseService.addToWaitlist(entry);

      setState(() {
        _isLoading = false;
        _isSuccess = true;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'حدث خطأ، يرجى المحاولة مرة أخرى',
              style: AppTheme.bodyText,
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 480),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 32,
              offset: const Offset(0, 16),
            ),
          ],
        ),
        child: _isSuccess
            ? _buildSuccessView(colorScheme)
            : _buildFormView(colorScheme),
      ),
    );
  }

  Widget _buildFormView(ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.mail_outline,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'انضم إلى قائمة الانتظار',
                        style: AppTheme.cardTitle.copyWith(
                          fontSize: 24,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'سنخبرك فور جاهزية المنصة!',
                        style: AppTheme.bodyText.copyWith(
                          fontSize: 14,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // حقل الإيميل
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textDirection: TextDirection.ltr,
              decoration: InputDecoration(
                labelText: 'البريد الإلكتروني',
                labelStyle: AppTheme.bodyText.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: colorScheme.primaryContainer,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: colorScheme.outlineVariant),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: colorScheme.outlineVariant),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      BorderSide(color: colorScheme.primaryContainer, width: 2),
                ),
                filled: true,
                fillColor: colorScheme.surfaceContainerLowest,
              ),
              style: AppTheme.bodyText,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'يرجى إدخال البريد الإلكتروني';
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                    .hasMatch(value)) {
                  return 'يرجى إدخال بريد إلكتروني صحيح';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),

            // اختيار نوع المستخدم
            DropdownButtonFormField<String>(
              value: _selectedUserType,
              decoration: InputDecoration(
                labelText: 'نوع المستخدم',
                labelStyle: AppTheme.bodyText.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                prefixIcon: Icon(
                  Icons.person_outline,
                  color: colorScheme.primaryContainer,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: colorScheme.outlineVariant),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: colorScheme.outlineVariant),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      BorderSide(color: colorScheme.primaryContainer, width: 2),
                ),
                filled: true,
                fillColor: colorScheme.surfaceContainerLowest,
              ),
              style: AppTheme.bodyText.copyWith(color: colorScheme.onSurface),
              dropdownColor: Colors.white,
              icon: Icon(Icons.arrow_drop_down,
                  color: colorScheme.primaryContainer),
              items: _userTypes.map((type) {
                return DropdownMenuItem<String>(
                  value: type['value'],
                  child: Text(
                    type['label']!,
                    style: AppTheme.bodyText,
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() => _selectedUserType = value);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'يرجى اختيار نوع المستخدم';
                }
                return null;
              },
            ),
            const SizedBox(height: 32),

            // زر الإرسال
            ElevatedButton(
              onPressed: _isLoading ? null : _submitForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primaryContainer,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 8,
                shadowColor: colorScheme.primaryContainer.withOpacity(0.3),
              ),
              child: _isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      'انضم الآن',
                      style: AppTheme.buttonText.copyWith(
                        fontSize: 18,
                      ),
                    ),
            ),
            const SizedBox(height: 16),

            // زر الإغلاق
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                foregroundColor: colorScheme.onSurfaceVariant,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: Text(
                'لاحقاً',
                style: AppTheme.bodyText.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessView(ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.all(48),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: colorScheme.secondaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check,
              color: colorScheme.onSecondaryContainer,
              size: 40,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'تم التسجيل بنجاح!',
            style: AppTheme.cardTitle.copyWith(
              fontSize: 28,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'سنخبرك فوراً عبر البريد الإلكتروني عند إطلاق المنصة',
            style: AppTheme.bodyText.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primaryContainer,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'حسناً',
              style: AppTheme.buttonText,
            ),
          ),
        ],
      ),
    );
  }
}
