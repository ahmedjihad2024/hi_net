import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Defines the shape of the notch cutout.
enum NotchShape {
  /// A circular notch.
  circle,

  /// A rounded rectangle notch with customizable corner radius.
  roundedRectangle,

  /// A pill-shaped (capsule) notch.
  pill,

  /// A custom path notch (requires customPathBuilder).
  custom,
}

/// Defines the position of the notch along the container's edges.
enum NotchPosition {
  /// Notch on the top edge.
  top,

  /// Notch on the bottom edge.
  bottom,

  /// Notch on the left edge.
  left,

  /// Notch on the right edge.
  right,
}

/// A widget that displays a container with customizable notch cutouts and smooth iOS-like border radii.
///
/// This widget allows you to create containers with smooth border radii (using smooth_corner)
/// and one or more notch shapes cut out from any edge. It supports custom colors, gradients,
/// shadows, and precise control over the notch's size, position, depth, and smoothness.
///
/// Example:
/// ```dart
/// NotchContainer(
///   notchPosition: NotchPosition.bottom,
///   notchShape: NotchShape.circle,
///   notchSize: 60,
///   notchDepth: 30,
///   borderRadius: 20,
///   smoothness: 1.0,
///   color: Colors.blue,
///   child: YourContent(),
/// )
/// ```
///
///

class NotchContainer extends StatefulWidget {
  const NotchContainer({
    super.key,
    this.child,
    this.color,
    this.gradient,
    this.borderRadius = 0.0,
    this.smoothness = 1.0,
    this.boxShadow,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.notchShape = NotchShape.circle,
    this.notchPosition = NotchPosition.bottom,
    this.notchSize = 60.0,
    this.notchDepth = 30.0,
    this.notchOffset = 0.5,
    this.notchCornerRadius = 8.0,
    this.notchSmoothness = 0.8,
    this.customPathBuilder,
    this.border,
    this.clipChild = true,
    this.constraints,
    this.alignment,
    this.transform,
    this.opacity,
  });
  final Widget? child;
  final Color? color;
  final Gradient? gradient;
  final double borderRadius;
  final double smoothness;
  final List<BoxShadow>? boxShadow;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final NotchShape notchShape;
  final NotchPosition notchPosition;
  final double notchSize;
  final double notchDepth;
  final double notchOffset;
  final double notchCornerRadius;
  final double notchSmoothness;
  final Path Function(Offset center, double size, double depth)? customPathBuilder;
  final Border? border;
  final bool clipChild;
  final BoxConstraints? constraints;
  final AlignmentGeometry? alignment;
  final Matrix4? transform;
  final double? opacity;
  @override
  State<NotchContainer> createState() => _NotchContainerState(
    child: child,
    color: color,
    gradient: gradient,
    borderRadius: borderRadius,
    smoothness: smoothness,
    boxShadow: boxShadow,
    padding: padding,
    margin: margin,
    width: width,
    height: height,
    notchShape: notchShape,
    notchPosition: notchPosition,
    notchSize: notchSize,
    notchDepth: notchDepth,
    notchOffset: notchOffset,
    notchCornerRadius: notchCornerRadius,
    notchSmoothness: notchSmoothness,
    customPathBuilder: customPathBuilder,
    border: border,
    clipChild: clipChild,
    constraints: constraints,
    alignment: alignment,
    transform: transform,
    opacity: opacity,
  );
}

class _NotchContainerState extends State<NotchContainer> {
  /// The widget to be displayed inside the container.
  final Widget? child;

  /// The background color of the container.
  /// If [gradient] is provided, [color] will be ignored.
  final Color? color;

  /// The background gradient of the container.
  final Gradient? gradient;

  /// The border radius of the container corners.
  /// Uses smooth_corner for iOS-like smooth curves.
  final double borderRadius;

  /// The smoothness of the border radius (0.0 to 1.0).
  /// Higher values create smoother, more iOS-like curves.
  /// Defaults to 1.0.
  final double smoothness;

  /// A list of shadows to be cast by the container.
  final List<BoxShadow>? boxShadow;

  /// The padding to apply to the [child] within the container.
  final EdgeInsetsGeometry? padding;

  /// The margin to apply around the container.
  final EdgeInsetsGeometry? margin;

  /// The width of the container. If null, takes full width.
  final double? width;

  /// The height of the container. If null, takes full height.
  final double? height;

  /// The shape of the notch. Defaults to [NotchShape.circle].
  final NotchShape notchShape;

