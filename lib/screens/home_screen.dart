import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentSlide = 0;
  final CarouselSliderController _carouselController = CarouselSliderController();

  final List<Map<String, dynamic>> _slides = [
    {'title': 'إعلانات حصرية للتجار', 'subtitle': 'احصل على أفضل العروض التجارية', 'color': Colors.purple, 'icon': Icons.business},
    {'title': 'VIP عروض', 'subtitle': 'عروض خاصة للأعضاء المميزين', 'color': Colors.amber, 'icon': Icons.star},
    {'title': 'عروض أفضل المطاعم', 'subtitle': 'اكتشف أشهى المأكولات', 'color': Colors.red, 'icon': Icons.restaurant},
    {'title': 'مزادات السيارات والعقارات', 'subtitle': 'الجنابي والأشياء الثمينة', 'color': Colors.blue, 'icon': Icons.directions_car},
    {'title': 'إعلانات المنصة', 'subtitle': 'تابع آخر أخبار وإعلاناتنا', 'color': Colors.green, 'icon': Icons.campaign},
  ];

  final List<Map<String, dynamic>> _moreItems = [
    {'name': 'معلمات', 'icon': Icons.settings_input_component},
    {'name': 'عقارات', 'icon': Icons.home},
    {'name': 'سفر', 'icon': Icons.flight},
    {'name': 'شحن', 'icon': Icons.local_shipping},
    {'name': 'ألعاب', 'icon': Icons.sports_esports},
  ];

  // باقي البيانات (يمكن إضافتها لاحقًا)

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            snap: true,
            title: Row(
              children: [
                const Text('FLEX', style: TextStyle(color: AppTheme.goldColor, fontWeight: FontWeight.bold, letterSpacing: 2)),
                const SizedBox(width: 4),
                const Text('YEMEN', style: TextStyle(fontSize: 14, color: AppTheme.goldLight)),
                const Spacer(),
                IconButton(icon: const Icon(Icons.search), onPressed: () {}),
                IconButton(icon: const Icon(Icons.notifications_outlined), onPressed: () {}),
              ],
            ),
          ),
          // يمكن إضافة باقي المحتوى لاحقًا
          const SliverToBoxAdapter(child: SizedBox(height: 200, child: Center(child: Text('الصفحة الرئيسية قيد التطوير')))),
        ],
      ),
    );
  }
}
