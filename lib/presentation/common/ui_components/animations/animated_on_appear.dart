import 'package:flutter/material.dart';

import 'animations_enum.dart';

/// A widget that animates its child when it first appears on screen.
///
/// Unlike [AnimatedOnScroll], this widget automatically animates when it is built,
/// making it ideal for page transitions or initial animations.
///
/// Supports both enter and exit animations for list items.
class AnimatedOnAppear extends StatefulWidget {
  final Widget child;
  final int delay;
  final SlideDirection slideDirection;
  final RotationDirection rotationDirection;
  final double slideDistance;
  final double rotationAngle; // Now in degrees
  final Duration animationDuration;
  final Curve animationCurve;
  final Set<AnimationType> animationTypes;
  final bool animate;
  final VoidCallback? onAnimationComplete;
  final double scaleSize;
  final ShaderRevealDirection shaderDirection;
  final Color shaderRevealColor;
  final double shaderSoftness;
  final BlendMode shaderBlendMode;
  
  // Exit animation properties
  final bool animateExit;
  final Duration exitDuration;
  final Curve exitCurve;
  final VoidCallback? onExitComplete;

  const AnimatedOnAppear({
    super.key,
    required this.child,
    this.delay = 0,
    this.slideDirection = SlideDirection.up,
    this.rotationDirection = RotationDirection.left,
    this.slideDistance = 50.0,
    this.rotationAngle = 5.0, // Default to 45 degrees
    this.animationDuration = const Duration(milliseconds: 800),
    this.animationCurve = Curves.easeOutCubic,
    this.animationTypes = const {AnimationType.slide, AnimationType.fade},
    this.animate = true,
    this.onAnimationComplete,
    this.scaleSize = 0.9,
    this.shaderDirection = ShaderRevealDirection.bottomToTop,
    this.shaderRevealColor = Colors.white,
    this.shaderSoftness = 0.2,
    this.shaderBlendMode = BlendMode.dstIn,
    this.animateExit = false,
    this.exitDuration = const Duration(milliseconds: 300),
    this.exitCurve = Curves.easeInCubic,
    this.onExitComplete,
  })  : assert(shaderSoftness >= 0 && shaderSoftness <= 1,
            'shaderSoftness must be between 0 and 1');

  // Convert degrees to turns
  double get _rotationInTurns => rotationAngle / 360.0;

  @override
  State<AnimatedOnAppear> createState() => _AnimatedOnAppearState();
}