  /// The position of the notch. Defaults to [NotchPosition.bottom].
  final NotchPosition notchPosition;

  /// The size (width for horizontal, height for vertical) of the notch.
  /// For [NotchShape.circle], this is the diameter.
  /// Defaults to 60.0.
  final double notchSize;

  /// The depth of the notch (how far it extends into the container).
  /// For top/bottom notches, this is the vertical depth.
  /// For left/right notches, this is the horizontal depth.
  /// Defaults to 30.0.
  final double notchDepth;

  /// The offset of the notch along its edge, as a percentage (0.0 to 1.0).
  /// 0.0 means start, 0.5 means center, 1.0 means end.
  /// Defaults to 0.5 (centered).
  final double notchOffset;

  /// The corner radius for [NotchShape.roundedRectangle].
  /// Defaults to 8.0.
  final double notchCornerRadius;

  /// The smoothness of the notch transition (0.0 to 1.0).
  /// Higher values create smoother transitions from the container edge to the notch.
  /// Defaults to 0.8.
  final double notchSmoothness;

  /// Custom path builder for [NotchShape.custom].
  /// Receives the notch center position and size, and should return a Path.
  final Path Function(Offset center, double size, double depth)?
  customPathBuilder;

  /// Border around the container.
  final Border? border;

  /// Whether to clip the child to the notched shape.
  /// Defaults to true.
  final bool clipChild;

  /// Constraints for the container.
  final BoxConstraints? constraints;

  /// Alignment for the child widget.
  final AlignmentGeometry? alignment;

  /// Transform to apply to the container.
  final Matrix4? transform;

  /// Opacity of the container.
  final double? opacity;

  _NotchContainerState({
    this.child,
    this.color,
    this.gradient,
    this.borderRadius = 0.0,
    this.smoothness = 1.0,
    this.boxShadow,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.notchShape = NotchShape.circle,
    this.notchPosition = NotchPosition.bottom,
    this.notchSize = 60.0,
    this.notchDepth = 30.0,
    this.notchOffset = 0.5,
    this.notchCornerRadius = 8.0,
    this.notchSmoothness = 0.8,
    this.customPathBuilder,
    this.border,
    this.clipChild = true,
    this.constraints,
    this.alignment,
    this.transform,
    this.opacity,
  }) : assert(notchSize > 0, 'notchSize must be greater than 0'),
       assert(notchDepth >= 0, 'notchDepth must be greater than or equal to 0'),
       assert(
         notchOffset >= 0 && notchOffset <= 1,
         'notchOffset must be between 0 and 1',
       ),
       assert(
         notchSmoothness >= 0 && notchSmoothness <= 1,
         'notchSmoothness must be between 0 and 1',
       ),
       assert(
         smoothness >= 0 && smoothness <= 1,
         'smoothness must be between 0 and 1',
       ),
       assert(
         notchShape != NotchShape.custom || customPathBuilder != null,
         'customPathBuilder must be provided when notchShape is custom',
       );

  @override
  Widget build(BuildContext context) {
    final TextDirection textDirection = Directionality.of(context);
    final bool isRTL = textDirection == TextDirection.rtl;

    Widget container = _NotchContainerPainter(
      color: color,
      gradient: gradient,
      borderRadius: borderRadius,
      smoothness: smoothness,
      notchShape: notchShape,
      notchPosition: notchPosition,
      notchSize: notchSize,
      notchDepth: notchDepth,
      notchOffset: notchOffset,
      notchCornerRadius: notchCornerRadius,
      notchSmoothness: notchSmoothness,
      customPathBuilder: customPathBuilder,
      border: border,
      isRTL: isRTL,
      child: clipChild
          ? ClipPath(
              clipper: _NotchClipper(
                borderRadius: borderRadius,
                smoothness: smoothness,
                notchShape: notchShape,
                notchPosition: notchPosition,
                notchSize: notchSize,
                notchDepth: notchDepth,
                notchOffset: notchOffset,
                notchCornerRadius: notchCornerRadius,
                notchSmoothness: notchSmoothness,
                customPathBuilder: customPathBuilder,
                isRTL: isRTL,
              ),
              child: child != null
                  ? Container(
                      padding: padding,
                      alignment: alignment ?? Alignment.center,
                      child: child,
                    )
                  : null,
            )
          : child != null
          ? Container(
              padding: padding,
              alignment: alignment ?? Alignment.center,
              child: child,
            )
          : null,
    );

    if (boxShadow != null && boxShadow!.isNotEmpty) {
      container = Container(
        decoration: BoxDecoration(boxShadow: boxShadow),
        child: container,
      );
    }

    if (margin != null) {
      container = Padding(padding: margin!, child: container);
    }

    if (constraints != null) {
      container = ConstrainedBox(constraints: constraints!, child: container);
    }

    if (width != null || height != null) {
      container = SizedBox(width: width, height: height, child: container);
    }

    if (transform != null) {
      container = Transform(transform: transform!, child: container);
    }

    if (opacity != null) {
      container = Opacity(opacity: opacity!, child: container);
    }

    return container;
  }
}

