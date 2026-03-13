import '../theme/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../theme/theme_manager.dart';
import 'login_screen.dart';
import 'my_ads_screen.dart';
import 'favorites_screen.dart';
import 'settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  final bool isGuest;
  
  const ProfileScreen({super.key, this.isGuest = false});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final List<Map<String, dynamic>> _menuItems = [
    {'title': 'إعلاناتي', 'icon': Icons.campaign, 'color': Colors.blue, 'screen': const MyAdsScreen()},
    {'title': 'المفضلة', 'icon': Icons.favorite, 'color': Colors.red, 'screen': const FavoritesScreen()},
    {'title': 'الإعدادات', 'icon': Icons.settings, 'color': Colors.purple, 'screen': const SettingsScreen()},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeManager = Provider.of<ThemeManager>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('حسابي'),
        actions: [
          IconButton(
            icon: Icon(widget.isGuest ? Icons.login : Icons.logout),
            onPressed: () {
              if (widget.isGuest) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              } else {
                // تسجيل خروج المستخدم المسجل
              }
            },
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // معلومات المستخدم
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppTheme.goldColor, AppTheme.goldLight],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.person, size: 40, color: Colors.black),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.isGuest ? 'ضيف' : 'أحمد محمد',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.isGuest 
                              ? 'سجل دخول للاستفادة من جميع الميزات'
                              : 'ahmed@example.com',
                          style: TextStyle(
                            color: isDark ? Colors.grey[400] : Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // قائمة الخيارات (نفسها للضيف والمستخدم)
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final item = _menuItems[index];
                return ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: item['color'].withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(item['icon'], color: item['color']),
                  ),
                  title: Text(item['title']),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => item['screen']),
                    );
                  },
                );
              },
              childCount: _menuItems.length,
            ),
          ),
        ],
      ),
    );
  }
}
