import 'package:kena/app/components/loading_widget.dart';
import 'package:kena/app/styles/app_radiuses.dart';
import 'package:kena/app/utils/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    required this.label,
    super.key,
    this.onPressed,
    this.isDark = true,
    this.icon,
    this.isLoading = false,
    this.fontSize = 18,
    this.backgroundColor, // <-- Added
    this.textColor, // <-- Added
    this.borderColor, // <-- Added
    this.borderWidth, // <-- Added
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isDark;
  final Widget? icon;
  final bool isLoading;
  final double fontSize;

  // New Optional Fields
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double? borderWidth;

  @override
  Widget build(BuildContext context) {
    final isEnabled = onPressed != null && !isLoading;

    // Determine Background: Priority to [backgroundColor] param, then theme logic
    final resolvedBgColor =
        backgroundColor ??
        (isDark
            ? (isEnabled
                  ? context.colors.buttonPrimary
                  : context.colors.buttonDisabled)
            : (isEnabled
                  ? context.colors.buttonSecondary
                  : context.colors.buttonDisabled));

    // Determine Text Color: Priority to [textColor] param, then theme logic
    final resolvedTextColor =
        textColor ??
        (isDark
            ? (isEnabled ? context.colors.buttonPrimaryText : Colors.black26)
            : (isEnabled ? Colors.black26 : context.colors.buttonDisabled));

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: isEnabled
            ? onPressed
            : null, // Ensure button is disabled during loading
        style: ElevatedButton.styleFrom(
          fixedSize: Size(double.infinity, 56.h),
          backgroundColor: resolvedBgColor,
          foregroundColor: resolvedTextColor,
          elevation: backgroundColor == Colors.transparent
              ? 0
              : null, // Remove shadow for transparent buttons
          // Apply custom border if [borderColor] or [borderWidth] is provided
          side: (borderColor != null || borderWidth != null)
              ? BorderSide(
                  color: borderColor ?? Colors.transparent,
                  width: borderWidth ?? 1.0,
                )
              : null,

          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadiuses.largeRadius),
          ),
        ),
        icon: isLoading
            ? const SizedBox.shrink()
            : (icon ?? const SizedBox.shrink()),
        label: isLoading
            ? LoadingWidget(
                size: 24.sp,
                color: const Color.fromARGB(96, 168, 168, 168),
              )
            : Text(
                label,
                style: context.typography.button.copyWith(
                  color: resolvedTextColor,
                  fontSize: fontSize.sp,
                ),
              ),
      ),
    );
  }
}