/// Internal widget that handles the painting of the notched container.
class _NotchContainerPainter extends StatelessWidget {
  final Color? color;
  final Gradient? gradient;
  final double borderRadius;
  final double smoothness;
  final NotchShape notchShape;
  final NotchPosition notchPosition;
  final double notchSize;
  final double notchDepth;
  final double notchOffset;
  final double notchCornerRadius;
  final double notchSmoothness;
  final Path Function(Offset center, double size, double depth)?
  customPathBuilder;
  final Border? border;
  final bool isRTL;
  final Widget? child;

  const _NotchContainerPainter({
    required this.color,
    required this.gradient,
    required this.borderRadius,
    required this.smoothness,
    required this.notchShape,
    required this.notchPosition,
    required this.notchSize,
    required this.notchDepth,
    required this.notchOffset,
    required this.notchCornerRadius,
    required this.notchSmoothness,
    required this.customPathBuilder,
    required this.border,
    required this.isRTL,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _NotchPainter(
        color: color ?? Colors.transparent,
        gradient: gradient,
        borderRadius: borderRadius,
        smoothness: smoothness,
        notchShape: notchShape,
        notchPosition: notchPosition,
        notchSize: notchSize,
        notchDepth: notchDepth,
        notchOffset: notchOffset,
        notchCornerRadius: notchCornerRadius,
        notchSmoothness: notchSmoothness,
        customPathBuilder: customPathBuilder,
        border: border,
        isRTL: isRTL,
      ),
      child: child,
    );
  }
}

/// Custom painter that draws the notched container with smooth borders.
class _NotchPainter extends CustomPainter {
  final Color color;
  final Gradient? gradient;
  final double borderRadius;
  final double smoothness;
  final NotchShape notchShape;
  final NotchPosition notchPosition;
  final double notchSize;
  final double notchDepth;
  final double notchOffset;
  final double notchCornerRadius;
  final double notchSmoothness;
  final Path Function(Offset center, double size, double depth)?
  customPathBuilder;
  final Border? border;
  final bool isRTL;

  _NotchPainter({
    required this.color,
    required this.gradient,
    required this.borderRadius,
    required this.smoothness,
    required this.notchShape,
    required this.notchPosition,
    required this.notchSize,
    required this.notchDepth,
    required this.notchOffset,
    required this.notchCornerRadius,
    required this.notchSmoothness,
    required this.customPathBuilder,
    required this.border,
    required this.isRTL,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    if (gradient != null) {
      paint.shader = gradient!.createShader(
        Rect.fromLTWH(0, 0, size.width, size.height),
      );
    } else {
      paint.color = color;
    }

    // Create the main container path with smooth corners
    final Path containerPath = _createContainerPath(size);

    // Create the notch path
    final Path notchPath = _createNotchPath(size);

    // Combine paths: subtract notch from container
    final Path finalPath = Path.combine(
      PathOperation.difference,
      containerPath,
      notchPath,
    );

    // Draw the filled path
    canvas.drawPath(finalPath, paint);

    // Draw border if provided
    if (border != null && border!.top.width > 0) {
      final BorderSide borderSide = border!.top;
      final Paint borderPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = borderSide.width
        ..color = borderSide.color
        ..isAntiAlias = true;

      // For borders with notches, we need to draw the border path carefully
      // This is a simplified version - you may want to enhance this
      final Path borderPath = _createBorderPath(size, finalPath);
      canvas.drawPath(borderPath, borderPaint);
    }
  }

  /// Creates the main container path with smooth rounded corners.
  Path _createContainerPath(Size size) {
    if (borderRadius <= 0) {
      return Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    }

    // Use smooth corners for iOS-like appearance
    // smooth_corner uses SmoothRRect internally, but we'll create it manually
    // for the custom painter
    final RRect rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(borderRadius),
    );

    // For smooth corners, we approximate using cubic bezier curves
    // This is a simplified version - for true smooth corners, consider using
    // a library or more complex bezier calculations
    return _createSmoothRRectPath(rrect, smoothness);
  }

