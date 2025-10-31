import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = FirebaseAuth.instance.currentUser;
    final userName = user?.displayName ?? 'User';
    final userEmail = user?.email ?? 'No email';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        automaticallyImplyLeading: false, 
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundColor: theme.primaryColor,   
              child: Text(
                userName.isNotEmpty ? userName[0].toUpperCase() : 'U',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onPrimary,   
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              userName,
              style: theme.textTheme.headlineSmall,   
            ),
            const SizedBox(height: 8),
            Text(
              userEmail,
              style: theme.textTheme.bodyMedium?.copyWith(fontSize: 16),   
            ),
            const SizedBox(height: 40),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: theme.dividerColor) 
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.person, color: theme.primaryColor),
                    title: Text(
                      'Name',
                      style: theme.textTheme.bodyMedium,
                    ),
                    subtitle: Text(
                      userName,
                      style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Divider(color: theme.dividerColor),
                  ListTile(
                    leading: Icon(Icons.email, color: theme.primaryColor),
                    title: Text(
                      'Email',
                      style: theme.textTheme.bodyMedium,
                    ),
                    subtitle: Text(
                      userEmail,
                      style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}