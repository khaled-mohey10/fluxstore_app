import 'package:flutter/material.dart';
import 'package:glamour_app/core/constants/app_colors.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLines;
  final int? minLines;
  final bool enabled;
  final TextStyle? style;
  final String? initialValue;
  final int? maxLength; 
  final InputDecoration? decoration; 

  const AppTextField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.minLines,
    this.enabled = true,
    this.style,
    this.initialValue,
    this.maxLength, 
    this.decoration, 
  }) : assert(
          controller == null || initialValue == null,
          'لا يمكن استخدام controller و initialValue في نفس الوقت.',
        );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);


    final baseDecoration = decoration ?? const InputDecoration();


    final effectiveDecoration = baseDecoration.copyWith(
      hintText: hintText,
      labelText: labelText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      contentPadding: baseDecoration.contentPadding ?? 
          const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
    );

    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
      maxLines: maxLines,
      minLines: minLines,
      enabled: enabled,
      style:
          style ?? theme.textTheme.bodyLarge?.copyWith(color: AppColors.text),
      maxLength: maxLength, 
      decoration: effectiveDecoration,
    );
  }
}