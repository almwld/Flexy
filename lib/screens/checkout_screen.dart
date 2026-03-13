import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';

class CheckoutScreen extends StatefulWidget {
  final Map<String, dynamic>? orderDetails; // تفاصيل الطلب من الشاشة السابقة
  const CheckoutScreen({super.key, this.orderDetails});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  // طرق الدفع
  final List<Map<String, dynamic>> _paymentMethods = [
    {'name': 'المحفظة (الرصيد)', 'icon': Icons.account_balance_wallet, 'color': Colors.amber, 'balance': '125,000 ر.ي'},
    {'name': 'بطاقة ائتمان', 'icon': Icons.credit_card, 'color': Colors.blue, 'last4': '4242'},
    {'name': 'تحويل بنكي', 'icon': Icons.account_balance, 'color': Colors.green, 'account': 'YE12 3456 7890'},
    {'name': 'كريمي', 'icon': Icons.phone_android, 'color': Colors.orange, 'phone': '777123456'},
  ];

  int _selectedMethodIndex = 0;
  bool _isLoading = false;
  bool _useDifferentAddress = false;

  // بيانات الطلب الوهمية (إذا لم تمر من الخارج)
  final Map<String, dynamic> _sampleOrder = {
    'items': [
      {'name': 'منتج 1', 'price': 15000, 'quantity': 1},
      {'name': 'منتج 2', 'price': 8000, 'quantity': 2},
    ],
    'shipping': 2000,
    'tax': 1500,
  };

  late Map<String, dynamic> _order;

  @override
  void initState() {
    super.initState();
    _order = widget.orderDetails ?? _sampleOrder;
  }

  double get _subtotal {
    double total = 0;
    for (var item in _order['items']) {
      total += item['price'] * item['quantity'];
    }
    return total;
  }

  double get _total => _subtotal + (_order['shipping'] ?? 0) + (_order['tax'] ?? 0);

  Future<void> _processPayment() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2)); // محاكاة معالجة الدفع

    if (mounted) {
      setState(() => _isLoading = false);
      _showSuccessDialog();
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? AppTheme.darkCard
            : AppTheme.lightCard,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Icon(Icons.check_circle, color: AppTheme.success, size: 60),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'تمت عملية الدفع بنجاح!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'رقم الطلب: #ORD-${DateTime.now().millisecondsSinceEpoch}',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // إغلاق الحوار
              Navigator.of(context).pop(); // العودة إلى الشاشة السابقة
            },
            child: const Text('تم'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('إتمام الشراء'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ملخص الطلب
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'ملخص الطلب',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  ..._order['items'].map<Widget>((item) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text('${item['name']} (x${item['quantity']})'),
                        ),
                        Text('${(item['price'] * item['quantity']).toStringAsFixed(0)} ر.ي'),
                      ],
                    ),
                  )),
                  const Divider(height: 24),
                  _buildRow('المجموع', _subtotal),
                  if (_order['shipping'] != null)
                    _buildRow('الشحن', _order['shipping']),
                  if (_order['tax'] != null)
                    _buildRow('الضريبة', _order['tax']),
                  const Divider(height: 16),
                  _buildRow('الإجمالي', _total, isTotal: true),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // طريقة الدفع
            const Text(
              'طريقة الدفع',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...List.generate(_paymentMethods.length, (index) {
              final method = _paymentMethods[index];
              final isSelected = _selectedMethodIndex == index;
              return GestureDetector(
                onTap: () => setState(() => _selectedMethodIndex = index),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? AppTheme.goldColor : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: (method['color'] as Color).withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(method['icon'], color: method['color']),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(method['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                            if (method.containsKey('balance'))
                              Text('الرصيد المتاح: ${method['balance']}', style: TextStyle(color: Colors.grey[500])),
                            if (method.containsKey('last4'))
                              Text('بطاقة تنتهي بـ ${method['last4']}', style: TextStyle(color: Colors.grey[500])),
                            if (method.containsKey('account'))
                              Text(method['account'], style: TextStyle(color: Colors.grey[500])),
                            if (method.containsKey('phone'))
                              Text(method['phone'], style: TextStyle(color: Colors.grey[500])),
                          ],
                        ),
                      ),
                      Radio<int>(
                        value: index,
                        groupValue: _selectedMethodIndex,
                        onChanged: (value) => setState(() => _selectedMethodIndex = value!),
                        activeColor: AppTheme.goldColor,
                      ),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 16),

            // عنوان التوصيل (اختياري)
            Container(
              decoration: BoxDecoration(
                color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  ListTile(
                    title: const Text('استخدام عنوان مختلف'),
                    trailing: Switch(
                      value: _useDifferentAddress,
                      onChanged: (value) => setState(() => _useDifferentAddress = value),
                      activeColor: AppTheme.goldColor,
                    ),
                  ),
                  if (_useDifferentAddress)
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: TextField(
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          hintText: 'أدخل عنوان التوصيل',
                          filled: true,
                          fillColor: isDark ? AppTheme.darkSurface : AppTheme.lightSurface,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        maxLines: 3,
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // زر تأكيد الدفع
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _processPayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.goldColor,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.black)
                    : const Text(
                        'تأكيد الدفع',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
              ),
            ).animate().fadeIn(delay: 200.ms).scale(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, double amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            '${amount.toStringAsFixed(0)} ر.ي',
            style: TextStyle(
              fontSize: isTotal ? 18 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? AppTheme.goldColor : null,
            ),
          ),
        ],
      ),
    );
  }
}
