import 'package:flutter/material.dart';
import 'package:glamour_app/core/constants/app_colors.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isOutlined;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height = 56,
    this.padding,
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    final Color defaultTextColor = isOutlined 
        ? (backgroundColor ?? AppColors.primary) 
        : (textColor ?? AppColors.onPrimary);
        
    final Color defaultBackgroundColor = isOutlined 
        ? Colors.transparent 
        : (backgroundColor ?? AppColors.primary);
        
    final BorderSide borderSide = isOutlined
        ? BorderSide(color: backgroundColor ?? AppColors.primary, width: 1.5)
        : BorderSide.none;

    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: defaultBackgroundColor,
        foregroundColor: textColor ?? defaultTextColor, 
        minimumSize: Size(width ?? double.infinity, height ?? 56),
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: borderSide,
        ),
        elevation: 0, 
      ),
      child: isLoading
          ? SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(defaultTextColor),
              ),
            )
          : Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: defaultTextColor, 
              ),
            ),
    );
  }
}