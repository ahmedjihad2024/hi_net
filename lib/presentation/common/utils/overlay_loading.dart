import 'dart:async';
import 'dart:ui';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:hi_net/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../res/color_manager.dart';
import '../../res/fonts_manager.dart';
import '../../res/translations_manager.dart';

enum LoadingType {
  spinner,
  dots,
  pulse,
  custom,
  widget,
}

enum BlurType {
  none,
  light,
  medium,
  heavy,
}

class OverlayLoading {
  // Singleton pattern
  static final OverlayLoading _instance = OverlayLoading._internal();
  factory OverlayLoading() => _instance;
  OverlayLoading._internal();

  static OverlayLoading get instance => _instance;

  // Instance variables
  OverlayEntry? _currentOverlay;
  bool _isLoading = false;
  bool _allowBackButton = false;
  late Future<void> Function() _hideFunction;

  // Enhanced configuration
  LoadingType _loadingType = LoadingType.spinner;
  BlurType _blurType = BlurType.medium;
  String? _customMessage;
  Color _backgroundColor = Colors.black.withOpacity(.6);
  Color _spinnerColor = Colors.white.withOpacity(.85);
  double _blurIntensity = 5.0;
  bool _showMessage = false;
  Duration _animationDuration = const Duration(milliseconds: 200);
  Widget? _customWidget;

  // Getters
  bool get isLoadingActive => _isLoading;

  // Configuration methods
  OverlayLoading setLoadingType(LoadingType type) {
    _loadingType = type;
    return this;
  }

  OverlayLoading setBlurType(BlurType type) {
    _blurType = type;
    switch (type) {
      case BlurType.none:
        _blurIntensity = 0.0;
        break;
      case BlurType.light:
        _blurIntensity = 2.0;
        break;
      case BlurType.medium:
        _blurIntensity = 5.0;
        break;
      case BlurType.heavy:
        _blurIntensity = 10.0;
        break;
    }
    return this;
  }

  OverlayLoading setCustomMessage(String message) {
    _customMessage = message;
    _showMessage = true;
    return this;
  }

  OverlayLoading setBackgroundColor(Color color) {
    _backgroundColor = color;
    return this;
  }

  OverlayLoading setSpinnerColor(Color color) {
    _spinnerColor = color;
    return this;
  }

  OverlayLoading setBlurIntensity(double intensity) {
    _blurIntensity = intensity;
    return this;
  }

  OverlayLoading showMessage(bool show) {
    _showMessage = show;
    return this;
  }

  OverlayLoading allowBackButton(bool allow) {
    _allowBackButton = allow;
    return this;
  }

  OverlayLoading setAnimationDuration(Duration duration) {
    _animationDuration = duration;
    return this;
  }

  OverlayLoading setCustomWidget(Widget widget) {
    _customWidget = widget;
    _loadingType = LoadingType.widget;
    return this;
  }

  // Show loading with context
  void showLoading(BuildContext context) {
    if (_isLoading) return;
    _isLoading = true;

    // Add back button interceptor only if not allowed
    if (!_allowBackButton) {
      BackButtonInterceptor.add(_backButtonInterceptor);
    }

    _currentOverlay = OverlayEntry(
      builder: (con) => Theme(
        data: Theme.of(context),
        child: EnhancedLoadingOverlay(
          overlayLoading: this,
          loadingType: _loadingType,
          blurType: _blurType,
          customMessage: _customMessage,
          backgroundColor: _backgroundColor,
          spinnerColor: _spinnerColor,
          blurIntensity: _blurIntensity,
          showMessage: _showMessage,
          animationDuration: _animationDuration,
          customWidget: _customWidget,
        ),
      ),
    );

    // Ensure we're using the navigator's overlay for best compatibility
    NAVIGATOR_KEY.currentState?.overlay?.insert(_currentOverlay!);

    // Provide haptic feedback to indicate loading
    HapticFeedback.lightImpact();
  }

