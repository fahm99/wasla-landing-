import 'package:flutter/material.dart';
import '../../../utils/app_theme.dart';

class HowItWorksSection extends StatelessWidget {
  const HowItWorksSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final steps = [
      {
        'number': '1',
        'icon': Icons.person_add,
        'title': 'سجل حساب',
        'description': 'أنشئ حسابك المجاني في ثوانٍ',
      },
      {
        'number': '2',
        'icon': Icons.search,
        'title': 'اختر كورس',
        'description': 'تصفح وجد ما يناسب اهتمامك',
      },
      {
        'number': '3',
        'icon': Icons.local_library,
        'title': 'تعلم',
        'description': 'شاهد الفيديوهات وطبق الدروس',
      },
      {
        'number': '4',
        'icon': Icons.emoji_events,
        'title': 'احصل على شهادة',
        'description': 'وثق إنجازك وشارك نجاحك',
      },
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 96),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1280),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Text(
              'كيف تعمل وصلة للطلاب؟',
              style: AppTheme.sectionTitle.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'أربع خطوات بسيطة تبعدك عن تحقيق أهدافك التعليمية',
              style: AppTheme.bodyText.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 64),
            LayoutBuilder(
              builder: (context, constraints) {
                final isDesktop = constraints.maxWidth > 768;

                return isDesktop
                    ? Row(
                        children: steps.map((step) {
                          return Expanded(
                            child: _buildStepCard(context, step, colorScheme),
                          );
                        }).toList(),
                      )
                    : Column(
                        children: steps.map((step) {
                          return _buildStepCard(context, step, colorScheme);
                        }).toList(),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepCard(BuildContext context, Map<String, dynamic> step,
      ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            child: Text(
              step['number']! as String,
              style: AppTheme.heroTitle.copyWith(
                fontSize: 96,
                color: colorScheme.surfaceContainerHighest,
              ),
            ),
          ),
          Column(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(
                    color: colorScheme.outlineVariant.withOpacity(0.1),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  step['icon'] as IconData,
                  color: colorScheme.primaryContainer,
                  size: 28,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                step['title']! as String,
                style: AppTheme.cardTitle.copyWith(
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                step['description']! as String,
                style: AppTheme.bodyText.copyWith(
                  fontSize: 14,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
