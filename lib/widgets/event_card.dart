import 'dart:ui';
import 'package:flutter/material.dart';
import '../styles/app_theme.dart';

/// Event data model
class EventData {
  final String title;
  final String date;
  final String? description;
  final String? imageAsset;
  final String? imageUrl;
  final bool isFeatured;

  const EventData({
    required this.title,
    required this.date,
    this.description,
    this.imageAsset,
    this.imageUrl,
    this.isFeatured = false,
  });
}

/// Modern event card with glassmorphism
class EventCard extends StatefulWidget {
  final EventData event;
  final VoidCallback? onTap;
  final double? width;
  final double? height;

  const EventCard({
    Key? key,
    required this.event,
    this.onTap,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: AppDurations.normal,
          width: widget.width ?? 300,
          height: widget.height ?? 380,
          transform: Matrix4.identity()
            ..scale(_isHovered ? 1.03 : 1.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.xl),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Background image
                _buildBackgroundImage(),

                // Gradient overlay
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.3),
                        Colors.black.withOpacity(0.8),
                      ],
                      stops: const [0.0, 0.5, 1.0],
                    ),
                  ),
                ),

                // Featured badge
                if (widget.event.isFeatured)
                  Positioned(
                    top: AppSpacing.md,
                    right: AppSpacing.md,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        gradient: AppColors.accentGradient,
                        borderRadius: BorderRadius.circular(AppRadius.round),
                      ),
                      child: Text(
                        'Featured',
                        style: AppTypography.labelMedium.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                // Content
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: _isHovered ? 10 : 0,
                        sigmaY: _isHovered ? 10 : 0,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        decoration: BoxDecoration(
                          color: _isHovered
                              ? Colors.white.withOpacity(0.1)
                              : Colors.transparent,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Date
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today_outlined,
                                  size: 14,
                                  color: AppColors.accent,
                                ),
                                const SizedBox(width: AppSpacing.xs),
                                Text(
                                  widget.event.date,
                                  style: AppTypography.labelMedium.copyWith(
                                    color: AppColors.accent,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: AppSpacing.sm),

                            // Title
                            Text(
                              widget.event.title,
                              style: AppTypography.headingMedium,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),

                            // Description
                            if (widget.event.description != null) ...[
                              const SizedBox(height: AppSpacing.sm),
                              Text(
                                widget.event.description!,
                                style: AppTypography.bodySmall,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],

                            // View button on hover
                            AnimatedOpacity(
                              duration: AppDurations.fast,
                              opacity: _isHovered ? 1 : 0,
                              child: Padding(
                                padding: const EdgeInsets.only(top: AppSpacing.md),
                                child: Row(
                                  children: [
                                    Text(
                                      'View Gallery',
                                      style: AppTypography.labelLarge.copyWith(
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    const SizedBox(width: AppSpacing.xs),
                                    Icon(
                                      Icons.arrow_forward,
                                      size: 16,
                                      color: AppColors.primary,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackgroundImage() {
    if (widget.event.imageAsset != null) {
      return Image.asset(
        widget.event.imageAsset!,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _buildPlaceholder(),
      );
    } else if (widget.event.imageUrl != null) {
      return Image.network(
        widget.event.imageUrl!,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _buildPlaceholder(),
      );
    }
    return _buildPlaceholder();
  }

  Widget _buildPlaceholder() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.surface,
            AppColors.surfaceLight,
          ],
        ),
      ),
      child: Center(
        child: Icon(
          Icons.photo_outlined,
          size: 48,
          color: AppColors.textMuted,
        ),
      ),
    );
  }
}

/// Compact event card for lists
class CompactEventCard extends StatefulWidget {
  final EventData event;
  final VoidCallback? onTap;

  const CompactEventCard({
    Key? key,
    required this.event,
    this.onTap,
  }) : super(key: key);

  @override
  State<CompactEventCard> createState() => _CompactEventCardState();
}

class _CompactEventCardState extends State<CompactEventCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: AppDurations.fast,
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: _isHovered
                ? Colors.white.withOpacity(0.1)
                : Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(
              color: _isHovered
                  ? AppColors.primary.withOpacity(0.5)
                  : Colors.white.withOpacity(0.1),
            ),
          ),
          child: Row(
            children: [
              // Thumbnail
              ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.md),
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: widget.event.imageAsset != null
                      ? Image.asset(
                          widget.event.imageAsset!,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          color: AppColors.surface,
                          child: Icon(
                            Icons.photo_outlined,
                            color: AppColors.textMuted,
                          ),
                        ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),

              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.event.title,
                      style: AppTypography.headingSmall.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 12,
                          color: AppColors.textMuted,
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Text(
                          widget.event.date,
                          style: AppTypography.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Arrow
              Icon(
                Icons.chevron_right,
                color: _isHovered ? AppColors.primary : AppColors.textMuted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
