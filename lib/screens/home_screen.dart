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
  // تم إزالة CarouselController نهائياً

  final List<Map<String, dynamic>> _slides = const [
    {'title': 'إعلانات حصرية للتجار', 'subtitle': 'احصل على أفضل العروض التجارية', 'color': Colors.purple, 'icon': Icons.business},
    {'title': 'VIP عروض', 'subtitle': 'عروض خاصة للأعضاء المميزين', 'color': Colors.amber, 'icon': Icons.star},
    {'title': 'عروض أفضل المطاعم', 'subtitle': 'اكتشف أشهى المأكولات', 'color': Colors.red, 'icon': Icons.restaurant},
    {'title': 'مزادات السيارات والعقارات', 'subtitle': 'الجنابي والأشياء الثمينة', 'color': Colors.blue, 'icon': Icons.directions_car},
    {'title': 'إعلانات المنصة', 'subtitle': 'تابع آخر أخبار وإعلاناتنا', 'color': Colors.green, 'icon': Icons.campaign},
  ];

  final List<Map<String, dynamic>> _moreItems = const [
    {'name': 'معلمات', 'icon': Icons.settings_input_component},
    {'name': 'عقارات', 'icon': Icons.home},
    {'name': 'سفر', 'icon': Icons.flight},
    {'name': 'شحن', 'icon': Icons.local_shipping},
    {'name': 'ألعاب', 'icon': Icons.sports_esports},
  ];

  final List<Map<String, dynamic>> _properties = const [
    {'name': 'شقق الإيجار', 'icon': Icons.apartment},
    {'name': 'فلل البيع', 'icon': Icons.villa},
    {'name': 'أراضي استثمارية', 'icon': Icons.landscape},
    {'name': 'مكافآت تجارية', 'icon': Icons.business_center},
    {'name': 'محطات سكنية', 'icon': Icons.house},
    {'name': 'مقاولات بناء', 'icon': Icons.construction},
    {'name': 'ديكور وتصميم', 'icon': Icons.design_services},
  ];

  final List<Map<String, dynamic>> _electronics = const [
    {'name': 'هواتف ذكية', 'icon': Icons.phone_android},
    {'name': 'لابتوب وكمبيوتر', 'icon': Icons.laptop},
    {'name': 'ستارلينك وإنترنت', 'icon': Icons.satellite_alt},
    {'name': 'كاميرات', 'icon': Icons.camera_alt},
  ];

  final List<Map<String, dynamic>> _cars = const [
    {
      'title': 'جندية صيفاني قديمة',
      'price': '5,000',
      'time': '00:02:34',
      'image': 'https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?w=400',
    },
    {
      'title': 'شاص 2024',
      'price': '35,000',
      'time': '00:12:33',
      'image': 'https://images.unsplash.com/photo-1552519507-da3b142c6e3d?w=400',
    },
    {
      'title': 'تويوتا هايلوكس',
      'price': '8,000',
      'time': '07:03:36',
      'image': 'https://images.unsplash.com/photo-1580273916550-e323be2ae537?w=400',
    },
    {
      'title': 'مرسيدس بنز',
      'price': '75,000',
      'time': '07:03:39',
      'image': 'https://images.unsplash.com/photo-1618843479313-40f8afb4b4d8?w=400',
    },
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
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 8),
                CarouselSlider.builder(
                  // تمت إزالة carouselController
                  itemCount: _slides.length,
                  options: CarouselOptions(
                    height: 150,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 4),
                    viewportFraction: 0.9,
                    onPageChanged: (index, reason) => setState(() => _currentSlide = index),
                  ),
                  itemBuilder: (context, index, _) {
                    final slide = _slides[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          colors: [slide['color'], slide['color'].withOpacity(0.7)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            right: -10,
                            bottom: -10,
                            child: Icon(slide['icon'], size: 80, color: Colors.white.withOpacity(0.2)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(slide['title'], style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold), textAlign: TextAlign.right),
                                const SizedBox(height: 4),
                                Text(slide['subtitle'], style: const TextStyle(color: Colors.white70, fontSize: 12), textAlign: TextAlign.right),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_slides.length, (i) => Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentSlide == i ? AppTheme.goldColor : (isDark ? Colors.grey[700] : Colors.grey[300]),
                    ),
                  )),
                ),
              ],
            ),
          ),
          // باقي الأقسام كما هي (يمكن نسخها من الكود السابق)
          const SliverToBoxAdapter(child: SizedBox(height: 80)),
        ],
      ),
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          color: isDark ? AppTheme.darkSurface : AppTheme.lightSurface,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, -2))],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.person_outline, 'حسابي'),
            _buildNavItem(Icons.shopping_bag_outlined, 'المنتج'),
            _buildNavItem(Icons.map_outlined, 'الخرائط'),
            _buildNavItem(Icons.home, 'الرئيسية', isSelected: true),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, {bool isSelected = false}) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: isSelected ? AppTheme.goldColor : Colors.grey),
          const SizedBox(height: 2),
          Text(label, style: TextStyle(color: isSelected ? AppTheme.goldColor : Colors.grey, fontSize: 11)),
        ],
      ),
    );
  }
}
