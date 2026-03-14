import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import 'ad_detail_screen.dart';

class AllAdsScreen extends StatefulWidget {
  const AllAdsScreen({super.key});

  @override
  State<AllAdsScreen> createState() => _AllAdsScreenState();
}

class _AllAdsScreenState extends State<AllAdsScreen> {
  // خيارات الفلتر
  String _selectedCategory = 'الكل';
  String _selectedCity = 'الكل';
  String _sortBy = 'الأحدث';
  RangeValues _priceRange = const RangeValues(0, 1000000);

  // قوائم الفلاتر
  final List<String> _categories = [
    'الكل', 'سيارات', 'عقارات', 'إلكترونيات', 'أثاث', 'ملابس', 'مطاعم', 'خدمات', 'أخرى'
  ];

  final List<String> _cities = [
    'الكل', 'صنعاء', 'عدن', 'تعز', 'الحديدة', 'المكلا', 'إب', 'سيئون', 'ذمار'
  ];

  final List<String> _sortOptions = ['الأحدث', 'الأقل سعراً', 'الأعلى سعراً', 'الأعلى تقييماً'];

  // بيانات وهمية للإعلانات - تم إزالة const
  final List<Map<String, dynamic>> _allAds = List.generate(20, (index) {
    return {
      'id': 'ad_$index',
      'title': 'إعلان ${index + 1} - ${['سيارة', 'شقة', 'هاتف', 'لابتوب', 'أثاث'][index % 5]}',
      'price': (5000 + index * 1000).toString(),
      'location': _cities[(index % 8) + 1],
      'category': _categories[(index % 7) + 1],
      'image': 'https://images.unsplash.com/photo-${1500000000 + index}?w=400',
      'timeAgo': 'منذ ${index + 1} ساعة',
      'rating': (4 + (index % 5) / 10).toStringAsFixed(1),
    };
  });

  // الإعلانات المفلترة
  List<Map<String, dynamic>> get _filteredAds {
    return _allAds.where((ad) {
      // فلتر الفئة
      if (_selectedCategory != 'الكل' && ad['category'] != _selectedCategory) {
        return false;
      }
      // فلتر المدينة
      if (_selectedCity != 'الكل' && ad['location'] != _selectedCity) {
        return false;
      }
      // فلتر السعر
      double price = double.parse(ad['price'].replaceAll(',', ''));
      if (price < _priceRange.start || price > _priceRange.end) {
        return false;
      }
      return true;
    }).toList()..sort((a, b) {
      // ترتيب
      double priceA = double.parse(a['price'].replaceAll(',', ''));
      double priceB = double.parse(b['price'].replaceAll(',', ''));
      double ratingA = double.parse(a['rating']);
      double ratingB = double.parse(b['rating']);

      switch (_sortBy) {
        case 'الأقل سعراً':
          return priceA.compareTo(priceB);
        case 'الأعلى سعراً':
          return priceB.compareTo(priceA);
        case 'الأعلى تقييماً':
          return ratingB.compareTo(ratingA);
        default: // الأحدث
          return b['id'].compareTo(a['id']);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('جميع الإعلانات'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // فتح شاشة البحث
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterBottomSheet,
          ),
        ],
      ),
      body: Column(
        children: [
          // شريط الفلاتر السريعة
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = _selectedCategory == category;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: FilterChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = selected ? category : 'الكل';
                      });
                    },
                    selectedColor: AppTheme.goldColor,
                    checkmarkColor: Colors.black,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),

