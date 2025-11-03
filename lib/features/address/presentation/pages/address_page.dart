import 'package:flutter/material.dart';
import 'package:glamour_app/core/widgets/app_button.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  int _selectedAddressIndex = 0; // 0 for Office, 1 for Home

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delivery address'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            _buildAddressCard(
              context,
              theme: theme,
              icon: Icons.business_center_outlined,
              title: 'SEND TO',
              address: 'My Office',
              details: 'SBI Building, street 3, Software Park',
              isSelected: _selectedAddressIndex == 0,
              onTap: () {
                setState(() {
                  _selectedAddressIndex = 0;
                });
              },
            ),
            const SizedBox(height: 16),
            _buildAddressCard(
              context,
              theme: theme,
              icon: Icons.home_outlined,
              title: 'SEND TO',
              address: 'My Home',
              details: 'SBI Building, street 3, Software Park',
              isSelected: _selectedAddressIndex == 1,
              onTap: () {
                setState(() {
                  _selectedAddressIndex = 1;
                });
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24.0),
        child: AppButton(
          text: 'Add new address',
          onPressed: () {
            // TODO: Implement Add new address
          },
          backgroundColor: Colors.black,
          textColor: Colors.white,
        ),
      ),
    );
  }

  Widget _buildAddressCard(
    BuildContext context, {
    required ThemeData theme,
    required IconData icon,
    required String title,
    required String address,
    required String details,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? theme.primaryColor : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: theme.primaryColor.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ]
              : [
                  BoxShadow(
                    color: Colors.grey.shade100,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  )
                ],
        ),
        child: Row(
          children: [
            Radio<bool>(
              value: true,
              groupValue: isSelected,
              onChanged: (val) => onTap(),
              activeColor: theme.primaryColor,
            ),
            Icon(icon, size: 32, color: theme.textTheme.bodyLarge?.color),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    address,
                    style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    details,
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                // TODO: Implement Edit
              },
              child: Text(
                'Edit',
                style: TextStyle(color: theme.primaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}