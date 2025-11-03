import 'package:flutter/material.dart';

class VoucherPage extends StatelessWidget {
  const VoucherPage({super.key});

  final List<Map<String, String>> _vouchers = const [
    {
      'percent': '50%',
      'title': 'Black Friday',
      'subtitle': 'Sale off 50%',
      'code': 'fridaysale',
      'expiry': 'Exp.\n20 Dec'
    },
    {
      'percent': '30%',
      'title': 'Holiday Sale',
      'subtitle': 'Sale off 30%',
      'code': 'holiday30',
      'expiry': 'Exp.\n22 Dec'
    },
    {
      'percent': '20%',
      'title': 'First order',
      'subtitle': '20% off your first order',
      'code': 'welcome',
      'expiry': 'Exp.\n28 Dec'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Voucher'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _vouchers.length,
        itemBuilder: (context, index) {
          final voucher = _vouchers[index];
          return _buildVoucherCard(context, theme, voucher);
        },
      ),
    );
  }

  Widget _buildVoucherCard(
      BuildContext context, ThemeData theme, Map<String, String> voucher) {
    return Container(
      height: 100,
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200.withOpacity(0.7),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          // --- جزء النسبة المئوية ---
          Container(
            width: 90,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
            child: Center(
              child: Text(
                voucher['percent']!,
                style: theme.textTheme.headlineSmall
                    ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          
          // --- جزء التفاصيل ---
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    voucher['title']!,
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    voucher['subtitle']!,
                    style: theme.textTheme.bodyMedium,
                  ),
                  const Spacer(),
                  Text(
                    'Code: ${voucher['code']!}',
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),

          // --- جزء تاريخ الانتهاء ---
          Container(
            width: 60,
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(color: Colors.grey[300]!, style: BorderStyle.solid, width: 1),
              ),
            ),
            child: Text(
              voucher['expiry']!,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
            ),
          ),
        ],
      ),
    );
  }
}