          // شريط الفرز
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('الترتيب:'),
                DropdownButton<String>(
                  value: _sortBy,
                  items: _sortOptions.map((option) {
                    return DropdownMenuItem(
                      value: option,
                      child: Text(option),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _sortBy = value!;
                    });
                  },
                  underline: const SizedBox(),
                  icon: const Icon(Icons.arrow_drop_down),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // عدد النتائج
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'تم العثور على ${_filteredAds.length} إعلان',
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 14,
              ),
            ),
          ),

          const SizedBox(height: 8),

          // قائمة الإعلانات
          Expanded(
            child: _filteredAds.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.inbox,
                          size: 80,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'لا توجد إعلانات',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'جرب تغيير معايير البحث',
                          style: TextStyle(color: Colors.grey[500]),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: _filteredAds.length,
                    itemBuilder: (context, index) {
                      final ad = _filteredAds[index];
                      return _buildAdCard(ad, index, isDark);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdCard(Map<String, dynamic> ad, int index, bool isDark) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => AdDetailScreen(ad: ad),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppTheme.goldColor.withOpacity(0.3),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // الصورة
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      ad['image'],
                      fit: BoxFit.cover,
                    ),
                    // تقييم سريع
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 12),
                            const SizedBox(width: 2),
                            Text(
                              ad['rating'],
                              style: const TextStyle(color: Colors.white, fontSize: 10),
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
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ad['title'],
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
                        Expanded(
                          child: Text(
                            '${ad['price']} ر.ي',
                            style: const TextStyle(
                              color: AppTheme.goldColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.location_on, size: 12, color: Colors.grey[500]),
                            const SizedBox(width: 2),
                            Text(
                              ad['location'],
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 9,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.access_time, size: 12, color: Colors.grey[500]),
                        const SizedBox(width: 2),
                        Text(
                          ad['timeAgo'],
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 9,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: (index * 50).ms).scale(begin: const Offset(0.9, 0.9));
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppTheme.darkSurface
              : AppTheme.lightSurface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: StatefulBuilder(
          builder: (context, setState) {
            return Column(
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
                const SizedBox(height: 16),

                // العنوان
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    'فلترة الإعلانات',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // الفئة
                        const Text(
                          'الفئة',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: _categories.map((category) {
                            final isSelected = _selectedCategory == category;
                            return ChoiceChip(
                              label: Text(category),
                              selected: isSelected,
                              onSelected: (selected) {
                                this.setState(() {
                                  _selectedCategory = selected ? category : 'الكل';
                                });
                              },
                              selectedColor: AppTheme.goldColor,
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 24),

                        // المدينة
                        const Text(
                          'المدينة',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: _cities.map((city) {
                            final isSelected = _selectedCity == city;
                            return ChoiceChip(
                              label: Text(city),
                              selected: isSelected,
                              onSelected: (selected) {
                                this.setState(() {
                                  _selectedCity = selected ? city : 'الكل';
                                });
                              },
                              selectedColor: AppTheme.goldColor,
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 24),

                        // نطاق السعر
                        const Text(
                          'نطاق السعر',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        RangeSlider(
                          values: _priceRange,
                          min: 0,
                          max: 1000000,
                          divisions: 100,
                          labels: RangeLabels(
                            '${_priceRange.start.round()} ر.ي',
                            '${_priceRange.end.round()} ر.ي',
                          ),
                          onChanged: (values) {
                            this.setState(() {
                              _priceRange = values;
                            });
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${_priceRange.start.round()} ر.ي'),
                            Text('${_priceRange.end.round()} ر.ي'),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // الفرز
                        const Text(
                          'الترتيب',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        ..._sortOptions.map((option) {
                          return RadioListTile<String>(
                            title: Text(option),
                            value: option,
                            groupValue: _sortBy,
                            onChanged: (value) {
                              this.setState(() {
                                _sortBy = value!;
                              });
                            },
                            activeColor: AppTheme.goldColor,
                          );
                        }),
                      ],
                    ),
                  ),
                ),

                // أزرار التطبيق والإغلاق
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            setState(() {
                              _selectedCategory = 'الكل';
                              _selectedCity = 'الكل';
                              _priceRange = const RangeValues(0, 1000000);
                              _sortBy = 'الأحدث';
                            });
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red,
                            side: const BorderSide(color: Colors.red),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('إعادة تعيين'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // تطبيق الفلاتر
                            setState(() {});
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.goldColor,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('تطبيق'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
