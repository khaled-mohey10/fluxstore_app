import 'package:flutter/material.dart';
import 'package:glamour_app/features/orders/presentation/widgets/order_card.dart';

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({super.key});

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _pendingOrders = [
    {
      'number': '1524',
      'date': '13/05/2021',
      'tracking': 'IK287368838',
      'quantity': 2,
      'subtotal': 110.00,
    },
    {
      'number': '1525',
      'date': '12/05/2021',
      'tracking': 'IK2873218897',
      'quantity': 3,
      'subtotal': 230.00,
    },
    {
      'number': '1526',
      'date': '10/05/2021',
      'tracking': 'IK237368820',
      'quantity': 5,
      'subtotal': 490.00,
    },
  ];

  final List<Map<String, dynamic>> _deliveredOrders = [
    {
      'number': '1514',
      'date': '13/05/2021',
      'tracking': 'IK987362341',
      'quantity': 2,
      'subtotal': 110.00,
    },
    {
      'number': '1679',
      'date': '12/05/2021',
      'tracking': 'IK3873218890',
      'quantity': 3,
      'subtotal': 450.00,
    },
  ];

  final List<Map<String, dynamic>> _cancelledOrders = [
    {
      'number': '1829',
      'date': '10/05/2021',
      'tracking': 'IK287368831',
      'quantity': 2,
      'subtotal': 210.00,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: theme.primaryColor,
          labelColor: theme.primaryColor,
          unselectedLabelColor: Colors.grey[600],
          tabs: const [
            Tab(text: 'Pending'),
            Tab(text: 'Delivered'),
            Tab(text: 'Cancelled'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // 1. Pending Orders
          _buildOrderList(_pendingOrders, 'PENDING'),

          // 2. Delivered Orders
          _buildOrderList(_deliveredOrders, 'DELIVERED'),

          // 3. Cancelled Orders
          _buildOrderList(_cancelledOrders, 'CANCELLED'),
        ],
      ),
    );
  }

  // Helper widget لبناء الليستة
  Widget _buildOrderList(List<Map<String, dynamic>> orders, String status) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return OrderCard(
          orderNumber: order['number'],
          date: order['date'],
          trackingNumber: order['tracking'],
          quantity: order['quantity'],
          subtotal: order['subtotal'],
          status: status,
          onDetailsTap: () {
            Navigator.pushNamed(
              context,
              '/order-info',
              arguments: {
                ...order, 
                'status': status, 
              },
            );
          },
        );
      },
    );
  }
}
