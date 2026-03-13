import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  final List<Map<String, dynamic>> _categories = const [
    {
      'name': 'سيارات',
      'icon': Icons.directions_car,
      'color': Colors.blue,
      'count': '1,234',
      'subcategories': ['سيارات للبيع', 'سيارات للإيجار', 'قطع غيار', 'إكسسوارات'],
    },
    {
      'name': 'عقارات',
      'icon': Icons.home,
      'color': Colors.green,
      'count': '892',
      'subcategories': ['شقق', 'فلل', 'أراضي', 'مكاتب', 'محلات'],
    },
    {
      'name': 'إلكترونيات',
      'icon': Icons.phone_android,
      'color': Colors.purple,
      'count': '3,456',
      'subcategories': ['هواتف', 'لابتوب', 'تابلت', 'كاميرات', 'ألعاب'],
    },
    {
      'name': 'أثاث',
      'icon': Icons.chair,
      'color': Colors.orange,
      'count': '567',
      'subcategories': ['غرف نوم', 'غرف معيشة', 'مطابخ', 'مكاتب'],
    },
    {
      'name': 'ملابس',
      'icon': Icons.checkroom,
      'color': Colors.pink,
      'count': '2,345',
      'subcategories': ['رجالي', 'نسائي', 'أطفال', 'أحذية', 'إكسسوارات'],
    },
    {
      'name': 'مطاعم',
      'icon': Icons.restaurant,
      'color': Colors.red,
      'count': '234',
      'subcategories': ['مطاعم', 'مقاهي', 'حلويات', 'مأكولات بحرية'],
    },
    {
      'name': 'خدمات',
      'icon': Icons.build,
      'color': Colors.teal,
      'count': '456',
      'subcategories': ['صيانة', 'نقل', 'تنظيف', 'تعليم', 'صحة'],
    },
    {
      'name': 'حيوانات',
      'icon': Icons.pets,
      'color': Colors.brown,
      'count': '123',
      'subcategories': ['قطط', 'كلاب', 'طيور', 'أسماك', 'مواشي'],
    },
    {
      'name': 'رياضة',
      'icon': Icons.sports,
      'color': Colors.indigo,
      'count': '345',
      'subcategories': ['أدوات رياضية', 'ملابس رياضية', 'معدات'],
    },
    {
      'name': 'كتب',
      'icon': Icons.book,
      'color': Colors.amber,
      'count': '678',
      'subcategories': ['كتب تعليمية', 'روايات', 'مجلات', 'قرطاسية'],
    },
    {
      'name': 'ألعاب',
      'icon': Icons.toys,
      'color': Colors.cyan,
      'count': '234',
      'subcategories': ['ألعاب أطفال', 'ألعاب إلكترونية', 'هدايا'],
    },
    {
      'name': 'أخرى',
      'icon': Icons.more_horiz,
      'color': Colors.grey,
      'count': '890',
      'subcategories': ['متنوعة'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('الفئات'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.85,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          return _buildCategoryCard(category, index, isDark);
        },
      ),
    );
  }

  Widget _buildCategoryCard(
    Map<String, dynamic> category,
    int index,
    bool isDark,
  ) {
    final color = category['color'] as Color;
    
    return GestureDetector(
      onTap: () {
        _showSubcategories(context, category);
      },
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: color.withOpacity( 0.3),
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity( 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: color.withOpacity( 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                category['icon'] as IconData,
                color: color,
                size: 35,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              category['name'] as String,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${category['count']} إعلان',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    )
      .animate()
      .fadeIn(delay: (index * 50).ms, duration: 400.ms)
      .scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1));
  }

  void _showSubcategories(BuildContext context, Map<String, dynamic> category) {
    final color = category['color'] as Color;
    final subcategories = category['subcategories'] as List<String>;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppTheme.darkSurface
              : AppTheme.lightSurface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          children: [
            // Handle
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[700],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 24),
            
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: color.withOpacity( 0.2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(
                      category['icon'] as IconData,
                      color: color,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category['name'] as String,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${category['count']} إعلان',
                        style: TextStyle(
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Subcategories
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: subcategories.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: color.withOpacity( 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: color,
                        size: 16,
                      ),
                    ),
                    title: Text(subcategories[index]),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      Navigator.of(context).pop();
                      // Navigate to category listings
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
