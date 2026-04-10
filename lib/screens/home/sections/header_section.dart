import 'package:flutter/material.dart';
import '../../../utils/constants.dart';
import '../../../utils/app_theme.dart';
import '../widgets/waitlist_dialog.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

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
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1280),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth > 768;

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // الشعار على اليمين
                _buildLogo(context, colorScheme),

                // الأزرار على اليسار
                if (isDesktop)
                  Row(
                    children: [
                      _buildButton(
                        context,
                        'تحميل التطبيق',
                        Icons.download,
                        colorScheme.secondaryContainer,
                        colorScheme.onSecondaryContainer,
                        () => _showWaitlistDialog(context, userType: 'student'),
                      ),
                      const SizedBox(width: 16),
                      _buildButton(
                        context,
                        'التسجيل كشريك تعليمي',
                        Icons.business,
                        colorScheme.primaryContainer,
                        Colors.white,
                        () => _showWaitlistDialog(context, userType: 'trainer'),
                      ),
                    ],
                  )
                else
                  PopupMenuButton<String>(
                    icon: Icon(
                      Icons.menu,
                      color: colorScheme.onSurface,
                    ),
                    onSelected: (value) {
                      if (value == 'download') {
                        _showWaitlistDialog(context, userType: 'student');
                      } else if (value == 'partner') {
                        _showWaitlistDialog(context, userType: 'trainer');
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'download',
                        child: Row(
                          children: [
                            Icon(Icons.download, color: colorScheme.onSurface),
                            const SizedBox(width: 12),
                            Text('تحميل التطبيق'),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'partner',
                        child: Row(
                          children: [
                            Icon(Icons.business, color: colorScheme.onSurface),
                            const SizedBox(width: 12),
                            Text('التسجيل كشريك تعليمي'),
                          ],
                        ),
                      ),
                    ],
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildLogo(BuildContext context, ColorScheme colorScheme) {
    return Row(
      children: [
        Image.asset(
          Constants.logoImage,
          height: 40,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.school,
                color: Colors.white,
                size: 24,
              ),
            );
          },
        ),
        const SizedBox(width: 12),
        Text(
          'وصلة',
          style: AppTheme.logoText.copyWith(
            color: colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildButton(
    BuildContext context,
    String text,
    IconData icon,
    Color backgroundColor,
    Color textColor,
    VoidCallback onPressed,
  ) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 20),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
        textStyle: AppTheme.buttonText.copyWith(
          fontSize: 14,
        ),
      ),
    );
  }
}
