import 'package:flutter/material.dart';
import '../../../utils/constants.dart';
import '../../../utils/app_theme.dart';
import '../widgets/waitlist_dialog.dart';

class ForProvidersSection extends StatelessWidget {
  const ForProvidersSection({super.key});

  void _showWaitlistDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const WaitlistDialog(initialUserType: 'trainer'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 96),
      color: colorScheme.surfaceContainerLow,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1280),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth > 1024;

            return isDesktop
                ? Row(
                    children: [
                      Expanded(
                        child: _buildProvidersImage(context, colorScheme),
                      ),
                      const SizedBox(width: 64),
                      Expanded(
                        child: _buildProvidersContent(context, colorScheme),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      _buildProvidersContent(context, colorScheme),
                      const SizedBox(height: 48),
                      _buildProvidersImage(context, colorScheme),
                    ],
                  );
          },
        ),
      ),
    );
  }

  Widget _buildProvidersContent(BuildContext context, ColorScheme colorScheme) {
    final items = [
      {
        'icon': Icons.add_box,
        'title': 'إنشاء الكورسات بسهولة',
        'description':
            'أدوات قوية لرفع الفيديوهات، الملفات، والاختبارات في دقائق.',
      },
      {
        'icon': Icons.groups,
        'title': 'إدارة الطلاب',
        'description':
            'تواصل مع طلابك، تابع تقدمهم، وقدم الدعم الفني مباشرة عبر المنصة.',
      },
      {
        'icon': Icons.payments,
        'title': 'تحقيق الأرباح',
        'description':
            'نظام مالي شفاف يضمن لك استلام مستحقاتك بكل أمان وسهولة.',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'للخبراء والمدربين',
          style: AppTheme.bodyText.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: colorScheme.secondary,
            letterSpacing: 3,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'إذا كنت مدرب أو جهة تعليمية...',
          style: AppTheme.heroTitle.copyWith(
            color: colorScheme.onSurface,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 32),
        ...items.map((item) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    item['icon'] as IconData,
                    color: colorScheme.primaryContainer,
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title'] as String,
                        style: AppTheme.cardTitle.copyWith(
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item['description'] as String,
                        style: AppTheme.bodyText.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => _showWaitlistDialog(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.primaryContainer,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 24,
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
      ],
    );
  }

  Widget _buildProvidersImage(BuildContext context, ColorScheme colorScheme) {
    return SizedBox(
      height: 500,
      child: Stack(
        children: [
          Transform.rotate(
            angle: 0.05,
            child: Container(
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(48),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(48),
                child: ColorFiltered(
                  colorFilter: const ColorFilter.matrix([
                    0.2126,
                    0.7152,
                    0.0722,
                    0,
                    0,
                    0.2126,
                    0.7152,
                    0.0722,
                    0,
                    0,
                    0.2126,
                    0.7152,
                    0.0722,
                    0,
                    0,
                    0,
                    0,
                    0,
                    1,
                    0,
                  ]),
                  child: Image.network(
                    Constants.providerImage,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                          color: colorScheme.primaryContainer,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Icon(
                          Icons.groups,
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
            top: -24,
            right: -24,
            child: Container(
              width: 128,
              height: 128,
              decoration: BoxDecoration(
                color: colorScheme.secondaryContainer,
                shape: BoxShape.circle,
                border: Border.all(
                  color: colorScheme.surfaceContainerLow,
                  width: 8,
                ),
              ),
              child: Icon(
                Icons.rocket_launch,
                color: colorScheme.onSecondaryContainer,
                size: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
