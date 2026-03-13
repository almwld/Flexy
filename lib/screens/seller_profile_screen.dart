import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import 'ad_detail_screen.dart';
import 'chat_detail_screen.dart';

class SellerProfileScreen extends StatelessWidget {
  final Map<String, dynamic> seller; // بيانات البائع
  const SellerProfileScreen({super.key, required this.seller});

  // بيانات وهمية إذا لم تكن متوفرة
  final Map<String, dynamic> _defaultSeller = const {
    'name': 'أحمد محمد',
    'avatar': 'أ',
    'rating': 4.8,
    'reviews': 124,
    'joined': 'يناير 2024',
    'phone': '777123456',
    'verified': true,
    'adsCount': 15,
    'followers': 342,
    'following': 56,
  };

  final List<Map<String, dynamic>> _sellerAds = List.generate(6, (index) {
    return {
      'id': 'ad_$index',
      'title': index % 2 == 0 ? 'سيارة تويوتا' : 'شقة للإيجار',
      'price': '${5000 + index * 1000}',
      'image': 'https://images.unsplash.com/photo-${1500000000 + index}?w=200',
    };
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final sellerData = seller.isNotEmpty ? seller : _defaultSeller;

    return Scaffold(
      appBar: AppBar(
        title: Text('ملف البائع: ${sellerData['name']}'),
        actions: [
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // معلومات البائع
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: AppTheme.goldColor.withOpacity(0.2),
                    child: Text(
                      sellerData['avatar'] ?? sellerData['name'][0],
                      style: const TextStyle(
                        fontSize: 30,
                        color: AppTheme.goldColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              sellerData['name'],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (sellerData['verified'])
                              const Padding(
                                padding: EdgeInsets.only(right: 8),
                                child: Icon(
                                  Icons.verified,
                                  color: Colors.blue,
                                  size: 18,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              '${sellerData['rating']} (${sellerData['reviews']} تقييم)',
                              style: TextStyle(color: Colors.grey[500]),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(
                              'عضو منذ ${sellerData['joined']}',
                              style: TextStyle(color: Colors.grey[500], fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn().scale(),

            const SizedBox(height: 16),

            // الإحصائيات
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatColumn('الإعلانات', sellerData['adsCount'].toString()),
                  Container(width: 1, height: 40, color: Colors.grey[700]),
                  _buildStatColumn('المتابعون', sellerData['followers'].toString()),
                  Container(width: 1, height: 40, color: Colors.grey[700]),
                  _buildStatColumn('يتابع', sellerData['following'].toString()),
                ],
              ),
            ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.2, end: 0),

            const SizedBox(height: 16),

            // أزرار التواصل
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ChatDetailScreen(
                            name: sellerData['name'],
                            avatar: sellerData['avatar'] ?? sellerData['name'][0],
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.chat, color: Colors.black),
                    label: const Text('محادثة'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.goldColor,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.person_add),
                    label: const Text('متابعة'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppTheme.goldColor,
                      side: const BorderSide(color: AppTheme.goldColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ).animate().fadeIn(delay: 200.ms),

            const SizedBox(height: 24),

            // إعلانات البائع
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'إعلانات البائع',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: null,
                  child: Text('عرض الكل'),
                ),
              ],
            ),
            const SizedBox(height: 8),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: _sellerAds.length > 4 ? 4 : _sellerAds.length,
              itemBuilder: (context, index) {
                final ad = _sellerAds[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => AdDetailScreen(ad: ad)),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                            child: Image.network(
                              ad['image'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ad['title'],
                                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  '${ad['price']} ر.ي',
                                  style: const TextStyle(
                                    color: AppTheme.goldColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatColumn(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(color: Colors.grey[500], fontSize: 12),
        ),
      ],
    );
  }
}
