import 'package:flutter/material.dart';
import '../../styles/app_theme.dart';
import '../../widgets/section_title.dart';
import '../../widgets/glass_card.dart';

/// About section with bio and stats
class AboutSection extends StatelessWidget {
  const AboutSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? AppSpacing.lg : AppSpacing.xxxl,
        vertical: AppSpacing.xxxl,
      ),
      child: Column(
        children: [
          const SectionTitle(
            title: 'About',
            subtitle: 'A Little Star\'s Journey',
          ),
          const SizedBox(height: AppSpacing.xxl),

          // Content
          isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Bio card
        Expanded(
          flex: 3,
          child: GlassCard(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(AppRadius.md),
                      ),
                      child: const Icon(
                        Icons.auto_stories,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Text(
                      'Our Story',
                      style: AppTypography.headingMedium,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  'Welcome to Amelia\'s world! This is a special place where we celebrate and cherish all the beautiful moments and milestones in Amelia\'s life.',
                  style: AppTypography.bodyLarge,
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  'From her first smile to her first steps, from birthday celebrations to family gatherings - every precious memory is captured and treasured here.',
                  style: AppTypography.bodyMedium,
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  'Join us as we document this incredible journey of growth, love, and endless joy.',
                  style: AppTypography.bodyMedium,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.xl),

        // Stats cards
        Expanded(
          flex: 2,
          child: Column(
            children: [
              _buildStatCard(
                icon: Icons.cake_outlined,
                value: '2',
                label: 'Years of Joy',
                gradient: AppColors.primaryGradient,
              ),
              const SizedBox(height: AppSpacing.lg),
              _buildStatCard(
                icon: Icons.celebration_outlined,
                value: '10+',
                label: 'Events Celebrated',
                gradient: AppColors.accentGradient,
              ),
              const SizedBox(height: AppSpacing.lg),
              _buildStatCard(
                icon: Icons.photo_library_outlined,
                value: '500+',
                label: 'Memories Captured',
                gradient: const LinearGradient(
                  colors: [Color(0xFF10B981), Color(0xFF059669)],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        GlassCard(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                    child: const Icon(
                      Icons.auto_stories,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    'Our Story',
                    style: AppTypography.headingSmall,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                'Welcome to Amelia\'s world! This is a special place where we celebrate and cherish all the beautiful moments and milestones in Amelia\'s life.',
                style: AppTypography.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'From her first smile to her first steps, every precious memory is captured and treasured here.',
                style: AppTypography.bodySmall,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        // Stats row
        Row(
          children: [
            Expanded(
              child: _buildCompactStatCard(
                icon: Icons.cake_outlined,
                value: '2',
                label: 'Years',
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _buildCompactStatCard(
                icon: Icons.celebration_outlined,
                value: '10+',
                label: 'Events',
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _buildCompactStatCard(
                icon: Icons.photo_library_outlined,
                value: '500+',
                label: 'Photos',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String label,
    required LinearGradient gradient,
  }) {
    return HoverGlassCard(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: AppTypography.displaySmall.copyWith(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                label,
                style: AppTypography.bodySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCompactStatCard({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return GlassCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        children: [
          Icon(
            icon,
            color: AppColors.primary,
            size: 24,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            value,
            style: AppTypography.headingMedium,
          ),
          Text(
            label,
            style: AppTypography.bodySmall,
          ),
        ],
      ),
    );
  }
}
