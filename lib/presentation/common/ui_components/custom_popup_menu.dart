import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_corner/smooth_corner.dart';

class CustomPopupMenu<T> extends StatelessWidget {
  final Widget child;
  final List<PopupMenuEntry<T>> items;
  final Function(T)? onSelected;
  final double? borderRadius;
  final double? elevation;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? menuPadding;
  final BoxConstraints? constraints;
  final BorderSide side;

  const CustomPopupMenu(
      {Key? key,
      required this.child,
      required this.items,
      this.onSelected,
      this.borderRadius,
      this.elevation,
      this.backgroundColor,
      this.padding,
      this.menuPadding,
      this.constraints,
      this.side = BorderSide.none})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<T>(
      itemBuilder: (context) => items,
      onSelected: onSelected,
      borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
      constraints: constraints ?? const BoxConstraints(),
      padding: padding ?? EdgeInsets.symmetric(vertical: 6.w, horizontal: 8.w),
      menuPadding: menuPadding ?? EdgeInsets.zero,
      icon: child,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 8.r), side: side),
      elevation: elevation ?? 4,
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: SmoothRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
            side: side),
      ),
    );
  }
}

// Helper class for creating popup menu items
class CustomPopupMenuItem<T> {
  static PopupMenuItem<T> create<T>({
    required T value,
    required String label,
    bool isSelected = false,
    Widget? leading,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return PopupMenuItem<T>(
      value: value,
      onTap: onTap,
      child: Row(
        children: [
          if (leading != null) ...[
            leading,
            8.horizontalSpace,
          ],
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: isSelected
                    ? const Color(0xFFD16F9A)
                    : const Color(0xFF040302),
                fontSize: 14.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ),
          if (trailing != null) ...[
            8.horizontalSpace,
            trailing,
          ] else if (isSelected) ...[
            const Spacer(),
            Icon(
              Icons.check,
              size: 16.w,
              color: const Color(0xFFD16F9A),
            ),
          ],
        ],
      ),
    );
  }

  static PopupMenuItem<T> createWithIcon<T>({
    required T value,
    required String label,
    required IconData icon,
    bool isSelected = false,
    Color? iconColor,
    VoidCallback? onTap,
  }) {
    return create<T>(
      value: value,
      label: label,
      isSelected: isSelected,
      onTap: onTap,
      leading: Icon(
        icon,
        size: 16.w,
        color: iconColor ??
            (isSelected ? const Color(0xFFD16F9A) : const Color(0xFF040302)),
      ),
    );
  }
}
