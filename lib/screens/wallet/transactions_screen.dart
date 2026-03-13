import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../theme/app_theme.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  String _selectedFilter = 'الكل';

  final List<String> _filters = [
    'الكل',
    'إيداع',
    'سحب',
    'تحويل',
    'دفع',
  ];

  final List<Map<String, dynamic>> _transactions = [
    {
      'type': 'إيداع',
      'amount': '+50,000',
      'date': 'اليوم، 10:30 ص',
      'description': 'إيداع عبر بطاقة ائتمان',
      'icon': Icons.arrow_downward,
      'color': Colors.green,
    },
    {
      'type': 'سحب',
      'amount': '-10,000',
      'date': 'أمس، 08:15 م',
      'description': 'سحب إلى البنك الأهلي',
      'icon': Icons.arrow_upward,
      'color': Colors.red,
    },
    {
      'type': 'تحويل',
      'amount': '-5,000',
      'date': 'أمس، 02:30 م',
      'description': 'تحويل إلى أحمد محمد',
      'icon': Icons.swap_horiz,
      'color': Colors.blue,
    },
    {
      'type': 'دفع',
      'amount': '-2,500',
      'date': '22/03، 09:00 ص',
      'description': 'دفع فاتورة كهرباء',
      'icon': Icons.receipt,
      'color': Colors.orange,
    },
    {
      'type': 'إيداع',
      'amount': '+25,000',
      'date': '21/03، 11:45 ص',
      'description': 'إيداع عبر كريمي',
      'icon': Icons.arrow_downward,
      'color': Colors.green,
    },
    {
      'type': 'سحب',
      'amount': '-15,000',
      'date': '20/03، 04:20 م',
      'description': 'سحب نقدي',
      'icon': Icons.arrow_upward,
      'color': Colors.red,
    },
    {
      'type': 'تحويل',
      'amount': '-8,000',
      'date': '19/03، 07:30 م',
      'description': 'تحويل إلى خالد علي',
      'icon': Icons.swap_horiz,
      'color': Colors.blue,
    },
    {
      'type': 'دفع',
      'amount': '-1,200',
      'date': '18/03، 10:00 ص',
      'description': 'شحن رصيد هاتف',
      'icon': Icons.receipt,
      'color': Colors.orange,
    },
  ];

  List<Map<String, dynamic>> get _filteredTransactions {
    if (_selectedFilter == 'الكل') {
      return _transactions;
    }
    return _transactions.where((t) => t['type'] == _selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('المعاملات'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('جاري تحميل كشف الحساب...'),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Balance Summary
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppTheme.goldPrimary, AppTheme.goldDark],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildBalanceItem('الإيداعات', '+125,000', Colors.green),
                Container(
                  width: 1,
                  height: 40,
                  color: Colors.black.withValues(alpha: 0.2),
                ),
                _buildBalanceItem('السحوبات', '-42,700', Colors.red),
              ],
            ),
          ).animate().fadeIn().scale(),

          // Filter Chips
          Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _filters.length,
              itemBuilder: (context, index) {
                final filter = _filters[index];
                final isSelected = _selectedFilter == filter;
                return GestureDetector(
                  onTap: () => setState(() => _selectedFilter = filter),
                  child: Container(
                    margin: const EdgeInsets.only(left: 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppTheme.goldColor
                          : (isDark ? AppTheme.darkCard : AppTheme.lightCard),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text(
                      filter,
                      style: TextStyle(
                        color: isSelected ? Colors.black : null,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          // Transactions List
          Expanded(
            child: _filteredTransactions.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _filteredTransactions.length,
                    itemBuilder: (context, index) {
                      final transaction = _filteredTransactions[index];
                      return _buildTransactionItem(transaction, index);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceItem(String label, String amount, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.black.withValues(alpha: 0.7),
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          amount,
          style: TextStyle(
            color: color,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 80,
            color: Colors.grey[600],
          ),
          const SizedBox(height: 16),
          Text(
            'لا توجد معاملات',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(Map<String, dynamic> transaction, int index) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = transaction['color'] as Color;
    final isPositive = (transaction['amount'] as String).startsWith('+');

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            transaction['icon'] as IconData,
            color: color,
          ),
        ),
        title: Text(
          transaction['description'] as String,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          '${transaction['type']} • ${transaction['date']}',
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: 12,
          ),
        ),
        trailing: Text(
          transaction['amount'] as String,
          style: TextStyle(
            color: isPositive ? Colors.green : Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    ).animate().fadeIn(delay: (index * 50).ms).slideX(begin: 0.2, end: 0);
  }
}
