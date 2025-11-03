import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:glamour_app/data/services/firebase_auth_service.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<void> _handleLogout(BuildContext context) async {
    final authService = FirebaseAuthService();
    await authService.signOut(context);
    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = FirebaseAuth.instance.currentUser;
    final userName = user?.displayName ?? 'User';
    final userEmail = user?.email ?? 'No email';

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 36,
                      backgroundColor: theme.primaryColor.withOpacity(0.1),
                      child: Text(
                        userName.isNotEmpty ? userName[0].toUpperCase() : 'U',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: theme.primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userName,
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            userEmail,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.settings_outlined,
                        color: theme.textTheme.bodyLarge?.color,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/profile-settings');
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200.withOpacity(0.6),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildProfileOption(
                        context,
                        Icons.location_on_outlined,
                        'Address',
                        () {
                          Navigator.pushNamed(context, '/address');
                        },
                      ),
                      _buildProfileOption(
                        context,
                        Icons.payment_outlined,
                        'Payment method',
                        () {
                          Navigator.pushNamed(context, '/payment-method');
                        },
                      ),
                      _buildProfileOption(
                        context,
                        Icons.local_offer_outlined,
                        'Voucher',
                        () {
                         Navigator.pushNamed(context, '/vouchers');
                        },
                      ),
                      _buildProfileOption(
                        context,
                        Icons.favorite_border,
                        'My Wishlist',
                        () {
                          Navigator.pushNamed(context, '/wishlist');
                        },
                      ),
                      _buildProfileOption(
                        context,
                        Icons.star_border,
                        'Rate this app',
                        () {
                          // TODO: Implement Rate app
                        },
                      ),
                      _buildProfileOption(context, Icons.logout, 'Log out', () {
                        _handleLogout(context);
                      }, showDivider: false),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileOption(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap, {
    bool showDivider = true,
  }) {
    final theme = Theme.of(context);
    return Column(
      children: [
        ListTile(
          leading: Icon(
            icon,
            color: theme.textTheme.bodyLarge?.color,
            size: 24,
          ),
          title: Text(
            title,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Colors.grey,
          ),
          onTap: onTap,
        ),
        if (showDivider)
          Divider(
            height: 1,
            color: theme.dividerColor.withOpacity(0.5),
            indent: 16,
            endIndent: 16,
          ),
      ],
    );
  }
}
