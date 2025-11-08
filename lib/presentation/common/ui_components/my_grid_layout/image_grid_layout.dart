import 'package:flutter/material.dart';

class ImageGridLayout extends StatelessWidget {
  /// List of widgets (typically images) to display in the grid
  final List<Widget> children;

  /// Spacing between items horizontally
  final double horizontalSpacing;

  /// Spacing between items vertically
  final double verticalSpacing;

  /// Padding around the entire grid
  final EdgeInsetsGeometry? padding;

  /// Border radius for each image container
  final BorderRadius? borderRadius;

  /// Height of the grid when there are multiple items
  final double? gridHeight;

  /// Aspect ratio for a single image (width / height)
  final double singleImageAspectRatio;

  /// Whether to clip the images with the border radius
  final bool clipImages;

  /// Whether to add a background color to the grid
  final Color? backgroundColor;

  /// Height of the grid for a single image
  final double? singleImageHeight;

  const ImageGridLayout({
    super.key,
    required this.children,
    this.horizontalSpacing = 8.0,
    this.verticalSpacing = 8.0,
    this.padding,
    this.borderRadius,
    this.gridHeight,
    this.singleImageAspectRatio = 16 / 9,
    this.clipImages = true,
    this.backgroundColor,
    this.singleImageHeight,
  });

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) {
      return const SizedBox.shrink();
    }

    // Apply padding if provided
    Widget result = Padding(
      padding: padding ?? EdgeInsets.zero,
      child: _buildGridBasedOnChildCount(),
    );

    // Apply background color if provided
    if (backgroundColor != null) {
      result = Container(
        color: backgroundColor,
        child: result,
      );
    }

    return result;
  }

  Widget _buildGridBasedOnChildCount() {
    // Case 1: Single image - takes full width
    if (children.length == 1) {
      return _buildSingleImage();
    }

    // Case 2: Two images - side by side
    if (children.length == 2) {
      return _buildTwoImages();
    }

    // Case 3: Three images - one large on left, two stacked on right
    if (children.length == 3) {
      return _buildThreeImages();
    }

    // Case 4: Four images - 2x2 grid
    if (children.length == 4) {
      return _buildFourImages();
    }

    // Case 5: More than 4 images - show first 4 with a +X overlay on the last one
    return _buildManyImages();
  }

  Widget _buildSingleImage() {
    return singleImageHeight != null
        ? SizedBox(
            height: singleImageHeight,
            width: double.infinity,
            child: _wrapWithClipIfNeeded(children[0]),
          )
        : AspectRatio(
            aspectRatio: singleImageAspectRatio,
            child: _wrapWithClipIfNeeded(children[0]),
          );
  }

  Widget _buildTwoImages() {
    return SizedBox(
      height: gridHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: _wrapWithClipIfNeeded(children[0])),
          SizedBox(width: horizontalSpacing),
          Expanded(child: _wrapWithClipIfNeeded(children[1])),
        ],
      ),
    );
  }

  Widget _buildThreeImages() {
    return SizedBox(
      height: gridHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Left image - takes half width and full height
          Expanded(
            flex: 1,
            child: _wrapWithClipIfNeeded(children[0]),
          ),
          SizedBox(width: horizontalSpacing),
          // Right column with two stacked images
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Expanded(
                  child: _wrapWithClipIfNeeded(children[1]),
                ),
                SizedBox(height: verticalSpacing),
                Expanded(
                  child: _wrapWithClipIfNeeded(children[2]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFourImages() {
    return SizedBox(
      height: gridHeight,
      child: Column(
        children: [
          // Top row
          Expanded(
            child: Row(
              children: [
                Expanded(child: _wrapWithClipIfNeeded(children[0])),
                SizedBox(width: horizontalSpacing),
                Expanded(child: _wrapWithClipIfNeeded(children[1])),
              ],
            ),
          ),
          SizedBox(height: verticalSpacing),
          // Bottom row
          Expanded(
            child: Row(
              children: [
                Expanded(child: _wrapWithClipIfNeeded(children[2])),
                SizedBox(width: horizontalSpacing),
                Expanded(child: _wrapWithClipIfNeeded(children[3])),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildManyImages() {
    // Show first 3 images like the three-image layout
    // For more than 4 images, we'll just use the first 3 and ignore the rest
    return _buildThreeImages();
  }

  Widget _wrapWithClipIfNeeded(Widget child) {
    // Check if the child is already an Expanded widget
    // If it is, we need to extract its child to avoid nested Expanded widgets
    if (child is Expanded) {
      final extractedChild = child.child;

      if (clipImages && borderRadius != null) {
        return ClipRRect(
          borderRadius: borderRadius!,
          child: extractedChild,
        );
      }
      return extractedChild;
    }

    // Normal case - not an Expanded widget
    if (clipImages && borderRadius != null) {
      return ClipRRect(
        borderRadius: borderRadius!,
        child: child,
      );
    }
    return child;
  }

  /// Creates a copy of this ImageGridLayout with the given fields replaced with new values
  ImageGridLayout copyWith({
    List<Widget>? children,
    double? horizontalSpacing,
    double? verticalSpacing,
    EdgeInsetsGeometry? padding,
    BorderRadius? borderRadius,
    double? gridHeight,
    double? singleImageAspectRatio,
    bool? clipImages,
    Color? backgroundColor,
    double? singleImageHeight,
  }) {
    return ImageGridLayout(
      horizontalSpacing: horizontalSpacing ?? this.horizontalSpacing,
      verticalSpacing: verticalSpacing ?? this.verticalSpacing,
      padding: padding ?? this.padding,
      borderRadius: borderRadius ?? this.borderRadius,
      gridHeight: gridHeight ?? this.gridHeight,
      singleImageAspectRatio:
          singleImageAspectRatio ?? this.singleImageAspectRatio,
      clipImages: clipImages ?? this.clipImages,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      singleImageHeight: singleImageHeight ?? this.singleImageHeight,
      children: children ?? this.children,
    );
  }
}
