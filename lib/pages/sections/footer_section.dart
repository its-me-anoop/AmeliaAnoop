import 'package:flutter/material.dart';
import '../../styles/app_theme.dart';
import '../../widgets/social_links.dart';

/// Footer section with credits and links
class FooterSection extends StatelessWidget {
  const FooterSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? AppSpacing.lg : AppSpacing.xxxl,
        vertical: AppSpacing.xl,
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.white.withOpacity(0.1),
          ),
        ),
      ),
      child: Column(
        children: [
          // Logo and tagline
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: const Text(
                  'A',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'Amelia Anoop',
                style: AppTypography.headingSmall.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),

          Text(
            'Celebrating life\'s precious moments',
            style: AppTypography.bodySmall,
          ),
          const SizedBox(height: AppSpacing.lg),

          // Social links
          const SocialLinksRow(
            links: CommonSocialLinks.all,
            iconSize: 36,
          ),
          const SizedBox(height: AppSpacing.xl),

          // Divider
          Container(
            width: 100,
            height: 1,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // Copyright
          Text(
            '© ${DateTime.now().year} Amelia Anoop. All rights reserved.',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textMuted,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),

          // Made with love
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Made with ',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textMuted,
                ),
              ),
              const Icon(
                Icons.favorite,
                color: AppColors.accent,
                size: 14,
              ),
              Text(
                ' by Family',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
