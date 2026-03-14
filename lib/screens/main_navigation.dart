import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';
import 'wallet_screen.dart';
import 'profile_screen.dart';
import 'add_ad_screen.dart';
import 'chat_screen.dart';
import 'all_ads_screen.dart';
import 'map_screen.dart';

class MainNavigation extends StatefulWidget {
  final bool isGuest;
  const MainNavigation({super.key, this.isGuest = false});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  // قائمة الشاشات حسب الترتيب: الرئيسية، المتجر، الخريطة، المحفظة، الدردشة، حسابي
  // الزر المركزي (+) سيؤدي إلى شاشة إضافة إعلان (index منفصل)
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      const HomeScreen(),                // 0: الرئيسية
      const AllAdsScreen(),               // 1: المتجر
      const MapScreen(),                  // 2: الخريطة
      const WalletScreen(),               // 3: المحفظة
      const ChatScreen(),                  // 4: الدردشة
      ProfileScreen(isGuest: widget.isGuest), // 5: حسابي
    ];
  }

  // عند الضغط على الزر المركزي (+) نذهب إلى شاشة إضافة إعلان (index منفصل)
  void _onCenterButtonPressed() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const AddAdScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: _screens[_currentIndex],
      // شريط سفلي مخصص بـ 6 أزرار عادية + زر مركزي
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          color: isDark ? AppTheme.darkSurface : AppTheme.lightSurface,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, -2))],
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // الأزرار اليسرى
            _buildNavItem(Icons.person_outline, 'حسابي', 5),
            _buildNavItem(Icons.chat_bubble_outline, 'الدردشة', 4),
            _buildNavItem(Icons.account_balance_wallet_outlined, 'المحفظة', 3),
            
            // الزر المركزي (+)
            _buildCenterButton(),
            
            // الأزرار اليمنى
            _buildNavItem(Icons.map_outlined, 'الخريطة', 2),
            _buildNavItem(Icons.storefront_outlined, 'المتجر', 1),
            _buildNavItem(Icons.home_outlined, 'الرئيسية', 0),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _currentIndex == index;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: isSelected ? AppTheme.goldColor : (isDark ? Colors.grey[400] : Colors.grey[600])),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? AppTheme.goldColor : (isDark ? Colors.grey[400] : Colors.grey[600]),
              fontSize: 11,
              fontFamily: 'Changa',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCenterButton() {
    return GestureDetector(
      onTap: _onCenterButtonPressed,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppTheme.goldColor, AppTheme.goldLight],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: AppTheme.goldColor.withOpacity(0.4), blurRadius: 10)],
        ),
        child: const Icon(Icons.add, color: Colors.black, size: 30),
      ),
    );
  }
}
