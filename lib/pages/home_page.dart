import 'package:flutter/material.dart';
import '../styles/app_theme.dart';
import '../widgets/animated_background.dart';
import '../widgets/navigation_bar.dart';
import 'sections/hero_section.dart';
import 'sections/about_section.dart';
import 'sections/events_section.dart';
import 'sections/gallery_section.dart';
import 'sections/contact_section.dart';
import 'sections/footer_section.dart';

/// Main home page with all sections
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  int _currentSection = 0;
  bool _isScrolled = false;

  // Section keys for scrolling
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _eventsKey = GlobalKey();
  final GlobalKey _galleryKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  final List<NavItem> _navItems = const [
    NavItem(label: 'Home', icon: Icons.home_outlined),
    NavItem(label: 'About', icon: Icons.person_outline),
    NavItem(label: 'Events', icon: Icons.celebration_outlined),
    NavItem(label: 'Gallery', icon: Icons.photo_library_outlined),
    NavItem(label: 'Contact', icon: Icons.mail_outline),
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // Update nav background on scroll
    final isScrolled = _scrollController.offset > 50;
    if (isScrolled != _isScrolled) {
      setState(() => _isScrolled = isScrolled);
    }

    // Update active section based on scroll position
    _updateActiveSection();
  }

  void _updateActiveSection() {
    final keys = [_heroKey, _aboutKey, _eventsKey, _galleryKey, _contactKey];
    for (var i = keys.length - 1; i >= 0; i--) {
      final context = keys[i].currentContext;
      if (context != null) {
        final box = context.findRenderObject() as RenderBox?;
        if (box != null) {
          final position = box.localToGlobal(Offset.zero);
          if (position.dy <= 200) {
            if (_currentSection != i) {
              setState(() => _currentSection = i);
            }
            break;
          }
        }
      }
    }
  }

  void _scrollToSection(int index) {
    final keys = [_heroKey, _aboutKey, _eventsKey, _galleryKey, _contactKey];
    final context = keys[index].currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: AppDurations.slow,
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: isMobile
          ? MobileNavigationDrawer(
              currentIndex: _currentSection,
              onTap: _scrollToSection,
              items: _navItems,
            )
          : null,
      body: AnimatedBackground(
        showParticles: !isMobile, // Disable particles on mobile for performance
        child: Stack(
          children: [
            // Scrollable content
            CustomScrollView(
              controller: _scrollController,
              slivers: [
                // Hero section
                SliverToBoxAdapter(
                  child: HeroSection(
                    key: _heroKey,
                    onExplorePressed: () => _scrollToSection(2),
                  ),
                ),

                // About section
                SliverToBoxAdapter(
                  child: AboutSection(key: _aboutKey),
                ),

                // Events section
                SliverToBoxAdapter(
                  child: EventsSection(key: _eventsKey),
                ),

                // Gallery section
                SliverToBoxAdapter(
                  child: GallerySection(key: _galleryKey),
                ),

                // Contact section
                SliverToBoxAdapter(
                  child: ContactSection(key: _contactKey),
                ),

                // Footer
                const SliverToBoxAdapter(
                  child: FooterSection(),
                ),
              ],
            ),

            // Fixed navigation bar
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                child: isMobile
                    ? _buildMobileAppBar()
                    : ModernNavigationBar(
                        currentIndex: _currentSection,
                        onTap: _scrollToSection,
                        items: _navItems,
                        isScrolled: _isScrolled,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileAppBar() {
    return AnimatedContainer(
      duration: AppDurations.normal,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: _isScrolled
            ? AppColors.surface.withOpacity(0.95)
            : Colors.transparent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Menu button
          IconButton(
            icon: const Icon(Icons.menu, color: AppColors.textPrimary),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),

          // Logo
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.xs),
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
              const SizedBox(width: AppSpacing.xs),
              Text(
                'Amelia',
                style: AppTypography.headingSmall.copyWith(fontSize: 18),
              ),
            ],
          ),

          // Placeholder for balance
          const SizedBox(width: 48),
        ],
      ),
    );
  }
}
