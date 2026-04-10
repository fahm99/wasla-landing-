import 'package:flutter/material.dart';
import 'dart:ui';
import '../../../utils/app_theme.dart';
import '../widgets/waitlist_dialog.dart';

class CTASection extends StatelessWidget {
  const CTASection({super.key});

  void _showWaitlistDialog(BuildContext context, {String? userType}) {
    showDialog(
      context: context,
      builder: (context) => WaitlistDialog(initialUserType: userType),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1280),
        decoration: BoxDecoration(
          color: const Color(0xFFFDD34D),
          borderRadius: BorderRadius.circular(32),
        ),
        padding: const EdgeInsets.all(64),
        child: Stack(
          children: [
            Positioned(
              top: -40,
              right: -40,
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(80),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 32, sigmaY: 32),
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -40,
              left: -40,
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  color: const Color(0xFF0C1445).withOpacity(0.05),
                  borderRadius: BorderRadius.circular(80),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 32, sigmaY: 32),
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Text(
                  'ابدأ رحلتك الآن',
                  style: AppTheme.heroTitle.copyWith(
                    color: const Color(0xFF0C1445),
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'سواء كنت تريد التعلم أو مشاركة معرفتك، وصلة هي المكان الأمثل لتبدأ قصة نجاحك الجديدة.',
                  style: AppTheme.bodyText.copyWith(
                    fontSize: 18,
                    color: const Color(0xFF0C1445).withOpacity(0.8),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                Wrap(
                  spacing: 24,
                  runSpacing: 16,
                  alignment: WrapAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () =>
                          _showWaitlistDialog(context, userType: 'trainer'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0C1445),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 24,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 16,
                        shadowColor: const Color(0xFF0C1445).withOpacity(0.2),
                        textStyle: AppTheme.buttonText.copyWith(
                          fontSize: 20,
                        ),
                      ),
                      child: const Text('ابدأ الآن كمقدم خدمة'),
                    ),
                    ElevatedButton(
                      onPressed: () =>
                          _showWaitlistDialog(context, userType: 'student'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF0C1445),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 24,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(
                            color: const Color(0xFF0C1445).withOpacity(0.1),
                          ),
                        ),
                        textStyle: AppTheme.buttonText.copyWith(
                          fontSize: 20,
                        ),
                      ),
                      child: const Text('تحميل التطبيق'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
