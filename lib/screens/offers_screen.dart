import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import 'ad_detail_screen.dart';

class OffersScreen extends StatefulWidget {
  const OffersScreen({super.key});

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  // أنواع العروض
  final List<Map<String, dynamic>> _offerCategories = [
    {'name': 'خصومات', 'icon': Icons.local_offer, 'color': Colors.red},
    {'name': 'صفقات اليوم', 'icon': Icons.today, 'color': Colors.orange},
    {'name': 'وصل حديثاً', 'icon': Icons.fiber_new, 'color': Colors.green},
    {'name': 'الأكثر مبيعاً', 'icon': Icons.trending_up, 'color': Colors.blue},
    {'name': 'محدودة الوقت', 'icon': Icons.timer, 'color': Colors.purple},
  ];

  // بيانات العروض الوهمية
  final List<Map<String, dynamic>> _offers = List.generate(15, (index) {
    double discount = [10, 15, 20, 25, 30, 40, 50][index % 7];
    double originalPrice = (5000 + index * 2000).toDouble();
    double discountedPrice = originalPrice * (1 - discount / 100);
    return {
      'id': 'offer_$index',
      'title': 'عرض ${index + 1} - ${index % 2 == 0 ? 'منتج' : 'خدمة'} مميزة',
      'description': 'وصف مختصر للعرض الرائع الذي لا يفوت',
      'originalPrice': originalPrice,
      'discountedPrice': discountedPrice,
      'discount': discount,
      'category': _offerCategories[index % 5]['name'],
      'image': 'https://images.unsplash.com/photo-${1500000000 + index}?w=400',
      'timeLeft': '${23 - index % 24}:${59 - index % 60}',
      'soldCount': 50 + index * 10,
    };
  });

  String _selectedCategory = 'الكل';

  List<Map<String, dynamic>> get _filteredOffers {
    if (_selectedCategory == 'الكل') return _offers;
    return _offers.where((o) => o['category'] == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('العروض والتخفيضات'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // شريط الفئات
          Container(
            height: 70,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _offerCategories.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return _buildCategoryChip('الكل', Icons.all_inclusive, Colors.grey, index == 0);
                }
                final cat = _offerCategories[index - 1];
                return _buildCategoryChip(cat['name'], cat['icon'], cat['color'], _selectedCategory == cat['name']);
              },
            ),
          ),
          // شريط العد التنازلي الرئيسي (اختياري)
          if (_selectedCategory == 'الكل' || _selectedCategory == 'محدودة الوقت')
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.red, Colors.orange],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Icon(Icons.timer, color: Colors.white, size: 30),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'عروض محدودة الوقت تنتهي قريباً',
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      '23:59',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 8),

          // قائمة العروض
          Expanded(
            child: _filteredOffers.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.local_offer_outlined, size: 80, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        const Text('لا توجد عروض', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredOffers.length,
                    itemBuilder: (context, index) {
                      final offer = _filteredOffers[index];
                      return _buildOfferCard(offer, index, isDark);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String label, IconData icon, Color color, bool isSelected) {
    return GestureDetector(
      onTap: () => setState(() => _selectedCategory = label),
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.goldColor : (Theme.of(context).brightness == Brightness.dark ? AppTheme.darkCard : AppTheme.lightCard),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelected ? AppTheme.goldColor : Colors.grey[400]!,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: isSelected ? Colors.black : color),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.black : null,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOfferCard(Map<String, dynamic> offer, int index, bool isDark) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => AdDetailScreen(ad: offer)),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.red.withOpacity(0.3),
          ),
        ),
        child: Stack(
          children: [
            // شارة الخصم
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: Text(
                  '${offer['discount']}% خصم',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            // المحتوى
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // الصورة
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      offer['image'],
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  // التفاصيل
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          offer['title'],
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          offer['description'],
                          style: TextStyle(fontSize: 13, color: Colors.grey[500]),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        // السعر
                        Row(
                          children: [
                            Text(
                              '${offer['discountedPrice'].toStringAsFixed(0)} ر.ي',
                              style: const TextStyle(
                                color: AppTheme.goldColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${offer['originalPrice'].toStringAsFixed(0)} ر.ي',
                              style: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // الوقت والمبيعات
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.orange.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.timer, size: 14, color: Colors.orange),
                                  const SizedBox(width: 4),
                                  Text(
                                    offer['timeLeft'],
                                    style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${offer['soldCount']} مباع',
                              style: TextStyle(color: Colors.grey[500]),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: (index * 50).ms).slideX(begin: 0.2, end: 0);
  }
}
