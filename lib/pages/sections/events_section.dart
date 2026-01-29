import 'package:flutter/material.dart';
import '../../styles/app_theme.dart';
import '../../widgets/section_title.dart';
import '../../widgets/event_card.dart';

/// Events section showing upcoming and past events
class EventsSection extends StatelessWidget {
  const EventsSection({Key? key}) : super(key: key);

  static const List<EventData> _events = [
    EventData(
      title: '2nd Birthday Celebration',
      date: 'October 18, 2023',
      description: 'A magical unicorn-themed party celebrating two wonderful years!',
      imageAsset: 'assets/amelia.png',
      isFeatured: true,
    ),
    EventData(
      title: '1st Birthday Party',
      date: 'October 18, 2022',
      description: 'The grand first birthday celebration with family and friends.',
      imageAsset: 'assets/amelia.png',
    ),
    EventData(
      title: 'Christening Ceremony',
      date: 'June 27, 2021',
      description: 'A blessed day of baptism and celebration.',
      imageAsset: 'assets/amelia_christening.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? AppSpacing.lg : AppSpacing.xxxl,
        vertical: AppSpacing.xxxl,
      ),
      child: Column(
        children: [
          const SectionTitle(
            title: 'Events',
            subtitle: 'Celebrations & Milestones',
          ),
          const SizedBox(height: AppSpacing.xxl),

          // Featured event
          if (_events.any((e) => e.isFeatured))
            _buildFeaturedEvent(isMobile),

          const SizedBox(height: AppSpacing.xl),

          // Other events grid
          _buildEventsGrid(isMobile, isTablet),

          const SizedBox(height: AppSpacing.xl),

          // View all button
          TextButton(
            onPressed: () {},
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'View All Events',
                  style: AppTypography.labelLarge.copyWith(
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                const Icon(
                  Icons.arrow_forward,
                  color: AppColors.primary,
                  size: 18,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedEvent(bool isMobile) {
    final featured = _events.firstWhere((e) => e.isFeatured);
    return EventCard(
      event: featured,
      width: isMobile ? double.infinity : 600,
      height: isMobile ? 350 : 420,
    );
  }

  Widget _buildEventsGrid(bool isMobile, bool isTablet) {
    final otherEvents = _events.where((e) => !e.isFeatured).toList();

    if (isMobile) {
      return Column(
        children: otherEvents.map((event) {
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.lg),
            child: CompactEventCard(event: event),
          );
        }).toList(),
      );
    }

    return Wrap(
      spacing: AppSpacing.lg,
      runSpacing: AppSpacing.lg,
      alignment: WrapAlignment.center,
      children: otherEvents.map((event) {
        return EventCard(
          event: event,
          width: isTablet ? 280 : 320,
          height: isTablet ? 340 : 380,
        );
      }).toList(),
    );
  }
}
