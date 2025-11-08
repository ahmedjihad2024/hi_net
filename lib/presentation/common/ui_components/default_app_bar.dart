import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hi_net/app/extensions.dart';
import 'package:hi_net/presentation/common/ui_components/custom_ink_button.dart';
import 'package:hi_net/presentation/res/assets_manager.dart';
import 'package:hi_net/presentation/res/fonts_manager.dart';
import 'package:hi_net/presentation/res/sizes_manager.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.backFunction,
    this.actionButtons,
    this.customBackButton,
    this.hideBackButton = false,
    this.titleAlignment = Alignment.center,
    this.titleTextAlign = TextAlign.center,
    this.padding,
    this.height = 72,
  });

  final String? title;
  final Widget? titleWidget;
  final VoidCallback? backFunction;
  final List<Widget>? actionButtons;
  final Widget? customBackButton;
  final bool hideBackButton;
  final AlignmentGeometry titleAlignment;
  final TextAlign titleTextAlign;
  final EdgeInsetsGeometry? padding;
  final double height;

  @override
  Size get preferredSize => Size.fromHeight(height.h);

  EdgeInsetsGeometry get _defaultPadding =>
      EdgeInsets.symmetric(horizontal: SizeM.pagePadding.dg);

  Widget? _buildLeading(BuildContext context) {
    if (hideBackButton) return null;
    if (customBackButton != null) return customBackButton;

    return CustomInkButton(
      onTap: backFunction ?? () => Navigator.of(context).maybePop(),
      padding: EdgeInsets.zero,
      width: 40.w,
      height: 40.w,
      backgroundColor: Colors.transparent,
      borderRadius: SizeM.commonBorderRadius.r,
      alignment: Alignment.center,
      child: SvgPicture.asset(SvgM.arrowLeft, width: 14.w, height: 14.w),
    );
  }

  Widget _buildTitle(BuildContext context) {
    if (titleWidget == null && (title == null || title!.isEmpty)) {
      return const Spacer();
    }

    final Widget resolvedTitle = titleWidget ??
        Text(
          title!,
          textAlign: titleTextAlign,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: context.bodyLarge.copyWith(
            height: 1,
            fontFamily: FontsM.Nunito.name,
            fontWeight: FontWeightM.semiBold,
          ),
        );

    return Align(
      alignment: titleAlignment,
      child: resolvedTitle,
    );
  }

  @override
  Widget build(BuildContext context) {
    final leading = _buildLeading(context);
    final actions = actionButtons ?? const [];

    return Padding(
      padding: padding ?? _defaultPadding,
      child: SizedBox(
        height: preferredSize.height,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Leading slot
            SizedBox(
              width: 40.w,
              child: leading,
            ),

            // Title
            Expanded(
              child: _buildTitle(context),
            ),

            // Actions slot
            SizedBox(
              child: actions.isEmpty
                  ? null
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: actions
                          .map(
                            (action) => Padding(
                              padding: EdgeInsets.only(left: 6.w),
                              child: action,
                            ),
                          )
                          .toList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}