import 'package:flutter/material.dart';
import '../styles/app_theme.dart';

/// Animated typing text effect
class TypewriterText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final Duration charDuration;
  final VoidCallback? onComplete;

  const TypewriterText({
    Key? key,
    required this.text,
    this.style,
    this.charDuration = const Duration(milliseconds: 50),
    this.onComplete,
  }) : super(key: key);

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> {
  String _displayText = '';
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  void _startTyping() async {
    while (_currentIndex < widget.text.length) {
      await Future.delayed(widget.charDuration);
      if (mounted) {
        setState(() {
          _currentIndex++;
          _displayText = widget.text.substring(0, _currentIndex);
        });
      }
    }
    widget.onComplete?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _displayText,
      style: widget.style ?? AppTypography.displayMedium,
    );
  }
}

/// Gradient animated text
class GradientText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final LinearGradient? gradient;
  final bool animate;

  const GradientText({
    Key? key,
    required this.text,
    this.style,
    this.gradient,
    this.animate = false,
  }) : super(key: key);

  @override
  State<GradientText> createState() => _GradientTextState();
}

class _GradientTextState extends State<GradientText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    if (widget.animate) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gradient = widget.gradient ?? AppColors.primaryGradient;

    if (widget.animate) {
      return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return ShaderMask(
            shaderCallback: (bounds) {
              return LinearGradient(
                begin: Alignment(
                  -1 + (_controller.value * 2),
                  0,
                ),
                end: Alignment(
                  1 + (_controller.value * 2),
                  0,
                ),
                colors: gradient.colors,
              ).createShader(bounds);
            },
            child: Text(
              widget.text,
              style: (widget.style ?? AppTypography.displayMedium).copyWith(
                color: Colors.white,
              ),
            ),
          );
        },
      );
    }

    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(bounds),
      child: Text(
        widget.text,
        style: (widget.style ?? AppTypography.displayMedium).copyWith(
          color: Colors.white,
        ),
      ),
    );
  }
}

/// Fade-in slide text animation
class FadeSlideText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final Duration delay;
  final Duration duration;
  final Offset slideOffset;
  final TextAlign? textAlign;

  const FadeSlideText({
    Key? key,
    required this.text,
    this.style,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 600),
    this.slideOffset = const Offset(0, 20),
    this.textAlign,
  }) : super(key: key);

  @override
  State<FadeSlideText> createState() => _FadeSlideTextState();
}

class _FadeSlideTextState extends State<FadeSlideText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: widget.slideOffset,
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: Transform.translate(
            offset: _slideAnimation.value,
            child: Text(
              widget.text,
              style: widget.style ?? AppTypography.bodyLarge,
              textAlign: widget.textAlign,
            ),
          ),
        );
      },
    );
  }
}

/// Staggered text animation (word by word)
class StaggeredText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final Duration wordDelay;
  final TextAlign? textAlign;

  const StaggeredText({
    Key? key,
    required this.text,
    this.style,
    this.wordDelay = const Duration(milliseconds: 100),
    this.textAlign,
  }) : super(key: key);

  @override
  State<StaggeredText> createState() => _StaggeredTextState();
}

class _StaggeredTextState extends State<StaggeredText> {
  final List<GlobalKey> _wordKeys = [];
  final List<bool> _wordVisible = [];

  @override
  void initState() {
    super.initState();
    final words = widget.text.split(' ');
    for (var i = 0; i < words.length; i++) {
      _wordKeys.add(GlobalKey());
      _wordVisible.add(false);
    }
    _animateWords();
  }

  void _animateWords() async {
    for (var i = 0; i < _wordVisible.length; i++) {
      await Future.delayed(widget.wordDelay);
      if (mounted) {
        setState(() {
          _wordVisible[i] = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final words = widget.text.split(' ');
    return Wrap(
      alignment: widget.textAlign == TextAlign.center
          ? WrapAlignment.center
          : WrapAlignment.start,
      children: words.asMap().entries.map((entry) {
        final index = entry.key;
        final word = entry.value;
        return AnimatedOpacity(
          duration: AppDurations.normal,
          opacity: _wordVisible[index] ? 1 : 0,
          child: AnimatedSlide(
            duration: AppDurations.normal,
            offset: _wordVisible[index] ? Offset.zero : const Offset(0, 0.5),
            child: Text(
              '$word ',
              style: widget.style ?? AppTypography.bodyLarge,
            ),
          ),
        );
      }).toList(),
    );
  }
}
