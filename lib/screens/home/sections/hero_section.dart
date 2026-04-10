import 'package:flutter/material.dart';
import 'dart:ui';
import '../../../utils/constants.dart';
import '../../../utils/app_theme.dart';
import '../widgets/waitlist_dialog.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  void _showWaitlistDialog(BuildContext context, {String? userType}) {
    showDialog(
      context: context,
      builder: (context) => WaitlistDialog(initialUserType: userType),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.only(top: 128, bottom: 80),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth > 1024;

          return Container(
            constraints: const BoxConstraints(maxWidth: 1280),
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: isDesktop
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 5,
                        child: _buildHeroContent(context, colorScheme),
                      ),
                      const SizedBox(width: 48),
                      Expanded(
                        flex: 5,
                        child: _buildHeroImage(context, colorScheme),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      _buildHeroContent(context, colorScheme),
                      const SizedBox(height: 48),
                      _buildHeroImage(context, colorScheme),
                    ],
                  ),
          );
        },
      ),
    );
  }

  Widget _buildHeroContent(BuildContext context, ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'تعلم، علّم، وانطلق بمستقبلك مع',
          style: AppTheme.heroTitle.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
        Text(
          'وصلة',
          style: AppTheme.heroTitle.copyWith(
            color: colorScheme.primaryContainer,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          Constants.heroSubtitle,
          style: AppTheme.bodyText.copyWith(
            fontSize: 20,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 40),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            ElevatedButton(
              onPressed: () =>
                  _showWaitlistDialog(context, userType: 'trainer'),
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primaryContainer,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 8,
                shadowColor: colorScheme.primaryContainer.withOpacity(0.2),
                textStyle: AppTheme.buttonText.copyWith(
                  fontSize: 18,
                ),
              ),
              child: const Text('ابدأ الآن كمقدم خدمة'),
            ),
            ElevatedButton(
              onPressed: () =>
                  _showWaitlistDialog(context, userType: 'student'),
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.secondaryContainer,
                foregroundColor: colorScheme.onSecondaryContainer,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                textStyle: AppTheme.buttonText.copyWith(
                  fontSize: 18,
                ),
              ),
              child: const Text('تحميل التطبيق'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHeroImage(BuildContext context, ColorScheme colorScheme) {
    return SizedBox(
      height: 500,
      child: Stack(
        children: [
          Positioned(
            top: -80,
            right: -80,
            child: Container(
              width: 384,
              height: 384,
              decoration: BoxDecoration(
                color: colorScheme.secondaryContainer.withOpacity(0.2),
                borderRadius: BorderRadius.circular(192),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          Center(
            child: Transform.rotate(
              angle: 0.05,
              child: Container(
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 32,
                      offset: const Offset(0, 16),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: Image.asset(
                    Constants.platformDashboard,
                    width: double.infinity,
                    height: 350,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: double.infinity,
                        height: 350,
                        color: colorScheme.surfaceContainerHighest,
                        child: Icon(
                          Icons.dashboard,
                          size: 64,
                          color: colorScheme.onSurfaceVariant.withOpacity(0.5),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 0,
            child: Container(
              width: 200,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.verified,
                        color: colorScheme.secondary,
                        size: 32,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '98%',
                        style: AppTheme.cardTitle.copyWith(
                          fontSize: 24,
                          color: colorScheme.primaryContainer,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'نسبة رضا المستخدمين عن جودة التعليم في وصلة',
                    style: AppTheme.bodyText.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
