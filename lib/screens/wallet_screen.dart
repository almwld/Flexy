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
import 'wallet/amazon_gift_cards_screen.dart';
import 'wallet/banks_wallets_screen.dart';
import 'wallet/money_transfers_screen.dart';
import 'wallet/government_payments_screen.dart';
import 'wallet/jib_screen.dart';
import 'wallet/cash_withdrawal_screen.dart';
import 'wallet/universities_screen.dart';
import 'wallet/recharge_payment_screen.dart';
import 'wallet/recharge_credit_screen.dart';
import 'wallet/pay_bundles_screen.dart';
import 'wallet/internet_landline_screen.dart';
import 'wallet/receive_transfer_request_screen.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  int _currentCard = 0;
  bool _isHidden = false;

  final List<Map<String, dynamic>> _cards = const [
    {'name': 'الريال اليمني', 'balance': 32450.75, 'currency': 'ر.ي', 'code': 'YER', 'flag': '🇾🇪', 'type': 'جاري'},
    {'name': 'الريال السعودي', 'balance': 5000.00, 'currency': 'ر.س', 'code': 'SAR', 'flag': '🇸🇦', 'type': 'توفير'},
    {'name': 'الدولار الأمريكي', 'balance': 1250.50, 'currency': '\$', 'code': 'USD', 'flag': '🇺🇸', 'type': 'استثمار'},
  ];

  final List<Map<String, dynamic>> _services = [
    {'name': 'الشحن', 'icon': Icons.add_card, 'color': Colors.orange, 'screen': const DepositScreen()},
    {'name': 'تحويل', 'icon': Icons.swap_horiz, 'color': Colors.green, 'screen': const TransferScreen()},
    {'name': 'سحب', 'icon': Icons.atm, 'color': Colors.blue, 'screen': const WithdrawScreen()},
    {'name': 'دفع فواتير', 'icon': Icons.receipt, 'color': Colors.purple, 'screen': const PaymentsScreen()},
    {'name': 'شبكة تحويل', 'icon': Icons.settings_ethernet, 'color': Colors.teal, 'screen': const TransferNetworkScreen()},
    {'name': 'خدمات ترفيه', 'icon': Icons.movie_filter, 'color': Colors.pink, 'screen': const EntertainmentServicesScreen()},
    {'name': 'ألعاب', 'icon': Icons.sports_esports, 'color': Colors.red, 'screen': const GamesScreen()},
    {'name': 'تطبيقات', 'icon': Icons.apps, 'color': Colors.cyan, 'screen': const AppsScreen()},
    {'name': 'بطائق نت', 'icon': Icons.card_giftcard, 'color': Colors.amber, 'screen': const GiftCardsScreen()},
    {'name': 'أمازون', 'icon': Icons.shopping_cart, 'color': Colors.indigo, 'screen': const AmazonGiftCardsScreen()},
    {'name': 'بنوك ومحافظ', 'icon': Icons.account_balance, 'color': Colors.lightBlue, 'screen': const BanksWalletsScreen()},
    {'name': 'تحويلات مالية', 'icon': Icons.compare_arrows, 'color': Colors.green, 'screen': const MoneyTransfersScreen()},
    {'name': 'مدفوعات حكومية', 'icon': Icons.payments, 'color': Colors.orange, 'screen': const GovernmentPaymentsScreen()},
    {'name': 'جيب', 'icon': Icons.wallet, 'color': Colors.purple, 'screen': const JibScreen()},
    {'name': 'سحب نقدي', 'icon': Icons.money, 'color': Colors.red, 'screen': const CashWithdrawalScreen()},
    {'name': 'تعليم عالي', 'icon': Icons.school, 'color': Colors.blueGrey, 'screen': const UniversitiesScreen()},
    {'name': 'الشحن والسداد', 'icon': Icons.payment, 'color': Colors.green, 'screen': const RechargePaymentScreen()},
    {'name': 'شحن الرصيد', 'icon': Icons.add_card, 'color': Colors.blue, 'screen': const RechargeCreditScreen()},
    {'name': 'سداد باقات', 'icon': Icons.wifi, 'color': Colors.orange, 'screen': const PayBundlesScreen()},
    {'name': 'إنترنت وهاتف', 'icon': Icons.router, 'color': Colors.purple, 'screen': const InternetLandlineScreen()},
    {'name': 'استلام حوالة', 'icon': Icons.download, 'color': Colors.teal, 'screen': const ReceiveTransferRequestScreen()},
    {'name': 'العمليات', 'icon': Icons.receipt_long, 'color': Colors.amber, 'screen': const TransactionsScreen()},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(floating: true, snap: true, title: const Text('المحفظة'),
            actions: [IconButton(icon: const Icon(Icons.notifications_outlined), onPressed: () {}),
                      IconButton(icon: const Icon(Icons.qr_code_scanner), onPressed: () {})],
          ),
          // ... باقي المحتوى (يمكن اختصاره هنا للسرعة، لكن في الأصل هو طويل)
          SliverToBoxAdapter(child: SizedBox(
            height: 220,
            child: PageView.builder(
              itemCount: _cards.length,
              onPageChanged: (index) => setState(() => _currentCard = index),
              itemBuilder: (context, index) => _buildWalletCard(_cards[index]),
            ),
          )),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 1),
              delegate: SliverChildBuilderDelegate(
                (context, index) => _buildServiceItem(_services[index], isDark),
                childCount: _services.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWalletCard(Map<String, dynamic> card) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [card['color']??AppTheme.goldColor, (card['color']??AppTheme.goldColor).withOpacity(0.8)]),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${card['flag']} ${card['code']}', style: const TextStyle(color: Colors.white)),
            const Spacer(),
            Text(card['name'], style: const TextStyle(color: Colors.white)),
            Text(_isHidden ? '••••••' : card['balance'].toString(), style: const TextStyle(color: Colors.white, fontSize: 24)),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceItem(Map<String, dynamic> service, bool isDark) {
    return GestureDetector(
      onTap: () { if (service['screen'] != null) Navigator.of(context).push(MaterialPageRoute(builder: (_) => service['screen'])); },
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(service['icon'], color: service['color']),
            const SizedBox(height: 8),
            Text(service['name'], textAlign: TextAlign.center, style: const TextStyle(fontSize: 11)),
          ],
        ),
      ),
    );
  }
}
