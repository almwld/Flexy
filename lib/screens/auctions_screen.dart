import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import 'ad_detail_screen.dart';

class AuctionsScreen extends StatefulWidget {
  const AuctionsScreen({super.key});

  @override
  State<AuctionsScreen> createState() => _AuctionsScreenState();
}

class _AuctionsScreenState extends State<AuctionsScreen> {
  // فئات المزادات
  final List<Map<String, dynamic>> _categories = [
    {'name': 'الكل', 'icon': Icons.all_inclusive, 'color': Colors.grey},
    {'name': 'سيارات', 'icon': Icons.directions_car, 'color': Colors.blue},
    {'name': 'عقارات', 'icon': Icons.home, 'color': Colors.green},
    {'name': 'جنابي', 'icon': Icons.agriculture, 'color': Colors.amber},
    {'name': 'إلكترونيات', 'icon': Icons.phone_android, 'color': Colors.purple},
    {'name': 'عملات', 'icon': Icons.monetization_on, 'color': Colors.orange},
  ];

  String _selectedCategory = 'الكل';
  String _sortBy = 'الأقرب انتهاء';

  // بيانات وهمية للمزادات
  final List<Map<String, dynamic>> _auctions = List.generate(12, (index) {
    int hoursLeft = [2, 5, 10, 24, 48, 72][index % 6];
    int minutesLeft = [0, 15, 30, 45][index % 4];
    int bidsCount = 5 + index * 2;
    double currentBid = 5000 + index * 1500;
    return {
      'id': 'auction_$index',
      'title': index % 2 == 0 ? 'مزاد سيارة فاخرة' : 'مزاد قطعة أثرية',
      'description': 'وصف مختصر للمزاد',
      'category': ['سيارات', 'عقارات', 'جنابي', 'إلكترونيات', 'عملات'][index % 5],
      'image': 'https://images.unsplash.com/photo-${1500000000 + index}?w=400',
      'currentBid': currentBid,
      'bidsCount': bidsCount,
      'timeLeft': '${hoursLeft}h ${minutesLeft}m',
      'endingSoon': hoursLeft < 3,
    };
  });

  List<Map<String, dynamic>> get _filteredAuctions {
    List<Map<String, dynamic>> filtered = _selectedCategory == 'الكل'
        ? List.from(_auctions)
        : _auctions.where((a) => a['category'] == _selectedCategory).toList();
    
    switch (_sortBy) {
      case 'الأعلى سعراً':
        filtered.sort((a, b) => b['currentBid'].compareTo(a['currentBid']));
        break;
      case 'الأقل سعراً':
        filtered.sort((a, b) => a['currentBid'].compareTo(b['currentBid']));
        break;
      case 'الأكثر مشاركة':
        filtered.sort((a, b) => b['bidsCount'].compareTo(a['bidsCount']));
        break;
      default: // الأقرب انتهاء
        filtered.sort((a, b) => a['timeLeft'].compareTo(b['timeLeft']));
    }
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('المزادات'),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.sort),
            onSelected: (value) => setState(() => _sortBy = value),
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'الأقرب انتهاء', child: Text('الأقرب انتهاء')),
              const PopupMenuItem(value: 'الأعلى سعراً', child: Text('الأعلى سعراً')),
              const PopupMenuItem(value: 'الأقل سعراً', child: Text('الأقل سعراً')),
              const PopupMenuItem(value: 'الأكثر مشاركة', child: Text('الأكثر مشاركة')),
            ],
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
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final cat = _categories[index];
                final isSelected = _selectedCategory == cat['name'];
                return GestureDetector(
                  onTap: () => setState(() => _selectedCategory = cat['name']),
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? AppTheme.goldColor : (isDark ? AppTheme.darkCard : AppTheme.lightCard),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: isSelected ? AppTheme.goldColor : (cat['color'] as Color).withOpacity(0.5),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(cat['icon'], size: 18, color: isSelected ? Colors.black : cat['color']),
                        const SizedBox(width: 4),
                        Text(
                          cat['name'],
                          style: TextStyle(
                            color: isSelected ? Colors.black : null,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // قائمة المزادات
          Expanded(
            child: _filteredAuctions.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.gavel, size: 80, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        const Text('لا توجد مزادات', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredAuctions.length,
                    itemBuilder: (context, index) {
                      final auction = _filteredAuctions[index];
                      return _buildAuctionCard(auction, index, isDark);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildAuctionCard(Map<String, dynamic> auction, int index, bool isDark) {
    return GestureDetector(
      onTap: () {
        // TODO: فتح صفحة تفاصيل المزاد
        // Navigator.of(context).push(MaterialPageRoute(builder: (_) => AuctionDetailScreen(auction: auction)));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: auction['endingSoon'] ? Colors.red : AppTheme.goldColor.withOpacity(0.3),
            width: auction['endingSoon'] ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            // صورة المزاد
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Stack(
                children: [
                  Image.network(
                    auction['image'],
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  // شارة "ينتهي قريباً"
                  if (auction['endingSoon'])
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.timer, color: Colors.white, size: 16),
                            SizedBox(width: 4),
                            Text('ينتهي قريباً', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // تفاصيل المزاد
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          auction['title'],
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          auction['category'],
                          style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.timer, size: 16, color: Colors.red),
                      const SizedBox(width: 4),
                      Text(
                        'ينتهي في: ${auction['timeLeft']}',
                        style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 16),
                      const Icon(Icons.gavel, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text('${auction['bidsCount']} عرض'),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('السعر الحالي', style: TextStyle(color: Colors.grey)),
                          Text(
                            '${auction['currentBid'].toStringAsFixed(0)} ر.ي',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.goldColor,
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.goldColor,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('مزايدة'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: (index * 50).ms).slideY(begin: 0.2, end: 0);
  }
}
