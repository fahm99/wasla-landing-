import 'package:flutter/material.dart';
import '../../../utils/app_theme.dart';

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final features = [
      {
        'icon': Icons.school,
        'title': 'تعلم من أفضل المدربين',
        'description':
            'نخبة من الخبراء في مختلف المجالات يقدمون خلاصة تجاربهم بين يديك.',
        'color': colorScheme.secondaryContainer,
        'iconColor': colorScheme.onSecondaryContainer,
      },
      {
        'icon': Icons.workspace_premium,
        'title': 'كورسات احترافية',
        'description':
            'محتوى تعليمي عالي الجودة مصمم ليتناسب مع متطلبات سوق العمل الحالية.',
        'color': colorScheme.primaryContainer,
        'iconColor': Colors.white,
      },
      {
        'icon': Icons.card_membership,
        'title': 'شهادات معتمدة',
        'description':
            'احصل على شهادة إتمام موثقة تعزز ملفك الشخصي وتفتح لك أبواب الفرص.',
        'color': colorScheme.secondaryContainer,
        'iconColor': colorScheme.onSecondaryContainer,
      },
      {
        'icon': Icons.trending_up,
        'title': 'متابعة تقدمك بسهولة',
        'description':
            'أدوات متطورة تتيح لك قياس مستواك وتتبع إنجازاتك في كل خطوة.',
        'color': colorScheme.primaryContainer,
        'iconColor': Colors.white,
      },
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 96),
      color: colorScheme.surfaceContainer,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1280),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount = 1;
            if (constraints.maxWidth > 768) crossAxisCount = 2;
            if (constraints.maxWidth > 1024) crossAxisCount = 4;

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 32,
                mainAxisSpacing: 32,
                childAspectRatio: 0.85,
              ),
              itemCount: features.length,
              itemBuilder: (context, index) {
                final feature = features[index];
                return MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerLowest,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: feature['color'] as Color,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            feature['icon'] as IconData,
                            color: feature['iconColor'] as Color,
                            size: 32,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          feature['title'] as String,
                          style: AppTheme.cardTitle.copyWith(
                            color: colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          feature['description'] as String,
                          style: AppTheme.bodyText.copyWith(
                            fontSize: 14,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