class _AnimatedOnAppearState extends State<AnimatedOnAppear>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _shaderAnimation;
  
  bool _isExiting = false;
  bool _exitAnimationComplete = false;

  @override
  void initState() {
    super.initState();

    // Include the delay in the total animation duration
    final totalDuration =
        widget.animationDuration + Duration(milliseconds: widget.delay);

    _animationController = AnimationController(
      vsync: this,
      duration: totalDuration,
    );

    // Calculate the interval for the delayed animation
    final double delayFraction = widget.delay / totalDuration.inMilliseconds;
    final Interval delayedCurve = Interval(
      delayFraction, // Start after the delay
      1.0, // End at the end
      curve: widget.animationCurve,
    );

    // Apply the delayed curve to all animations
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: delayedCurve,
      ),
    );

    _slideAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: delayedCurve,
      ),
    );

    _scaleAnimation = Tween<double>(
      begin: widget.scaleSize,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: delayedCurve,
      ),
    );

    // Initialize rotation animation with degrees converted to turns
    final double startAngle = widget.rotationDirection == RotationDirection.left
        ? widget._rotationInTurns
        : -widget._rotationInTurns;
    _rotationAnimation = Tween<double>(
      begin: startAngle,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: delayedCurve,
      ),
    );

    _shaderAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: delayedCurve,
      ),
    );

    // For pulse animation, we need to adjust the interval to occur after the delay
    final pulseStart = delayFraction + ((1.0 - delayFraction) * 0.6);
    _pulseAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.08)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.08, end: 1.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
    ]).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(pulseStart, 1.0),
      ),
    );

    // Add listener for animation completion
    _animationController.addStatusListener(_animationStatusListener);

    // Start animation immediately - the delay is now handled by the Interval
    if (widget.animate) {
      _animationController.forward();
    }
  }

  void _animationStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      if (_isExiting) {
        // Exit animation completed
        _exitAnimationComplete = true;
        widget.onExitComplete?.call();
      } else {
        // Enter animation completed
        widget.onAnimationComplete?.call();
      }
    } else if (status == AnimationStatus.dismissed && _isExiting) {
      // Exit animation dismissed/completed
      _exitAnimationComplete = true;
      widget.onExitComplete?.call();
    }
  }

  Alignment _shaderBeginAlignment(
      ShaderRevealDirection direction, TextDirection textDirection) {
    switch (direction) {
      case ShaderRevealDirection.bottomToTop:
        return Alignment.bottomCenter;
      case ShaderRevealDirection.topToBottom:
        return Alignment.topCenter;
      case ShaderRevealDirection.leftToRight:
        return Alignment.centerLeft;
      case ShaderRevealDirection.rightToLeft:
        return Alignment.centerRight;
      case ShaderRevealDirection.startToEnd:
        return textDirection == TextDirection.rtl
            ? Alignment.centerRight
            : Alignment.centerLeft;
      case ShaderRevealDirection.endToStart:
        return textDirection == TextDirection.rtl
            ? Alignment.centerLeft
            : Alignment.centerRight;
    }
  }

  Alignment _shaderEndAlignment(
      ShaderRevealDirection direction, TextDirection textDirection) {
    switch (direction) {
      case ShaderRevealDirection.bottomToTop:
        return Alignment.topCenter;
      case ShaderRevealDirection.topToBottom:
        return Alignment.bottomCenter;
      case ShaderRevealDirection.leftToRight:
        return Alignment.centerRight;
      case ShaderRevealDirection.rightToLeft:
        return Alignment.centerLeft;
      case ShaderRevealDirection.startToEnd:
        return textDirection == TextDirection.rtl
            ? Alignment.centerLeft
            : Alignment.centerRight;
      case ShaderRevealDirection.endToStart:
        return textDirection == TextDirection.rtl
            ? Alignment.centerRight
            : Alignment.centerLeft;
    }
  }

  List<double> _shaderStops(double progress) {
    final clampedProgress = progress.clamp(0.0, 1.0);
    final transitionEnd =
        (clampedProgress + widget.shaderSoftness).clamp(0.0, 1.0);

    if (transitionEnd <= 0) {
      return const [0.0, 0.0, 0.0];
    }

    if (clampedProgress <= 0.0) {
      return [0.0, 0.0, transitionEnd];
    }

    return [0.0, clampedProgress, transitionEnd];
  }
  
  /// Triggers the exit animation
  void exit() {
    if (widget.animateExit && !_isExiting) {
      setState(() {
        _isExiting = true;
      });
      
      // Update controller duration for exit animation
      _animationController.duration = widget.exitDuration;
      
      // Reverse the animation for exit
      _animationController.reverse();
    } else {
      // If exit animation is not enabled, call callback immediately
      widget.onExitComplete?.call();
    }
  }

  @override
  void didUpdateWidget(AnimatedOnAppear oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // Update exit duration if changed
    if (widget.exitDuration != oldWidget.exitDuration && _isExiting) {
      _animationController.duration = widget.exitDuration;
    }
    
    // Handle animate property changes
    if (widget.animate && !oldWidget.animate && !_isExiting) {
      _animationController.duration = widget.animationDuration + Duration(milliseconds: widget.delay);
      _animationController.forward();
    } else if (!widget.animate && oldWidget.animate && !_isExiting) {
      _animationController.reverse();
    }
  }

  @override
  void dispose() {
    _animationController.removeStatusListener(_animationStatusListener);
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin
    
    // If exit animation is complete, return empty container
    if (_exitAnimationComplete) {
      return const SizedBox.shrink();
    }
    
    Widget animatedWidget = widget.child;

    // Apply animations based on selected types
    if (widget.animationTypes.contains(AnimationType.pulse)) {
      animatedWidget = ScaleTransition(
        scale: _pulseAnimation,
        child: animatedWidget,
      );
    }

    if (widget.animationTypes.contains(AnimationType.scale)) {
      animatedWidget = ScaleTransition(
        scale: _scaleAnimation,
        child: animatedWidget,
      );
    }

    if (widget.animationTypes.contains(AnimationType.rotation)) {
      animatedWidget = RotationTransition(
        turns: _rotationAnimation,
        child: animatedWidget,
      );
    }

    if (widget.animationTypes.contains(AnimationType.shader)) {
      animatedWidget = AnimatedBuilder(
        animation: _shaderAnimation,
        builder: (context, child) {
          final progress =
              (widget.animate || _isExiting) ? _shaderAnimation.value : 1.0;
          final textDirection = Directionality.of(context);

          return ShaderMask(
            shaderCallback: (Rect bounds) {
              if (progress <= 0.0) {
                return LinearGradient(
                  begin: _shaderBeginAlignment(
                      widget.shaderDirection, textDirection),
                  end:
                      _shaderEndAlignment(widget.shaderDirection, textDirection),
                  colors: [
                    widget.shaderRevealColor.withOpacity(0.0),
                    widget.shaderRevealColor.withOpacity(0.0),
                  ],
                  stops: const [0.0, 1.0],
                ).createShader(bounds);
              }

              final stops = _shaderStops(progress);
              return LinearGradient(
                begin: _shaderBeginAlignment(
                    widget.shaderDirection, textDirection),
                end: _shaderEndAlignment(widget.shaderDirection, textDirection),
                colors: [
                  widget.shaderRevealColor,
                  widget.shaderRevealColor,
                  widget.shaderRevealColor.withOpacity(0.0),
                ],
                stops: stops,
              ).createShader(bounds);
            },
            blendMode: widget.shaderBlendMode,
            child: child,
          );
        },
        child: animatedWidget,
      );
    }

    if (widget.animationTypes.contains(AnimationType.slide)) {
      animatedWidget = AnimatedBuilder(
        animation: _slideAnimation,
        builder: (context, child) {
          // Enter: slideAnimation goes from 1.0 to 0.0
          // Exit: slideAnimation goes from 0.0 to 1.0 (when reversed)
          double offset = widget.slideDistance * _slideAnimation.value;
          Offset translation;

          switch (widget.slideDirection) {
            case SlideDirection.up:
              // Enter: slides up from bottom (offset: slideDistance -> 0)
              // Exit: slides down to bottom (offset: 0 -> slideDistance)
              translation = Offset(0, offset);
              break;
            case SlideDirection.down:
              // Enter: slides down from top (offset: -slideDistance -> 0)
              // Exit: slides up to top (offset: 0 -> -slideDistance)
              translation = Offset(0, -offset);
              break;
            case SlideDirection.left:
              // Enter: slides from left (offset: slideDistance -> 0)
              // Exit: slides to left (offset: 0 -> slideDistance)
              translation = Offset(offset, 0);
              break;
            case SlideDirection.right:
              // Enter: slides from right (offset: -slideDistance -> 0)
              // Exit: slides to right (offset: 0 -> -slideDistance)
              translation = Offset(-offset, 0);
              break;
          }

          return Transform.translate(
            offset: translation,
            child: child,
          );
        },
        child: animatedWidget,
      );
    }

    if (widget.animationTypes.contains(AnimationType.fade)) {
      animatedWidget = FadeTransition(
        opacity: _fadeAnimation,
        child: animatedWidget,
      );
    }

    return animatedWidget;
  }

  @override
  bool get wantKeepAlive => true;
}

