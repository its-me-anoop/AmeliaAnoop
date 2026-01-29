import 'package:flutter/material.dart';
import '../styles/app_theme.dart';

/// A stylized section title with gradient accent
class SectionTitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool centered;

  const SectionTitle({
    Key? key,
    required this.title,
    this.subtitle,
    this.centered = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Gradient accent line
        Container(
          width: 60,
          height: 4,
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        // Title with gradient text
        ShaderMask(
          shaderCallback: (bounds) =>
              AppColors.primaryGradient.createShader(bounds),
          child: Text(
            title.toUpperCase(),
            style: AppTypography.labelLarge.copyWith(
              color: Colors.white,
              letterSpacing: 3,
            ),
            textAlign: centered ? TextAlign.center : TextAlign.start,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: AppSpacing.sm),
          Text(
            subtitle!,
            style: AppTypography.displaySmall,
            textAlign: centered ? TextAlign.center : TextAlign.start,
          ),
        ],
      ],
    );
  }
}

/// Animated section title that fades in
class AnimatedSectionTitle extends StatefulWidget {
  final String title;
  final String? subtitle;
  final bool centered;

  const AnimatedSectionTitle({
    Key? key,
    required this.title,
    this.subtitle,
    this.centered = true,
  }) : super(key: key);

  @override
  State<AnimatedSectionTitle> createState() => _AnimatedSectionTitleState();
}

class _AnimatedSectionTitleState extends State<AnimatedSectionTitle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: AppDurations.slow,
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
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
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: SectionTitle(
          title: widget.title,
          subtitle: widget.subtitle,
          centered: widget.centered,
        ),
      ),
    );
  }
}
