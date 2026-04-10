import 'package:flutter/material.dart';
import '../../../utils/app_theme.dart';

class AppPreviewSection extends StatelessWidget {
  const AppPreviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 96),
      color: colorScheme.primaryContainer,
      child: Column(
        children: [
          Text(
            'التطبيق بين يديك',
            style: AppTheme.sectionTitle.copyWith(
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'تجربة مستخدم استثنائية مصممة خصيصاً لتناسب نمط حياتك',
            style: AppTheme.bodyText.copyWith(
              color: const Color(0xFF94A3B8),
            ),
          ),
          const SizedBox(height: 80),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildPhoneMockup(context, 'assets/mobile/waslasplash.jpg'),
                const SizedBox(width: 32),
                Transform.translate(
                  offset: const Offset(0, 48),
                  child: _buildPhoneMockup(context, 'assets/mobile/home.jpg'),
                ),
                const SizedBox(width: 32),
                _buildPhoneMockup(context, 'assets/mobile/course.jpg'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneMockup(BuildContext context, String imagePath) {
    return Container(
      width: 256,
      height: 540,
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(40),
        border: Border.all(
          color: const Color(0xFF1E293B),
          width: 4,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Container(
            width: 96,
            height: 24,
            decoration: const BoxDecoration(
              color: Color(0xFF1E293B),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
