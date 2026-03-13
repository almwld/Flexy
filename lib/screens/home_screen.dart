import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../theme/app_theme.dart';
import 'notifications_screen.dart';
import 'search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentSlide = 0;
  final CarouselSliderController _carouselController = CarouselSliderController();

  // بيانات السلايدر
  final List<Map<String, dynamic>> _slides = [
    {
      'title': 'إعلانات حصرية للتجار',
      'subtitle': 'احصل على أفضل العروض التجارية',
      'color': [Colors.purple, Colors.deepPurple],
      'icon': Icons.business,
    },
    {
      'title': 'VIP عروض',
      'subtitle': 'عروض خاصة للأعضاء المميزين',
      'color': [Colors.amber, Colors.orange],
      'icon': Icons.star,
    },
    {
      'title': 'عروض أفضل المطاعم',
      'subtitle': 'اكتشف أشهى المأكولات',
      'color': [Colors.red, Colors.redAccent],
      'icon': Icons.restaurant,
    },
    {
      'title': 'مزادات السيارات والعقارات',
      'subtitle': 'الجنابي والأشياء الثمينة',
      'color': [Colors.blue, Colors.blueAccent],
      'icon': Icons.directions_car,
    },
    {
      'title': 'إعلانات المنصة',
      'subtitle': 'تابع آخر أخبار وإعلاناتنا',
      'color': [Colors.green, Colors.teal],
      'icon': Icons.campaign,
    },
  ];

  // الفئات السريعة
  final List<Map<String, dynamic>> _quickCategories = [
    {'name': 'مطاعم', 'icon': Icons.restaurant},
    {'name': 'عقارات', 'icon': Icons.home},
    {'name': 'سفر', 'icon': Icons.flight},
    {'name': 'ألعاب', 'icon': Icons.sports_esports},
    {'name': 'سيارات', 'icon': Icons.directions_car},
    {'name': 'إلكترونيات', 'icon': Icons.phone_android},
    {'name': 'أثاث', 'icon': Icons.chair},
    {'name': 'ملابس', 'icon': Icons.checkroom},
  ];

  // العقارات
  final List<Map<String, dynamic>> _properties = [
    {'name': 'شقق للإيجار', 'icon': Icons.apartment},
    {'name': 'فلل للبيع', 'icon': Icons.villa},
    {'name': 'أراضي', 'icon': Icons.landscape},
    {'name': 'مكاتب', 'icon': Icons.business},
    {'name': 'مخططات', 'icon': Icons.map},
    {'name': 'مقاولات', 'icon': Icons.construction},
  ];

  // الإلكترونيات
  final List<Map<String, dynamic>> _electronics = [
    {'name': 'هواتف', 'icon': Icons.smartphone},
    {'name': 'لابتوب', 'icon': Icons.laptop},
    {'name': 'ستلايت', 'icon': Icons.satellite_alt},
    {'name': 'كاميرات', 'icon': Icons.camera_alt},
    {'name': 'ألعاب', 'icon': Icons.games},
  ];

  // السيارات
  final List<Map<String, dynamic>> _cars = [
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
          // شريط التطبيق
          SliverAppBar(
            floating: true,
            snap: true,
            title: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'FLEX',
                  style: TextStyle(
                    color: AppTheme.goldColor,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(width: 4),
                Text(
                  'YEMEN',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.goldLight,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const SearchScreen()),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const NotificationsScreen()),
                  );
                },
              ),
            ],
          ),

          // السلايدر المتحرك
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 8),
                CarouselSlider.builder(
                  carouselController: _carouselController,
                  itemCount: _slides.length,
                  options: CarouselOptions(
                    height: 180,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 4),
                    autoPlayAnimationDuration: const Duration(milliseconds: 800),
                    enlargeCenterPage: true,
                    viewportFraction: 0.9,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentSlide = index;
                      });
                    },
                  ),
                  itemBuilder: (context, index, realIndex) {
                    final slide = _slides[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          colors: slide['color'],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Stack(
                        children: [
                          // خلفية زخرفية
                          Positioned(
                            left: -20,
                            top: -20,
                            child: Icon(
                              slide['icon'],
                              size: 150,
                              color: Colors.white.withValues(alpha: 0.1),
                            ),
                          ),
                          // المحتوى
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    'عرض خاص',
                                    style: TextStyle(
                                      color: Colors.white.withValues(alpha: 0.9),
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  slide['title'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  slide['subtitle'],
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.9),
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                // مؤشرات السلايدر
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _slides.asMap().entries.map((entry) {
                    return Container(
                      width: _currentSlide == entry.key ? 24 : 8,
                      height: 8,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: _currentSlide == entry.key
                            ? AppTheme.goldColor
                            : (isDark ? Colors.grey[700] : Colors.grey[300]),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          // الفئات السريعة
          SliverToBoxAdapter(
            child: _buildSectionTitle('الفئات', Icons.category),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 100,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _quickCategories.length,
                itemBuilder: (context, index) {
                  final category = _quickCategories[index];
                  return _buildCategoryItem(
                    category['name'],
                    category['icon'],
                  );
                },
              ),
            ),
          ),

          // العقارات والاستثمارات
          SliverToBoxAdapter(
            child: _buildSectionTitle('العقارات والاستثمارات', Icons.home_work),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 120,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _properties.length,
                itemBuilder: (context, index) {
                  final property = _properties[index];
                  return _buildPropertyItem(property['name'], property['icon']);
                },
              ),
            ),
          ),

          // عالم الإلكترونيات والتقنية
          SliverToBoxAdapter(
            child: _buildSectionTitle('الإلكترونيات والتقنية', Icons.computer),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 100,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _electronics.length,
                itemBuilder: (context, index) {
                  final item = _electronics[index];
                  return _buildTechItem(item['name'], item['icon']);
                },
              ),
            ),
          ),

          // السيارات
          SliverToBoxAdapter(
            child: _buildSectionTitle('السيارات', Icons.directions_car),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final car = _cars[index];
                  return _buildCarCard(car);
                },
                childCount: _cars.length,
              ),
            ),
          ),

          // مسافة للأسفل
          const SliverToBoxAdapter(
            child: SizedBox(height: 100),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.goldColor, size: 24),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {},
            child: const Text('المزيد'),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(String name, IconData icon) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: 80,
      margin: const EdgeInsets.only(left: 12),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDark ? Colors.grey[800]! : Colors.grey[300]!,
              ),
            ),
            child: Icon(icon, color: AppTheme.goldColor, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: isDark ? Colors.white70 : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyItem(String name, IconData icon) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: 100,
      margin: const EdgeInsets.only(left: 12),
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: Colors.blue, size: 32),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: isDark ? Colors.white70 : Colors.black87,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildTechItem(String name, IconData icon) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: 90,
      margin: const EdgeInsets.only(left: 12),
      child: Column(
        children: [
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: Colors.purple, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              color: isDark ? Colors.white70 : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCarCard(Map<String, dynamic> car) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.goldColor.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // صورة السيارة
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    car['image'],
                    fit: BoxFit.cover,
                  ),
                  // مؤقت المزاد
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.timer,
                            color: Colors.white,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            car['time'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // التفاصيل
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    car['title'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.goldColor.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '${car['price']} ر.ي',
                          style: const TextStyle(
                            color: AppTheme.goldColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.favorite_border,
                        color: Colors.grey,
                        size: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