  // Show loading globally (context-free)
  void showGlobalLoading({
    LoadingType loadingType = LoadingType.spinner,
    BlurType blurType = BlurType.none,
    String? customMessage,
    Color? backgroundColor,
    Color? spinnerColor,
    double? blurIntensity,
    bool showMessage = false,
    bool allowBackButton = false,
    Duration? animationDuration,
    Widget? customWidget,
  }) {
    // Wait for the next frame to ensure the navigator is ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = NAVIGATOR_KEY.currentContext;
      if (context == null) {
        print('Warning: No global context available for overlay loading');
        return;
      }

      // Configure the singleton instance
      setLoadingType(loadingType)
          .setBlurType(blurType)
          .showMessage(showMessage)
          .allowBackButton(allowBackButton);

      if (customMessage != null) {
        setCustomMessage(customMessage);
      }
      if (backgroundColor != null) {
        setBackgroundColor(backgroundColor);
      }
      if (spinnerColor != null) {
        setSpinnerColor(spinnerColor);
      }
      if (blurIntensity != null) {
        setBlurIntensity(blurIntensity);
      }
      if (animationDuration != null) {
        setAnimationDuration(animationDuration);
      }
      if (customWidget != null) {
        setCustomWidget(customWidget);
      }

      showLoading(context);
    });
  }

  // Hide loading
  Future<void> hideLoading() async {
    if (_isLoading) {
      _isLoading = false;

      // Remove back button interceptor
      if (!_allowBackButton) {
        BackButtonInterceptor.remove(_backButtonInterceptor);
      }

      try {
        await _hideFunction();
      } catch (e) {
        Timer.periodic(const Duration(milliseconds: 100), (t) async {
          try {
            await _hideFunction();
            t.cancel();
          } catch (e) {
            print(e);
          }
        });
      }
    }
  }

  // Hide global loading
  void hideGlobalLoading() {
    hideLoading();
  }

  // Set hide function
  void setHideFunction(Future<void> Function() fun) => _hideFunction = fun;

  // Intercept back button press
  bool _backButtonInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    // If loading is active and back button is not allowed, prevent back navigation
    if (_isLoading && !_allowBackButton) {
      // Provide feedback to indicate action is blocked
      HapticFeedback.vibrate();
      return true; // Intercept the back button
    }
    return false; // Allow back navigation when not loading or when allowed
  }

  // Reset configuration
  void reset() {
    _loadingType = LoadingType.spinner;
    _blurType = BlurType.medium;
    _customMessage = null;
    _backgroundColor = Colors.black.withOpacity(.6);
    _spinnerColor = Colors.white.withOpacity(.85);
    _blurIntensity = 5.0;
    _showMessage = false;
    _allowBackButton = false;
    _animationDuration = const Duration(milliseconds: 200);
    _customWidget = null;
  }
}

// Enhanced Loading Overlay Widget
class EnhancedLoadingOverlay extends StatefulWidget {
  final OverlayLoading overlayLoading;
  final LoadingType loadingType;
  final BlurType blurType;
  final String? customMessage;
  final Color backgroundColor;
  final Color spinnerColor;
  final double blurIntensity;
  final bool showMessage;
  final Duration animationDuration;
  final Widget? customWidget;

  const EnhancedLoadingOverlay({
    super.key,
    required this.overlayLoading,
    required this.loadingType,
    required this.blurType,
    this.customMessage,
    required this.backgroundColor,
    required this.spinnerColor,
    required this.blurIntensity,
    required this.showMessage,
    required this.animationDuration,
    this.customWidget,
  });

  @override
  State<EnhancedLoadingOverlay> createState() => _EnhancedLoadingOverlayState();
}

