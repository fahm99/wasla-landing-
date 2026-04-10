import 'package:flutter/material.dart';
import '../../../utils/app_theme.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0E1647),
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1280),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                final isDesktop = constraints.maxWidth > 768;

                return isDesktop
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _buildFooterColumn1(context),
                          ),
                          Expanded(
                            child: _buildFooterColumn2(context, 'الشركة', [
                              'About Us',
                              'Careers',
                              'Contact Us',
                            ]),
                          ),
                          Expanded(
                            child: _buildFooterColumn2(context, 'القانونية', [
                              'Privacy Policy',
                              'Terms of Service',
                            ]),
                          ),
                          Expanded(
                            child: _buildFooterColumn3(context),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          _buildFooterColumn1(context),
                          const SizedBox(height: 32),
                          _buildFooterColumn2(context, 'الشركة', [
                            'About Us',
                            'Careers',
                            'Contact Us',
                          ]),
                          const SizedBox(height: 32),
                          _buildFooterColumn2(context, 'القانونية', [
                            'Privacy Policy',
                            'Terms of Service',
                          ]),
                          const SizedBox(height: 32),
                          _buildFooterColumn3(context),
                        ],
                      );
              },
            ),
            const SizedBox(height: 48),
            const Divider(
              color: Colors.white10,
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '© 2024 Wasla. All rights reserved.',
                  style: AppTheme.bodyText.copyWith(
                    fontSize: 12,
                    color: const Color(0xFF94A3B8),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.facebook),
                      color: Colors.white,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.link),
                      color: Colors.white,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.email),
                      color: Colors.white,
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

  Widget _buildFooterColumn1(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Wasla (وصلة)',
          style: AppTheme.logoText.copyWith(
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'منصة تعليمية تربط بين الطلاب والمدربين في بيئة احترافية',
          style: AppTheme.bodyText.copyWith(
            fontSize: 14,
            color: const Color(0xFF94A3B8),
          ),
        ),
      ],
    );
  }

  Widget _buildFooterColumn2(
      BuildContext context, String title, List<String> links) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTheme.bodyText.copyWith(
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 24),
        ...links.map((link) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF94A3B8),
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                link,
                style: AppTheme.bodyText.copyWith(
                  fontSize: 14,
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildFooterColumn3(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'تحميل التطبيق',
          style: AppTheme.bodyText.copyWith(
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 24),
        _buildStoreButton(
            context, Icons.phone_iphone, 'Available on', 'App Store'),
        const SizedBox(height: 12),
        _buildStoreButton(context, Icons.android, 'Get it on', 'Google Play'),
      ],
    );
  }

  Widget _buildStoreButton(
      BuildContext context, IconData icon, String subtitle, String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                subtitle,
                style: AppTheme.bodyText.copyWith(
                  fontSize: 10,
                  color: const Color(0xFF94A3B8),
                ),
              ),
              Text(
                title,
                style: AppTheme.bodyText.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
