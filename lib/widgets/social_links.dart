import 'package:flutter/material.dart';
import '../styles/app_theme.dart';

/// Social media link data
class SocialLink {
  final IconData icon;
  final String label;
  final String? url;

  const SocialLink({
    required this.icon,
    required this.label,
    this.url,
  });
}

/// Social link button with hover effects
class SocialLinkButton extends StatefulWidget {
  final SocialLink link;
  final double size;
  final VoidCallback? onTap;

  const SocialLinkButton({
    Key? key,
    required this.link,
    this.size = 48,
    this.onTap,
  }) : super(key: key);

  @override
  State<SocialLinkButton> createState() => _SocialLinkButtonState();
}

class _SocialLinkButtonState extends State<SocialLinkButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Tooltip(
          message: widget.link.label,
          child: AnimatedContainer(
            duration: AppDurations.fast,
            width: widget.size,
            height: widget.size,
            transform: Matrix4.identity()..scale(_isHovered ? 1.1 : 1.0),
            decoration: BoxDecoration(
              gradient: _isHovered ? AppColors.primaryGradient : null,
              color: _isHovered ? null : AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(
                color: _isHovered
                    ? Colors.transparent
                    : Colors.white.withOpacity(0.1),
              ),
              boxShadow: _isHovered
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.4),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ]
                  : null,
            ),
            child: Icon(
              widget.link.icon,
              color: _isHovered ? Colors.white : AppColors.textSecondary,
              size: widget.size * 0.5,
            ),
          ),
        ),
      ),
    );
  }
}

/// Row of social links
class SocialLinksRow extends StatelessWidget {
  final List<SocialLink> links;
  final double iconSize;
  final double spacing;

  const SocialLinksRow({
    Key? key,
    required this.links,
    this.iconSize = 48,
    this.spacing = AppSpacing.md,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      alignment: WrapAlignment.center,
      children: links.map((link) {
        return SocialLinkButton(
          link: link,
          size: iconSize,
        );
      }).toList(),
    );
  }
}

/// Common social links preset
class CommonSocialLinks {
  static const List<SocialLink> all = [
    SocialLink(
      icon: Icons.camera_alt_outlined,
      label: 'Instagram',
    ),
    SocialLink(
      icon: Icons.facebook_outlined,
      label: 'Facebook',
    ),
    SocialLink(
      icon: Icons.play_circle_outline,
      label: 'YouTube',
    ),
    SocialLink(
      icon: Icons.mail_outline,
      label: 'Email',
    ),
  ];
}
