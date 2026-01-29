import 'package:flutter/material.dart';
import '../../styles/app_theme.dart';
import '../../widgets/section_title.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/gradient_button.dart';
import '../../widgets/social_links.dart';

/// Contact section with form and info
class ContactSection extends StatefulWidget {
  const ContactSection({Key? key}) : super(key: key);

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
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
            title: 'Contact',
            subtitle: 'Get In Touch',
          ),
          const SizedBox(height: AppSpacing.xxl),

          isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Contact form
        Expanded(
          flex: 3,
          child: GlassCard(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: _buildContactForm(),
          ),
        ),
        const SizedBox(width: AppSpacing.xl),

        // Contact info
        Expanded(
          flex: 2,
          child: Column(
            children: [
              _buildInfoCard(
                icon: Icons.email_outlined,
                title: 'Email Us',
                content: 'hello@ameliaanoop.com',
              ),
              const SizedBox(height: AppSpacing.lg),
              _buildInfoCard(
                icon: Icons.location_on_outlined,
                title: 'Location',
                content: 'New York, USA',
              ),
              const SizedBox(height: AppSpacing.lg),
              GlassCard(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  children: [
                    Text(
                      'Follow Us',
                      style: AppTypography.headingSmall,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    const SocialLinksRow(
                      links: CommonSocialLinks.all,
                      iconSize: 42,
                    ),
                  ],
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
          child: _buildContactForm(),
        ),
        const SizedBox(height: AppSpacing.xl),

        // Contact info cards
        Row(
          children: [
            Expanded(
              child: _buildCompactInfoCard(
                icon: Icons.email_outlined,
                title: 'Email',
                content: 'hello@\nameliaanoop.com',
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _buildCompactInfoCard(
                icon: Icons.location_on_outlined,
                title: 'Location',
                content: 'New York,\nUSA',
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),

        // Social links
        GlassCard(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            children: [
              Text(
                'Follow Us',
                style: AppTypography.labelLarge,
              ),
              const SizedBox(height: AppSpacing.sm),
              const SocialLinksRow(
                links: CommonSocialLinks.all,
                iconSize: 38,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContactForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Send a Message',
            style: AppTypography.headingMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'We\'d love to hear from you! Leave a message and we\'ll get back to you soon.',
            style: AppTypography.bodySmall,
          ),
          const SizedBox(height: AppSpacing.lg),

          // Name field
          _buildTextField(
            controller: _nameController,
            label: 'Your Name',
            hint: 'Enter your name',
            icon: Icons.person_outline,
          ),
          const SizedBox(height: AppSpacing.md),

          // Email field
          _buildTextField(
            controller: _emailController,
            label: 'Email Address',
            hint: 'Enter your email',
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: AppSpacing.md),

          // Message field
          _buildTextField(
            controller: _messageController,
            label: 'Message',
            hint: 'Write your message here...',
            icon: Icons.message_outlined,
            maxLines: 4,
          ),
          const SizedBox(height: AppSpacing.lg),

          // Submit button
          SizedBox(
            width: double.infinity,
            child: GradientButton(
              text: 'Send Message',
              icon: Icons.send_outlined,
              onPressed: _submitForm,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.labelMedium,
        ),
        const SizedBox(height: AppSpacing.xs),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textPrimary,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTypography.bodyMedium.copyWith(
              color: AppColors.textMuted,
            ),
            prefixIcon: Icon(
              icon,
              color: AppColors.textMuted,
              size: 20,
            ),
            filled: true,
            fillColor: Colors.white.withOpacity(0.05),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
              borderSide: BorderSide(
                color: Colors.white.withOpacity(0.1),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
              borderSide: BorderSide(
                color: Colors.white.withOpacity(0.1),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
              borderSide: const BorderSide(
                color: AppColors.primary,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.md,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return HoverGlassCard(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTypography.labelMedium,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                content,
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCompactInfoCard({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return GlassCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        children: [
          Icon(
            icon,
            color: AppColors.primary,
            size: 28,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            title,
            style: AppTypography.labelMedium,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            content,
            style: AppTypography.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // Handle form submission
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Message sent successfully!'),
          backgroundColor: AppColors.primary,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
        ),
      );

      // Clear form
      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
    }
  }
}
