import 'package:flutter/material.dart';
import '../../styles/app_theme.dart';
import '../../widgets/section_title.dart';
import '../../widgets/glass_card.dart';

/// Gallery section with photo grid
class GallerySection extends StatefulWidget {
  const GallerySection({Key? key}) : super(key: key);

  @override
  State<GallerySection> createState() => _GallerySectionState();
}

class _GallerySectionState extends State<GallerySection> {
  int _selectedCategory = 0;

  final List<String> _categories = [
    'All',
    'Birthdays',
    'Family',
    'Milestones',
  ];

  // Placeholder gallery items
  final List<GalleryItem> _galleryItems = [
    const GalleryItem(
      imageAsset: 'assets/amelia.png',
      category: 'Birthdays',
      title: 'Birthday Smile',
    ),
    const GalleryItem(
      imageAsset: 'assets/amelia_christening.jpg',
      category: 'Milestones',
      title: 'Christening Day',
    ),
    const GalleryItem(
      imageAsset: 'assets/amelia.png',
      category: 'Family',
      title: 'Family Time',
    ),
    const GalleryItem(
      imageAsset: 'assets/amelia.png',
      category: 'Milestones',
      title: 'First Steps',
    ),
    const GalleryItem(
      imageAsset: 'assets/amelia_christening.jpg',
      category: 'Birthdays',
      title: 'Cake Time',
    ),
    const GalleryItem(
      imageAsset: 'assets/amelia.png',
      category: 'Family',
      title: 'With Grandparents',
    ),
  ];

  List<GalleryItem> get _filteredItems {
    if (_selectedCategory == 0) return _galleryItems;
    return _galleryItems
        .where((item) => item.category == _categories[_selectedCategory])
        .toList();
  }

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
            title: 'Gallery',
            subtitle: 'Captured Moments',
          ),
          const SizedBox(height: AppSpacing.xl),

          // Category filter
          _buildCategoryFilter(isMobile),
          const SizedBox(height: AppSpacing.xl),

          // Gallery grid
          _buildGalleryGrid(isMobile),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter(bool isMobile) {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      alignment: WrapAlignment.center,
      children: _categories.asMap().entries.map((entry) {
        final index = entry.key;
        final category = entry.value;
        final isSelected = _selectedCategory == index;

        return GestureDetector(
          onTap: () => setState(() => _selectedCategory = index),
          child: AnimatedContainer(
            duration: AppDurations.fast,
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? AppSpacing.md : AppSpacing.lg,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              gradient: isSelected ? AppColors.primaryGradient : null,
              color: isSelected ? null : Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(AppRadius.round),
              border: Border.all(
                color: isSelected
                    ? Colors.transparent
                    : Colors.white.withOpacity(0.1),
              ),
            ),
            child: Text(
              category,
              style: AppTypography.labelMedium.copyWith(
                color: isSelected ? Colors.white : AppColors.textSecondary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildGalleryGrid(bool isMobile) {
    final crossAxisCount = isMobile ? 2 : 3;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: AppSpacing.md,
        mainAxisSpacing: AppSpacing.md,
        childAspectRatio: 1,
      ),
      itemCount: _filteredItems.length,
      itemBuilder: (context, index) {
        return _GalleryItemWidget(item: _filteredItems[index]);
      },
    );
  }
}

class GalleryItem {
  final String imageAsset;
  final String category;
  final String title;

  const GalleryItem({
    required this.imageAsset,
    required this.category,
    required this.title,
  });
}

class _GalleryItemWidget extends StatefulWidget {
  final GalleryItem item;

  const _GalleryItemWidget({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  State<_GalleryItemWidget> createState() => _GalleryItemWidgetState();
}

class _GalleryItemWidgetState extends State<_GalleryItemWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {
          // Open image viewer
        },
        child: AnimatedContainer(
          duration: AppDurations.fast,
          transform: Matrix4.identity()..scale(_isHovered ? 1.05 : 1.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.lg),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Image
                Image.asset(
                  widget.item.imageAsset,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: AppColors.surface,
                    child: Icon(
                      Icons.photo_outlined,
                      color: AppColors.textMuted,
                      size: 32,
                    ),
                  ),
                ),

                // Overlay on hover
                AnimatedContainer(
                  duration: AppDurations.fast,
                  decoration: BoxDecoration(
                    gradient: _isHovered
                        ? LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.7),
                            ],
                          )
                        : null,
                  ),
                ),

                // Title on hover
                AnimatedPositioned(
                  duration: AppDurations.fast,
                  bottom: _isHovered ? AppSpacing.md : -50,
                  left: AppSpacing.md,
                  right: AppSpacing.md,
                  child: AnimatedOpacity(
                    duration: AppDurations.fast,
                    opacity: _isHovered ? 1 : 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.item.title,
                          style: AppTypography.labelLarge,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Row(
                          children: [
                            Icon(
                              Icons.folder_outlined,
                              size: 12,
                              color: AppColors.accent,
                            ),
                            const SizedBox(width: AppSpacing.xs),
                            Text(
                              widget.item.category,
                              style: AppTypography.bodySmall.copyWith(
                                color: AppColors.accent,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // Expand icon
                AnimatedPositioned(
                  duration: AppDurations.fast,
                  top: _isHovered ? AppSpacing.md : -50,
                  right: AppSpacing.md,
                  child: AnimatedOpacity(
                    duration: AppDurations.fast,
                    opacity: _isHovered ? 1 : 0,
                    child: Container(
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                      ),
                      child: const Icon(
                        Icons.open_in_full,
                        color: Colors.white,
                        size: 16,
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
}
