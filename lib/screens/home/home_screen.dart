import 'package:flutter/material.dart';
import 'sections/header_section.dart';
import 'sections/hero_section.dart';
import 'sections/features_section.dart';
import 'sections/for_providers_section.dart';
import 'sections/how_it_works_section.dart';
import 'sections/app_preview_section.dart';
import 'sections/cta_section.dart';
import 'sections/footer_section.dart';

class WaslaHomePage extends StatelessWidget {
  const WaslaHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: const Column(
        children: [
          HeaderSection(),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: HeroSection(),
                ),
                SliverToBoxAdapter(
                  child: FeaturesSection(),
                ),


                SliverToBoxAdapter(
                  child: ForProvidersSection(),
                ),
                SliverToBoxAdapter(
                  child: HowItWorksSection(),
                ),
                SliverToBoxAdapter(
                  child: AppPreviewSection(),
                ),
                SliverToBoxAdapter(
                  child: CTASection(),
                ),
                SliverToBoxAdapter(
                  child: FooterSection(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