  /// Creates a smooth rounded rectangle path using cubic bezier curves for iOS-like smoothness.
  Path _createSmoothRRectPath(RRect rrect, double smoothness) {
    final Path path = Path();
    final double radius = math.min(
      math.min(rrect.width / 2, rrect.height / 2),
      math.min(rrect.tlRadiusX, rrect.tlRadiusY),
    );

    // For smooth iOS-like corners, use a magic number that creates the characteristic curve
    // This value (0.552284749831) creates a circle approximation using cubic bezier
    // Adjust based on smoothness parameter for more/less smoothness
    final double smoothFactor = 0.552284749831 * (0.7 + smoothness * 0.3);
    final double controlOffset = radius * smoothFactor;

    final double left = rrect.left;
    final double top = rrect.top;
    final double right = rrect.right;
    final double bottom = rrect.bottom;

    // Start from top-left, just after the corner starts
    path.moveTo(left + radius, top);

    // Top-right corner (using cubic bezier for smoothness)
    path.lineTo(right - radius, top);
    path.cubicTo(
      right - radius + controlOffset,
      top, // Control point 1
      right,
      top + radius - controlOffset, // Control point 2
      right,
      top + radius, // End point
    );

    // Right edge
    path.lineTo(right, bottom - radius);

    // Bottom-right corner
    path.cubicTo(
      right,
      bottom - radius + controlOffset,
      right - radius + controlOffset,
      bottom,
      right - radius,
      bottom,
    );

    // Bottom edge
    path.lineTo(left + radius, bottom);

    // Bottom-left corner
    path.cubicTo(
      left + radius - controlOffset,
      bottom,
      left,
      bottom - radius + controlOffset,
      left,
      bottom - radius,
    );

    // Left edge
    path.lineTo(left, top + radius);

    // Top-left corner
    path.cubicTo(
      left,
      top + radius - controlOffset,
      left + radius - controlOffset,
      top,
      left + radius,
      top,
    );

    path.close();
    return path;
  }

  /// Creates the notch cutout path.
  Path _createNotchPath(Size size) {
    final bool isHorizontal =
        notchPosition == NotchPosition.top ||
        notchPosition == NotchPosition.bottom;

    // Calculate notch center position
    double notchCenterX, notchCenterY;

    if (isHorizontal) {
      // Horizontal notch (top or bottom)
      final double effectiveOffset = isRTL ? 1.0 - notchOffset : notchOffset;
      notchCenterX = size.width * effectiveOffset;
      notchCenterY = notchPosition == NotchPosition.top
          ? -notchDepth / 2
          : size.height + notchDepth / 2;
    } else {
      // Vertical notch (left or right)
      final double effectiveOffset = isRTL ? 1.0 - notchOffset : notchOffset;
      notchCenterY = size.height * effectiveOffset;
      notchCenterX = notchPosition == NotchPosition.left
          ? -notchDepth / 2
          : size.width + notchDepth / 2;
    }

    final Offset notchCenter = Offset(notchCenterX, notchCenterY);

    // Create the notch shape
    switch (notchShape) {
      case NotchShape.circle:
        return _createCircleNotch(notchCenter, notchSize, notchDepth);
      case NotchShape.roundedRectangle:
        return _createRoundedRectangleNotch(
          notchCenter,
          notchSize,
          notchDepth,
          notchCornerRadius,
        );
      case NotchShape.pill:
        return _createPillNotch(
          notchCenter,
          notchSize,
          notchDepth,
          isHorizontal,
        );
      case NotchShape.custom:
        return customPathBuilder!(notchCenter, notchSize, notchDepth);
    }
  }

  /// Creates a circular notch.
  Path _createCircleNotch(Offset center, double size, double depth) {
    final Path path = Path();
    final double radius = size / 2;
    path.addOval(Rect.fromCircle(center: center, radius: radius + depth));
    return path;
  }

  /// Creates a rounded rectangle notch.
  Path _createRoundedRectangleNotch(
    Offset center,
    double size,
    double depth,
    double cornerRadius,
  ) {
    final Path path = Path();
    final bool isHorizontal =
        notchPosition == NotchPosition.top ||
        notchPosition == NotchPosition.bottom;

    if (isHorizontal) {
      final double width = size;
      final double height = depth * 2;
      final Rect rect = Rect.fromCenter(
        center: center,
        width: width,
        height: height,
      );
      path.addRRect(
        RRect.fromRectAndRadius(rect, Radius.circular(cornerRadius)),
      );
    } else {
      final double width = depth * 2;
      final double height = size;
      final Rect rect = Rect.fromCenter(
        center: center,
        width: width,
        height: height,
      );
      path.addRRect(
        RRect.fromRectAndRadius(rect, Radius.circular(cornerRadius)),
      );
    }

    return path;
  }

