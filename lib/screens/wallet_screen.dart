import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'wallet/deposit_screen.dart';
import 'wallet/transfer_screen.dart';
import 'wallet/withdraw_screen.dart';
import 'wallet/transactions_screen.dart';
import 'wallet/payments_screen.dart';
import 'wallet/transfer_network_screen.dart';
import 'wallet/entertainment_services_screen.dart';
import 'wallet/games_screen.dart';
import 'wallet/apps_screen.dart';
import 'wallet/gift_cards_screen.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  int _currentCard = 0;
  bool _isHidden = false;

  final List<Map<String, dynamic>> _cards = [
    {
      'name': 'الريال اليمني',
      'balance': 32450.75,
      'currency': 'ر.ي',
      'code': 'YER',
      'color': AppTheme.goldColor,
      'flag': '🇾🇪',
      'type': 'جاري',
    },
    {
      'name': 'الريال السعودي',
      'balance': 5000.00,
      'currency': 'ر.س',
      'code': 'SAR',
      'color': Colors.green[700]!,
      'flag': '🇸🇦',
      'type': 'توفير',
    },
    {
      'name': 'الدولار الأمريكي',
      'balance': 1250.50,
      'currency': '\$',
      'code': 'USD',
      'color': Colors.blue[700]!,
      'flag': '🇺🇸',
      'type': 'استثمار',
    },
  ];

  // الخدمات الأساسية + الجديدة
  final List<Map<String, dynamic>> _services = [
    {'name': 'الشحن', 'icon': Icons.add_card, 'color': Colors.orange, 'screen': const DepositScreen()},
    {'name': 'تحويل', 'icon': Icons.swap_horiz, 'color': Colors.green, 'screen': const TransferScreen()},
    {'name': 'سحب', 'icon': Icons.atm, 'color': Colors.blue, 'screen': const WithdrawScreen()},
    {'name': 'دفع', 'icon': Icons.payments, 'color': Colors.purple, 'screen': const PaymentsScreen()},
    {'name': 'شبكة تحويل', 'icon': Icons.settings_ethernet, 'color': Colors.teal, 'screen': const TransferNetworkScreen()},
    {'name': 'خدمات ترفيه', 'icon': Icons.movie_filter, 'color': Colors.pink, 'screen': const EntertainmentServicesScreen()},
    {'name': 'ألعاب', 'icon': Icons.sports_esports, 'color': Colors.red, 'screen': const GamesScreen()},
    {'name': 'تطبيقات', 'icon': Icons.apps, 'color': Colors.cyan, 'screen': const AppsScreen()},
    {'name': 'بطائق نت', 'icon': Icons.card_giftcard, 'color': Colors.amber, 'screen': const GiftCardsScreen()},
    {'name': 'المشتريات', 'icon': Icons.shopping_bag, 'color': Colors.teal, 'screen': null},
    {'name': 'أونلاين', 'icon': Icons.language, 'color': Colors.indigo, 'screen': null},
    {'name': 'العمليات', 'icon': Icons.receipt_long, 'color': Colors.amber, 'screen': const TransactionsScreen()},
  ];

  // العمليات الأخيرة
  final List<Map<String, dynamic>> _transactions = [
    {'name': 'تحويل إلى أحمد', 'amount': -500, 'date': 'اليوم', 'icon': Icons.send, 'currency': 'ر.ي'},
    {'name': 'إيداع نقدي', 'amount': 5000, 'date': 'أمس', 'icon': Icons.add, 'currency': 'ر.ي'},
    {'name': 'شراء من متجر', 'amount': -1200, 'date': 'أمس', 'icon': Icons.shopping_cart, 'currency': 'ر.س'},
    {'name': 'استلام تحويل', 'amount': 10000, 'date': '22/03', 'icon': Icons.arrow_downward, 'currency': 'ر.ي'},
    {'name': 'دفع فاتورة', 'amount': -3500, 'date': '20/03', 'icon': Icons.receipt, 'currency': 'ر.ي'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            snap: true,
            title: const Text('المحفظة'),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.qr_code_scanner),
                onPressed: () {},
              ),
            ],
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.wb_sunny_outlined,
                        color: isDark ? Colors.grey[400] : Colors.orange,
                        size: 20,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'صباح الخير!',
                        style: TextStyle(
                          color: isDark ? Colors.grey[400] : Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'أحمد محمد',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'صنعاء، اليمن',
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark ? Colors.grey[400] : Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red[900]?.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.red, size: 20),
                    onPressed: () {},
                  ),
                  const Expanded(
                    child: Text(
                      'اضغط هنا لمزامنة الاقتراحات والمفضلة بين أجهزتك',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
                  const Icon(Icons.sync, color: Colors.red),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: SizedBox(
              height: 220,
              child: PageView.builder(
                itemCount: _cards.length,
                onPageChanged: (index) => setState(() => _currentCard = index),
                itemBuilder: (context, index) {
                  final card = _cards[index];
                  return _buildWalletCard(card);
                },
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _cards.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: _currentCard == index ? 24 : 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: _currentCard == index
                          ? _cards[index]['color']
                          : (isDark ? Colors.grey[700] : Colors.grey[300]),
                    ),
                  ),
                ),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final service = _services[index];
                  return _buildServiceItem(service);
                },
                childCount: _services.length,
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  const Icon(Icons.history, color: AppTheme.goldColor, size: 24),
                  const SizedBox(width: 8),
                  const Text(
                    'العمليات الأخيرة',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const TransactionsScreen()),
                    ),
                    child: const Text('عرض الكل'),
                  ),
                ],
              ),
            ),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final tx = _transactions[index];
                return _buildTransactionItem(tx);
              },
              childCount: _transactions.length,
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }

  Widget _buildWalletCard(Map<String, dynamic> card) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [card['color'], card['color'].withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: card['color'].withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -30,
            bottom: -30,
            child: Icon(
              Icons.account_balance_wallet,
              size: 180,
              color: Colors.white.withOpacity(0.1),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(card['flag'], style: const TextStyle(fontSize: 24)),
                        const SizedBox(width: 8),
                        Text(
                          card['code'],
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        card['type'],
                        style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 12),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  card['name'],
                  style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14),
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      _isHidden ? '••••••' : card['balance'].toStringAsFixed(2),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      card['currency'],
                      style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 18),
                    ),
                  ],
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: IconButton(
                    icon: Icon(
                      _isHidden ? Icons.visibility_off : Icons.visibility,
                      color: Colors.white.withOpacity(0.7),
                    ),
                    onPressed: () => setState(() => _isHidden = !_isHidden),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceItem(Map<String, dynamic> service) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        if (service['screen'] != null) {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => service['screen']));
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isDark ? Colors.grey[800]! : Colors.grey[300]!),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: service['color'].withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(service['icon'], color: service['color'], size: 28),
            ),
            const SizedBox(height: 8),
            Text(
              service['name'],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isDark ? Colors.white70 : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionItem(Map<String, dynamic> tx) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isPositive = tx['amount'] > 0;

    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isPositive ? Colors.green.withOpacity(0.2) : Colors.red.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(tx['icon'], color: isPositive ? Colors.green : Colors.red, size: 20),
      ),
      title: Text(tx['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(
        '${tx['date']} • ${tx['currency']}',
        style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[600], fontSize: 12),
      ),
      trailing: Text(
        '${isPositive ? '+' : ''}${tx['amount'].toStringAsFixed(0)}',
        style: TextStyle(
          color: isPositive ? Colors.green : (isDark ? Colors.white : Colors.black87),
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}
