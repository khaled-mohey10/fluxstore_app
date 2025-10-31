import 'package:flutter/material.dart';

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
  final double? borderRadius; 

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height, 
    this.padding,
    this.borderRadius, 
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeStyle = theme.elevatedButtonTheme.style;


    final Color bgColor = backgroundColor ??
        (isOutlined
            ? Colors.transparent
            : theme.primaryColor);

    final Color fgColor = textColor ??
        (isOutlined
            ? bgColor 
            : theme.colorScheme.onPrimary);
            
    final BorderSide borderSide = isOutlined
        ? BorderSide(color: bgColor, width: 1.5)
        : BorderSide.none;
        
    final double radius = borderRadius ?? 
        (themeStyle?.shape?.resolve(Set()) as RoundedRectangleBorder?)?.borderRadius.resolve(TextDirection.ltr).topLeft.x ?? 30;

    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: themeStyle?.copyWith(
        backgroundColor: MaterialStateProperty.all(bgColor),
        foregroundColor: MaterialStateProperty.all(fgColor),
        elevation: MaterialStateProperty.all(isOutlined ? 0 : null),
        minimumSize: MaterialStateProperty.all(
          Size(width ?? double.infinity, height ?? (themeStyle.minimumSize?.resolve(Set())?.height ?? 56)),
        ),
        padding: MaterialStateProperty.all(padding),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
            side: borderSide,
          ),
        ),
      ),
      child: isLoading
          ? SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(fgColor),
              ),
            )
          : Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: fgColor, 
              ),
            ),
    );
  }
}