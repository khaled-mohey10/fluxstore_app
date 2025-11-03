import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glamour_app/core/widgets/app_button.dart';
import 'package:glamour_app/core/widgets/app_text_field.dart';

class ProfileSettingPage extends StatefulWidget {
  const ProfileSettingPage({super.key});

  @override
  State<ProfileSettingPage> createState() => _ProfileSettingPageState();
}

class _ProfileSettingPageState extends State<ProfileSettingPage> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _genderController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _emailController.text = user.email ?? '';

      final nameParts = user.displayName?.split(' ') ?? [];
      _firstNameController.text = nameParts.isNotEmpty ? nameParts[0] : '';
      _lastNameController.text =
          nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';
      
      _genderController.text = 'Female'; 
      _phoneController.text = '(+1) 23456789';
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _genderController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Setting'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Stack(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: theme.primaryColor.withOpacity(0.1),
                  child: Text(
                    _firstNameController.text.isNotEmpty
                        ? _firstNameController.text[0].toUpperCase()
                        : 'U',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: theme.primaryColor,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.primaryColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 24,
                    ),
                    padding: const EdgeInsets.all(8),
                  ),
                )
              ],
            ),
            const SizedBox(height: 40),

            Row(
              children: [
                Expanded(
                  child: AppTextField(
                    controller: _firstNameController,
                    labelText: 'First Name',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: AppTextField(
                    controller: _lastNameController,
                    labelText: 'Last Name',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: _emailController,
              labelText: 'Email',
              enabled: false,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: AppTextField(
                    controller: _genderController,
                    labelText: 'Gender',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: AppTextField(
                    controller: _phoneController,
                    labelText: 'Phone',
                    keyboardType: TextInputType.phone,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 48),

            AppButton(
              text: 'Save change',
              onPressed: () {
                Navigator.pop(context);
              },
              backgroundColor: Colors.black,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}