  /// Creates a pill-shaped (capsule) notch.
  Path _createPillNotch(
    Offset center,
    double size,
    double depth,
    bool isHorizontal,
  ) {
    final Path path = Path();
    final double radius = math.min(size, depth * 2) / 2;

    if (isHorizontal) {
      final double width = size;
      final double height = depth * 2;
      final Rect rect = Rect.fromCenter(
        center: center,
        width: width,
        height: height,
      );
      path.addRRect(RRect.fromRectAndRadius(rect, Radius.circular(radius)));
    } else {
      final double width = depth * 2;
      final double height = size;
      final Rect rect = Rect.fromCenter(
        center: center,
        width: width,
        height: height,
      );
      path.addRRect(RRect.fromRectAndRadius(rect, Radius.circular(radius)));
    }

    return path;
  }

  /// Creates the border path (simplified - may need enhancement for complex cases).
  Path _createBorderPath(Size size, Path filledPath) {
    // For a proper border with notches, we'd need to trace the filled path
    // and create a stroke path. This is a simplified version.
    return filledPath;
  }

  @override
  bool shouldRepaint(covariant _NotchPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.gradient != gradient ||
        oldDelegate.borderRadius != borderRadius ||
        oldDelegate.smoothness != smoothness ||
        oldDelegate.notchShape != notchShape ||
        oldDelegate.notchPosition != notchPosition ||
        oldDelegate.notchSize != notchSize ||
        oldDelegate.notchDepth != notchDepth ||
        oldDelegate.notchOffset != notchOffset ||
        oldDelegate.notchCornerRadius != notchCornerRadius ||
        oldDelegate.notchSmoothness != notchSmoothness ||
        oldDelegate.border != border ||
        oldDelegate.isRTL != isRTL;
  }
}

/// Custom clipper that clips widgets to the notched container shape.
class _NotchClipper extends CustomClipper<Path> {
  final double borderRadius;
  final double smoothness;
  final NotchShape notchShape;
  final NotchPosition notchPosition;
  final double notchSize;
  final double notchDepth;
  final double notchOffset;
  final double notchCornerRadius;
  final double notchSmoothness;
  final Path Function(Offset center, double size, double depth)?
  customPathBuilder;
  final bool isRTL;

  _NotchClipper({
    required this.borderRadius,
    required this.smoothness,
    required this.notchShape,
    required this.notchPosition,
    required this.notchSize,
    required this.notchDepth,
    required this.notchOffset,
    required this.notchCornerRadius,
    required this.notchSmoothness,
    required this.customPathBuilder,
    required this.isRTL,
  });

  @override
  Path getClip(Size size) {
    // Create container path
    final Path containerPath = _createContainerPath(size);

    // Create notch path
    final Path notchPath = _createNotchPath(size);

    // Combine: subtract notch from container
    return Path.combine(PathOperation.difference, containerPath, notchPath);
  }

  Path _createContainerPath(Size size) {
    if (borderRadius <= 0) {
      return Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    }

    final RRect rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(borderRadius),
    );