class _EnhancedLoadingOverlayState extends State<EnhancedLoadingOverlay>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  late AnimationController loopAnimationController;
  late Animation<double> loopAnimation;
  late AnimationController pulseAnimationController;
  late Animation<double> pulseAnimation;
  late AnimationController dotsAnimationController;
  late Animation<double> dotsAnimation;

  @override
  void initState() {
    super.initState();

    // Main fade animation
    animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
      reverseDuration: widget.animationDuration,
    );

    // Loop animation for spinner
    loopAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
      reverseDuration: const Duration(milliseconds: 700),
    );

    // Pulse animation for pulse loading type
    pulseAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    // Dots animation for dots loading type
    dotsAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    // Setup animations
    animation = animationController
        .drive(CurveTween(curve: Curves.easeInOutQuad))
        .drive(Tween(begin: 0.0, end: 1.0));

    loopAnimation = loopAnimationController
        .drive(CurveTween(curve: Curves.easeInOutQuad))
        .drive(Tween(begin: 0, end: .15));

    pulseAnimation = pulseAnimationController
        .drive(CurveTween(curve: Curves.easeInOut))
        .drive(Tween(begin: 0.5, end: 1.0));

    dotsAnimation = dotsAnimationController
        .drive(CurveTween(curve: Curves.easeInOut))
        .drive(Tween(begin: 0.0, end: 1.0));

    // Set hide function
    widget.overlayLoading.setHideFunction(() async {
      animationController.stop(canceled: true);
      await animationController.reverse();
      loopAnimationController.stop(canceled: true);
      pulseAnimationController.stop(canceled: true);
      dotsAnimationController.stop(canceled: true);
      widget.overlayLoading._currentOverlay!.remove();
    });

    // Start animations
    animationController.forward();
    loopAnimationController.repeat(reverse: true);
    pulseAnimationController.repeat(reverse: true);
    dotsAnimationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    loopAnimationController.dispose();
    pulseAnimationController.dispose();
    dotsAnimationController.dispose();
    super.dispose();
  }

  Widget _buildLoadingIndicator() {
    switch (widget.loadingType) {
      case LoadingType.spinner:
        return AnimatedBuilder(
          animation: loopAnimationController,
          builder: (context, child) {
            return Transform.rotate(
              angle: loopAnimation.value * 2 * 3.14159,
              child: CircularProgressIndicator(
                color: widget.spinnerColor,
                strokeCap: StrokeCap.round,
                strokeWidth: 3.w,
              ),
            );
          },
        );

      case LoadingType.dots:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (index) {
            return AnimatedBuilder(
              animation: dotsAnimationController,
              builder: (context, child) {
                final delay = index * 0.2;
                final animationValue = (dotsAnimation.value + delay) % 1.0;
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  width: 12.w,
                  height: 12.w,
                  decoration: BoxDecoration(
                    color: widget.spinnerColor.withOpacity(animationValue),
                    shape: BoxShape.circle,
                  ),
                );
              },
            );
          }),
        );

      case LoadingType.pulse:
        return AnimatedBuilder(
          animation: pulseAnimationController,
          builder: (context, child) {
            return Container(
              width: 60.w,
              height: 60.w,
              decoration: BoxDecoration(
                color: widget.spinnerColor.withOpacity(pulseAnimation.value),
                shape: BoxShape.circle,
              ),
            );
          },
        );

      case LoadingType.custom:
        return Container(
          width: 50.w,
          height: 50.w,
          decoration: BoxDecoration(
            color: widget.spinnerColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.hourglass_empty,
            color: widget.backgroundColor,
            size: 24.w,
          ),
        );
      case LoadingType.widget:
        return widget.customWidget ??
            CircularProgressIndicator(
              color: widget.spinnerColor,
              strokeCap: StrokeCap.round,
              strokeWidth: 3.w,
            );
    }
  }

  Widget _buildBlurBackground() {
    if (widget.blurType == BlurType.none) {
      return Container(
        color: widget.backgroundColor,
      );
    }

    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: widget.blurIntensity,
        sigmaY: widget.blurIntensity,
      ),
      child: Container(
        color: widget.backgroundColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, _) {
          return Opacity(
            opacity: animation.value,
            child: Stack(
              children: [
                // Blur background
                Positioned.fill(
                  child: _buildBlurBackground(),
                ),

                // Loading content
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Loading indicator
                      _buildLoadingIndicator(),

                      // Custom message
                      if (widget.showMessage &&
                          widget.customMessage != null) ...[
                        16.verticalSpace,
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 8.w,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            widget.customMessage!,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 14.sp,
                              fontWeight: FontWeightM.medium,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],

                      // Default loading message
                      if (widget.showMessage &&
                          widget.customMessage == null) ...[
                        16.verticalSpace,
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 8.w,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            Translation.loading.tr,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 14.sp,
                              fontWeight: FontWeightM.medium,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
