import 'package:flutter/material.dart';
import 'package:glamour_app/core/constants/app_colors.dart';

class CustomSearchBar extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final VoidCallback? onSearchTap;

  const CustomSearchBar({
    super.key,
    this.hintText = 'Search',
    this.controller,
    this.onChanged,
    this.onSearchTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          prefixIcon: IconButton(
            icon: const Icon(Icons.search, color: Colors.grey),
            onPressed: onSearchTap,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }
}