/// A class that provides pre-configured animation setups for common scenarios
class AppearAnimations {
  /// Slide in from bottom with fade
  static Widget fromBottom({
    required Widget child,
    int delay = 0,
    Duration duration = const Duration(milliseconds: 500),
    double slideDistance = 50.0,
  }) {
    return AnimatedOnAppear(
      delay: delay,
      slideDirection: SlideDirection.up,
      slideDistance: slideDistance,
      animationDuration: duration,
      child: child,
    );
  }

  /// Slide in from left with fade
  static Widget fromLeft({
    required Widget child,
    int delay = 0,
    Duration duration = const Duration(milliseconds: 500),
    double slideDistance = 50.0,
  }) {
    return AnimatedOnAppear(
      delay: delay,
      slideDirection: SlideDirection.right,
      slideDistance: slideDistance,
      animationDuration: duration,
      child: child,
    );
  }

  /// Slide in from right with fade
  static Widget fromRight({
    required Widget child,
    int delay = 0,
    Duration duration = const Duration(milliseconds: 500),
    double slideDistance = 50.0,
  }) {
    return AnimatedOnAppear(
      delay: delay,
      slideDirection: SlideDirection.left,
      slideDistance: slideDistance,
      animationDuration: duration,
      child: child,
    );
  }

  /// Fade in only
  static Widget fadeIn({
    required Widget child,
    int delay = 0,
    Duration duration = const Duration(milliseconds: 400),
  }) {
    return AnimatedOnAppear(
      delay: delay,
      animationDuration: duration,
      animationTypes: {AnimationType.fade},
      child: child,
    );
  }

  /// Scale up with fade
  static Widget scaleUp({
    required Widget child,
    int delay = 0,
    Duration duration = const Duration(milliseconds: 400),
    double scaleSize = 0.8,
  }) {
    return AnimatedOnAppear(
      delay: delay,
      animationDuration: duration,
      animationTypes: {AnimationType.scale, AnimationType.fade},
      scaleSize: scaleSize,
      child: child,
    );
  }

