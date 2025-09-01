import 'package:flutter/material.dart';
import 'package:glamour_app/core/constants/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showMenu;
  final bool showNotification;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showMenu = true,
    this.showNotification = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      leading: showMenu
          ? IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                // TODO: Implement menu functionality
              },
            )
          : null,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      actions: showNotification
          ? [
              IconButton(
                icon: const Icon(Icons.notifications, color: Colors.white),
                onPressed: () {
                  // TODO: Implement notification functionality
                },
              ),
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
