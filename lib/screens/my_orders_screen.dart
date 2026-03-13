import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import 'checkout_screen.dart'; // لإعادة الطلب إذا أردنا

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  // فلاتر عرض الطلبات
  final List<String> _filters = ['الكل', 'قيد التنفيذ', 'مكتملة', 'ملغية'];
  String _selectedFilter = 'الكل';

  // بيانات وهمية للطلبات
  final List<Map<String, dynamic>> _allOrders = List.generate(10, (index) {
    List<String> statuses = ['قيد التنفيذ', 'مكتملة', 'ملغية'];
    List<Color> statusColors = [Colors.orange, Colors.green, Colors.red];
    int statusIndex = index % 3;
    return {
      'id': 'ORD-${2024000 + index}',
      'date': '${15 - index} مارس 2026',
      'items': [
        {'name': 'منتج ${index * 2 + 1}', 'price': 15000 + index * 500, 'quantity': 1},
        if (index % 2 == 0) {'name': 'منتج ${index * 2 + 2}', 'price': 8000 + index * 300, 'quantity': 2},
      ],
      'total': 23000 + index * 1000,
      'status': statuses[statusIndex],
      'statusColor': statusColors[statusIndex],
      'image': 'https://images.unsplash.com/photo-${1500000000 + index}?w=200',
    };
  });

  List<Map<String, dynamic>> get _filteredOrders {
    if (_selectedFilter == 'الكل') return _allOrders;
    return _allOrders.where((o) => o['status'] == _selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('طلباتي'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // شريط الفلاتر
          Container(
            height: 50,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _filters.length,
              itemBuilder: (context, index) {
                final filter = _filters[index];
                final isSelected = _selectedFilter == filter;
                return GestureDetector(
                  onTap: () => setState(() => _selectedFilter = filter),
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppTheme.goldColor
                          : (isDark ? AppTheme.darkCard : AppTheme.lightCard),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected
                            ? AppTheme.goldColor
                            : (isDark ? Colors.grey[800]! : Colors.grey[300]!),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        filter,
                        style: TextStyle(
                          color: isSelected ? Colors.black : null,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // قائمة الطلبات
          Expanded(
            child: _filteredOrders.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_bag_outlined, size: 80, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        const Text(
                          'لا توجد طلبات',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'لم تقم بشراء أي شيء بعد',
                          style: TextStyle(color: Colors.grey[500]),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            // العودة إلى المتجر
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.goldColor,
                            foregroundColor: Colors.black,
                          ),
                          child: const Text('تسوق الآن'),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredOrders.length,
                    itemBuilder: (context, index) {
                      final order = _filteredOrders[index];
                      return _buildOrderCard(order, index, isDark);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order, int index, bool isDark) {
    return GestureDetector(
      onTap: () {
        // يمكن فتح تفاصيل الطلب (يمكن إنشاء شاشة منفصلة لاحقاً)
        // Navigator.push(context, MaterialPageRoute(builder: (_) => OrderDetailScreen(order: order)));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: (order['statusColor'] as Color).withOpacity(0.3),
          ),
        ),
        child: Column(
          children: [
            // رأس البطاقة: رقم الطلب والحالة
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'طلب رقم: ${order['id']}',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: (order['statusColor'] as Color).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      order['status'],
                      style: TextStyle(
                        color: order['statusColor'],
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            // صورة مصغرة مع معلومات المنتجات
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // صورة أول منتج (كمثال)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      order['image'],
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  // تفاصيل مختصرة
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order['items'][0]['name'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        if (order['items'].length > 1)
                          Text(
                            '+ ${order['items'].length - 1} منتجات أخرى',
                            style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                          ),
                        const SizedBox(height: 8),
                        Text(
                          '${order['total'].toStringAsFixed(0)} ر.ي',
                          style: const TextStyle(
                            color: AppTheme.goldColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            // تاريخ الطلب وأزرار الإجراء
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        order['date'],
                        style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppTheme.goldColor,
                          side: const BorderSide(color: AppTheme.goldColor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('تفاصيل'),
                      ),
                      const SizedBox(width: 8),
                      if (order['status'] == 'قيد التنفيذ')
                        ElevatedButton(
                          onPressed: () {
                            // يمكن إعادة الطلب
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => CheckoutScreen(orderDetails: order),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.goldColor,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('إعادة الطلب'),
                        ),
                      if (order['status'] == 'مكتملة')
                        TextButton(
                          onPressed: () {},
                          child: const Text('تقييم'),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: (index * 50).ms).slideY(begin: 0.2, end: 0);
  }
}
