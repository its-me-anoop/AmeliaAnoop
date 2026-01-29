import 'package:flutter/material.dart';
import '../../styles/app_theme.dart';
import '../../widgets/modern_avatar.dart';
import '../../widgets/gradient_button.dart';
import '../../widgets/animated_text.dart';
import '../../widgets/social_links.dart';

/// Hero section with animated introduction
class HeroSection extends StatefulWidget {
  final VoidCallback? onExplorePressed;

  const HeroSection({
    Key? key,
    this.onExplorePressed,
  }) : super(key: key);

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 1, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 30),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 1, curve: Curves.easeOut),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Container(
      constraints: BoxConstraints(minHeight: screenHeight),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? AppSpacing.lg : AppSpacing.xxxl,
        vertical: AppSpacing.xxxl,
      ),
      child: SafeArea(
        child: Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Opacity(
                opacity: _fadeAnimation.value,
                child: Transform.translate(
                  offset: _slideAnimation.value,
                  child: _buildContent(isMobile),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildContent(bool isMobile) {
    if (isMobile) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: AppSpacing.xxxl),
          _buildAvatar(),
          const SizedBox(height: AppSpacing.xl),
          _buildTextContent(true),
          const SizedBox(height: AppSpacing.xl),
          _buildButtons(true),
          const SizedBox(height: AppSpacing.xl),
          _buildSocialLinks(),
          const SizedBox(height: AppSpacing.xl),
          _buildScrollIndicator(),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextContent(false),
              const SizedBox(height: AppSpacing.xl),
              _buildButtons(false),
              const SizedBox(height: AppSpacing.xl),
              _buildSocialLinks(),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.xxxl),
        _buildAvatar(size: 320),
      ],
    );
  }

  Widget _buildAvatar({double size = 200}) {
    return const AnimatedAvatar(
      size: 280,
      imageAsset: 'assets/amelia.png',
    );
  }

  Widget _buildTextContent(bool centered) {
    return Column(
      crossAxisAlignment:
          centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Greeting
        FadeSlideText(
          text: 'Welcome to',
          style: AppTypography.labelLarge.copyWith(
            color: AppColors.accent,
            letterSpacing: 3,
          ),
          delay: const Duration(milliseconds: 200),
          textAlign: centered ? TextAlign.center : null,
        ),
        const SizedBox(height: AppSpacing.sm),

        // Name
        GradientText(
          text: 'Amelia Anoop',
          style: TextStyle(
            fontSize: centered ? 42 : 64,
            fontWeight: FontWeight.w800,
            letterSpacing: -2,
            height: 1.1,
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        // Tagline
        FadeSlideText(
          text: 'Celebrating life\'s precious moments\nand beautiful memories',
          style: AppTypography.bodyLarge,
          delay: const Duration(milliseconds: 400),
          textAlign: centered ? TextAlign.center : null,
        ),
      ],
    );
  }

  Widget _buildButtons(bool centered) {
    return Wrap(
      alignment: centered ? WrapAlignment.center : WrapAlignment.start,
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.md,
      children: [
        GradientButton(
          text: 'Explore Events',
          icon: Icons.celebration_outlined,
          onPressed: widget.onExplorePressed,
        ),
        GradientButton(
          text: 'View Gallery',
          icon: Icons.photo_library_outlined,
          isOutlined: true,
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildSocialLinks() {
    return const SocialLinksRow(
      links: CommonSocialLinks.all,
      iconSize: 44,
    );
  }

  Widget _buildScrollIndicator() {
    return Column(
      children: [
        Text(
          'Scroll to explore',
          style: AppTypography.bodySmall,
        ),
        const SizedBox(height: AppSpacing.sm),
        Icon(
          Icons.keyboard_arrow_down,
          color: AppColors.textMuted,
          size: 24,
        ),
      ],
    );
  }
}