    return _createSmoothRRectPath(rrect, smoothness);
  }

  Path _createSmoothRRectPath(RRect rrect, double smoothness) {
    final Path path = Path();
    final double radius = math.min(
      math.min(rrect.width / 2, rrect.height / 2),
      math.min(rrect.tlRadiusX, rrect.tlRadiusY),
    );

    // For smooth iOS-like corners, use a magic number that creates the characteristic curve
    final double smoothFactor = 0.552284749831 * (0.7 + smoothness * 0.3);
    final double controlOffset = radius * smoothFactor;

    final double left = rrect.left;
    final double top = rrect.top;
    final double right = rrect.right;
    final double bottom = rrect.bottom;

    path.moveTo(left + radius, top);

    path.lineTo(right - radius, top);
    path.cubicTo(
      right - radius + controlOffset,
      top,
      right,
      top + radius - controlOffset,
      right,
      top + radius,
    );

    path.lineTo(right, bottom - radius);
    path.cubicTo(
      right,
      bottom - radius + controlOffset,
      right - radius + controlOffset,
      bottom,
      right - radius,
      bottom,
    );

    path.lineTo(left + radius, bottom);
    path.cubicTo(
      left + radius - controlOffset,
      bottom,
      left,
      bottom - radius + controlOffset,
      left,
      bottom - radius,
    );

    path.lineTo(left, top + radius);
    path.cubicTo(
      left,
      top + radius - controlOffset,
      left + radius - controlOffset,
      top,
      left + radius,
      top,
    );

    path.close();
    return path;
  }

  Path _createNotchPath(Size size) {
    final bool isHorizontal =
        notchPosition == NotchPosition.top ||
        notchPosition == NotchPosition.bottom;

    double notchCenterX, notchCenterY;

    if (isHorizontal) {
      final double effectiveOffset = isRTL ? 1.0 - notchOffset : notchOffset;
      notchCenterX = size.width * effectiveOffset;
      notchCenterY = notchPosition == NotchPosition.top
          ? -notchDepth / 2
          : size.height + notchDepth / 2;
    } else {
      final double effectiveOffset = isRTL ? 1.0 - notchOffset : notchOffset;
      notchCenterY = size.height * effectiveOffset;
      notchCenterX = notchPosition == NotchPosition.left
          ? -notchDepth / 2
          : size.width + notchDepth / 2;
    }

    final Offset notchCenter = Offset(notchCenterX, notchCenterY);

    switch (notchShape) {
      case NotchShape.circle:
        return _createCircleNotch(notchCenter, notchSize, notchDepth);
      case NotchShape.roundedRectangle:
        return _createRoundedRectangleNotch(
          notchCenter,
          notchSize,
          notchDepth,
          notchCornerRadius,
        );
      case NotchShape.pill:
        return _createPillNotch(
          notchCenter,
          notchSize,
          notchDepth,
          isHorizontal,
        );
      case NotchShape.custom:
        return customPathBuilder!(notchCenter, notchSize, notchDepth);
    }
  }

  Path _createCircleNotch(Offset center, double size, double depth) {
    final Path path = Path();
    final double radius = size / 2;
    path.addOval(Rect.fromCircle(center: center, radius: radius + depth));
    return path;
  }

  Path _createRoundedRectangleNotch(
    Offset center,
    double size,
    double depth,
    double cornerRadius,
  ) {
    final Path path = Path();
    final bool isHorizontal =
        notchPosition == NotchPosition.top ||
        notchPosition == NotchPosition.bottom;

    if (isHorizontal) {
      final double width = size;
      final double height = depth * 2;
      final Rect rect = Rect.fromCenter(
        center: center,
        width: width,
        height: height,
      );
      path.addRRect(
        RRect.fromRectAndRadius(rect, Radius.circular(cornerRadius)),
      );
    } else {
      final double width = depth * 2;
      final double height = size;
      final Rect rect = Rect.fromCenter(
        center: center,
        width: width,
        height: height,
      );
      path.addRRect(
        RRect.fromRectAndRadius(rect, Radius.circular(cornerRadius)),
      );
    }

    return path;
  }

  Path _createPillNotch(
    Offset center,
    double size,
    double depth,
    bool isHorizontal,
  ) {
    final Path path = Path();
    final double radius = math.min(size, depth * 2) / 2;

    if (isHorizontal) {
      final double width = size;
      final double height = depth * 2;
      final Rect rect = Rect.fromCenter(
        center: center,
        width: width,
        height: height,
      );
      path.addRRect(RRect.fromRectAndRadius(rect, Radius.circular(radius)));
    } else {
      final double width = depth * 2;
      final double height = size;
      final Rect rect = Rect.fromCenter(
        center: center,
        width: width,
        height: height,
      );
      path.addRRect(RRect.fromRectAndRadius(rect, Radius.circular(radius)));
    }

    return path;
  }

  @override
  bool shouldReclip(covariant _NotchClipper oldClipper) {
    return oldClipper.borderRadius != borderRadius ||
        oldClipper.smoothness != smoothness ||
        oldClipper.notchShape != notchShape ||
        oldClipper.notchPosition != notchPosition ||
        oldClipper.notchSize != notchSize ||
        oldClipper.notchDepth != notchDepth ||
        oldClipper.notchOffset != notchOffset ||
        oldClipper.notchCornerRadius != notchCornerRadius ||
        oldClipper.notchSmoothness != notchSmoothness ||
        oldClipper.isRTL != isRTL;
  }
}