  /// Shader reveal animation with optional additional effects.
  static Widget shaderReveal({
    required Widget child,
    int delay = 0,
    Duration duration = const Duration(milliseconds: 600),
    ShaderRevealDirection direction = ShaderRevealDirection.bottomToTop,
    Color revealColor = Colors.white,
    double softness = 0.2,
    Set<AnimationType> extraTypes = const {},
  }) {
    final types = {AnimationType.shader, ...extraTypes};
    return AnimatedOnAppear(
      delay: delay,
      slideDirection: SlideDirection.up,
      animationDuration: duration,
      animationTypes: types,
      shaderDirection: direction,
      shaderRevealColor: revealColor,
      shaderSoftness: softness,
      child: child,
    );
  }

  /// Attention-grabbing pulse animation
  static Widget pulse({
    required Widget child,
    int delay = 0,
    Duration duration = const Duration(milliseconds: 700),
  }) {
    return AnimatedOnAppear(
      delay: delay,
      animationDuration: duration,
      animationTypes: {AnimationType.pulse},
      child: child,
    );
  }

  /// Cascade multiple children with staggered animation
  static List<Widget> cascade({
    required List<Widget> children,
    SlideDirection direction = SlideDirection.up,
    int initialDelay = 0,
    int delayBetween = 100,
    Duration duration = const Duration(milliseconds: 500),
    double slideDistance = 50.0,
    Set<AnimationType> types = const {AnimationType.slide, AnimationType.fade},
  }) {
    return List.generate(children.length, (index) {
      return AnimatedOnAppear(
        delay: initialDelay + (index * delayBetween),
        slideDirection: direction,
        slideDistance: slideDistance,
        animationDuration: duration,
        animationTypes: types,
        child: children[index],
      );
    });
  }

  /// Rotate in from a direction
  static Widget rotateIn({
    required Widget child,
    int delay = 0,
    Duration duration = const Duration(milliseconds: 500),
    RotationDirection direction = RotationDirection.left,
    double angle = 45.0, // Now in degrees
    bool withFade = true,
  }) {
    return AnimatedOnAppear(
      delay: delay,
      animationDuration: duration,
      rotationDirection: direction,
      rotationAngle: angle,
      animationTypes: withFade
          ? {AnimationType.rotation, AnimationType.fade}
          : {AnimationType.rotation},
      child: child,
    );
  }

  /// Rotate and scale in
  static Widget rotateAndScale({
    required Widget child,
    int delay = 0,
    Duration duration = const Duration(milliseconds: 500),
    RotationDirection direction = RotationDirection.left,
    double angle = 45.0, // Now in degrees
    double scaleSize = 0.9,
  }) {
    return AnimatedOnAppear(
      delay: delay,
      animationDuration: duration,
      rotationDirection: direction,
      rotationAngle: angle,
      scaleSize: scaleSize,
      animationTypes: {
        AnimationType.rotation,
        AnimationType.scale,
        AnimationType.fade
      },
      child: child,
    );
  }

  /// Slide out with fade - for exit animations
  static Widget slideOut({
    required Widget child,
    SlideDirection direction = SlideDirection.down,
    Duration duration = const Duration(milliseconds: 300),
    double slideDistance = 50.0,
    VoidCallback? onExitComplete,
  }) {
    return AnimatedOnAppear(
      animate: true,
      animateExit: true,
      exitDuration: duration,
      slideDirection: direction,
      slideDistance: slideDistance,
      animationDuration: duration,
      animationTypes: {AnimationType.slide, AnimationType.fade},
      onExitComplete: onExitComplete,
      child: child,
    );
  }

  /// Fade out only - for exit animations
  static Widget fadeOut({
    required Widget child,
    Duration duration = const Duration(milliseconds: 300),
    VoidCallback? onExitComplete,
  }) {
    return AnimatedOnAppear(
      animate: true,
      animateExit: true,
      exitDuration: duration,
      animationDuration: duration,
      animationTypes: {AnimationType.fade},
      onExitComplete: onExitComplete,
      child: child,
    );
  }

  /// Scale down with fade - for exit animations
  static Widget scaleDown({
    required Widget child,
    Duration duration = const Duration(milliseconds: 300),
    double scaleSize = 0.8,
    VoidCallback? onExitComplete,
  }) {
    return AnimatedOnAppear(
      animate: true,
      animateExit: true,
      exitDuration: duration,
      animationDuration: duration,
      animationTypes: {AnimationType.scale, AnimationType.fade},
      scaleSize: scaleSize,
      onExitComplete: onExitComplete,
      child: child,
    );
  }
}

/// Extension to easily trigger exit animations
extension AnimatedOnAppearExtension on GlobalKey<_AnimatedOnAppearState> {
  /// Triggers the exit animation for this widget
  void exit() {
    currentState?.exit();
  }
}
