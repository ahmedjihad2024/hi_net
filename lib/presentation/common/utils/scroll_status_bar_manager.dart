import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io' show Platform;

class ScrollStatusBarManager {
  final ScrollController scrollController;
  final double scrollThreshold;
  
  // Color-based properties (for Android < 16)
  final Color? scrolledColor;
  final Color? defaultColor;
  
  // Brightness-based properties (for Android >= 16)
  final Brightness? scrolledIconBrightness;
  final Brightness? defaultIconBrightness;
  
  final VoidCallback? onStateChanged;

  bool _isScrolled = false;
  late final bool _useColorMode;

  ScrollStatusBarManager({
    required this.scrollController,
    this.scrollThreshold = 50.0,
    this.scrolledColor,
    this.defaultColor,
    this.scrolledIconBrightness,
    this.defaultIconBrightness,
    this.onStateChanged,
  }) {
    // Determine which mode to use based on Android version
    _useColorMode = _shouldUseColorMode();
    scrollController.addListener(_onScroll);
  }

  bool _shouldUseColorMode() {
    if (!Platform.isAndroid) {
      // On iOS, always use color mode if colors are provided
      return scrolledColor != null && defaultColor != null;
    }
    
    // For Android: 
    // - If only colors provided, use color mode (assumes SDK < 36)
    // - If only brightness provided, use brightness mode (assumes SDK >= 36)
    // - If both provided, SDK detection needed (use AndroidSDKChecker for accuracy)
    if (scrolledColor != null && defaultColor != null) {
      return true; // Use color mode
    }
    return false; // Use brightness mode
  }

  void _onScroll() {
    final scrollOffset = scrollController.offset;
    final shouldBeScrolled = scrollOffset > scrollThreshold;

    if (shouldBeScrolled != _isScrolled) {
      _isScrolled = shouldBeScrolled;

      if (_useColorMode) {
        // Use color-based approach (Android < 16 / API < 36)
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: shouldBeScrolled ? scrolledColor : defaultColor,
        ));
      } else {
        // Use brightness-based approach (Android >= 16 / API >= 36)
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarIconBrightness: shouldBeScrolled 
              ? (scrolledIconBrightness ?? Brightness.dark)
              : (defaultIconBrightness ?? Brightness.dark),
          // For iOS
          statusBarBrightness: shouldBeScrolled
              ? ((scrolledIconBrightness ?? Brightness.dark) == Brightness.dark 
                  ? Brightness.light 
                  : Brightness.dark)
              : ((defaultIconBrightness ?? Brightness.dark) == Brightness.dark 
                  ? Brightness.light 
                  : Brightness.dark),
        ));
      }

      onStateChanged?.call();
    }
  }

  bool get isScrolled => _isScrolled;

  void resetToDefault() {
    if (_isScrolled) {
      _isScrolled = false;
      
      if (_useColorMode) {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: defaultColor,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ));
      } else {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarIconBrightness: defaultIconBrightness ?? Brightness.dark,
          statusBarBrightness: (defaultIconBrightness ?? Brightness.dark) == Brightness.dark 
              ? Brightness.light 
              : Brightness.dark,
        ));
      }
      
      onStateChanged?.call();
    }
  }

  void dispose() {
    scrollController.removeListener(_onScroll);
  }
}

// Base class for easy integration with StatefulWidget
abstract class ScrollStatusBarState<T extends StatefulWidget> extends State<T>
    with WidgetsBindingObserver {
  ScrollStatusBarManager? _scrollStatusBarManager;

  void initializeScrollStatusBar({
    required ScrollController scrollController,
    double scrollThreshold = 25.0,
    Color? scrolledColor,
    Color? defaultColor,
    Brightness? scrolledIconBrightness,
    Brightness? defaultIconBrightness,
    VoidCallback? onStateChanged,
  }) {
    _scrollStatusBarManager = ScrollStatusBarManager(
      scrollController: scrollController,
      scrollThreshold: scrollThreshold,
      scrolledColor: scrolledColor,
      defaultColor: defaultColor,
      scrolledIconBrightness: scrolledIconBrightness,
      defaultIconBrightness: defaultIconBrightness,
      onStateChanged: onStateChanged,
    );

    // Add observer for app lifecycle changes
    WidgetsBinding.instance.addObserver(this);
  }

  bool get isScrolled => _scrollStatusBarManager?.isScrolled ?? false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    // Reset status bar when app is paused, inactive, or detached
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) {
      _scrollStatusBarManager?.resetToDefault();
    }
  }

  @override
  void deactivate() {
    // Reset status bar when widget is deactivated (navigating away)
    _scrollStatusBarManager?.resetToDefault();
    super.deactivate();
  }

  @override
  void dispose() {
    // Remove observer and reset status bar before disposing
    WidgetsBinding.instance.removeObserver(this);
    _scrollStatusBarManager?.resetToDefault();
    _scrollStatusBarManager?.dispose();
    super.dispose();
  }
}

// Mixin for backward compatibility (simplified version without lifecycle management)
mixin ScrollStatusBarMixin<T extends StatefulWidget> on State<T> {
  ScrollStatusBarManager? _scrollStatusBarManager;

  void initializeScrollStatusBar({
    required ScrollController scrollController,
    double scrollThreshold = 25.0,
    Color? scrolledColor,
    Color? defaultColor,
    Brightness? scrolledIconBrightness,
    Brightness? defaultIconBrightness,
    VoidCallback? onStateChanged,
  }) {
    _scrollStatusBarManager = ScrollStatusBarManager(
      scrollController: scrollController,
      scrollThreshold: scrollThreshold,
      scrolledColor: scrolledColor,
      defaultColor: defaultColor,
      scrolledIconBrightness: scrolledIconBrightness,
      defaultIconBrightness: defaultIconBrightness,
      onStateChanged: onStateChanged,
    );
  }

  bool get isScrolled => _scrollStatusBarManager?.isScrolled ?? false;

  // Manual reset method for programmatic status bar resets
  void resetStatusBar() {
    _scrollStatusBarManager?.resetToDefault();
  }

  @override
  void deactivate() {
    // Reset status bar when widget is deactivated (navigating away)
    _scrollStatusBarManager?.resetToDefault();
    super.deactivate();
  }

  @override
  void dispose() {
    // Reset status bar before disposing
    _scrollStatusBarManager?.resetToDefault();
    _scrollStatusBarManager?.dispose();
    super.dispose();
  }
}