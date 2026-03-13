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
  // قوائم العروض
  final List<Map<String, dynamic>> _flashOffers = [
    {
      'id': 'offer1',
      'title': 'خصم 50% على الإلكترونيات',
      'subtitle': 'لفترة محدودة',
      'image': 'https://images.unsplash.com/photo-1498049794561-7780e7231661?w=400',
      'discount': '50%',
      'endTime': '02:30:45',
      'backgroundColor': Colors.purple,
    },
    {
      'id': 'offer2',
      'title': 'توصيل مجاني للطلبات فوق 50,000',
      'subtitle': 'لجميع المدن',
      'image': 'https://images.unsplash.com/photo-1580674285054-bed31e145f4d?w=400',
      'discount': 'مجاني',
      'endTime': '05:15:20',
      'backgroundColor': Colors.blue,
    },
    {
      'id': 'offer3',
      'title': 'عرض خاص: اثاث بخصم 30%',
      'subtitle': 'من أشهر الماركات',
      'image': 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=400',
      'discount': '30%',
      'endTime': '12:00:00',
      'backgroundColor': Colors.orange,
    },
  ];

  final List<Map<String, dynamic>> _featuredOffers = List.generate(8, (index) {
    return {
      'id': 'featured_$index',
      'title': 'عرض ${index + 1} - ${['سيارات', 'عقارات', 'إلكترونيات', 'أثاث', 'ملابس'][index % 5]}',
      'price': (10000 + index * 5000).toString(),
      'oldPrice': (15000 + index * 6000).toString(),
      'discount': '${20 + index * 5}%',
      'location': ['صنعاء', 'عدن', 'تعز'][index % 3],
      'image': 'https://images.unsplash.com/photo-${1500000000 + index}?w=400',
      'rating': (4 + (index % 5) / 10).toStringAsFixed(1),
    };
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('العروض'),
        actions: [
          IconButton(
            icon: const Icon(Icons.local_offer),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // عروض فلاش (Flash Offers)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'عروض فلاش 🔥',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('عرض الكل'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _flashOffers.length,
                itemBuilder: (context, index) {
                  final offer = _flashOffers[index];
                  return Container(
                    width: 280,
                    margin: const EdgeInsets.only(left: 12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          offer['backgroundColor'],
                          offer['backgroundColor'].withOpacity(0.7),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          right: -20,
                          bottom: -20,
                          child: Icon(
                            Icons.local_offer,
                            size: 120,
                            color: Colors.white.withOpacity(0.2),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        offer['discount'],
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      offer['title'],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      offer['subtitle'],
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),
                              // مؤقت العد التنازلي
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.timer, color: Colors.white),
                                  const SizedBox(height: 4),
                                  Text(
                                    offer['endTime'],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(delay: (index * 100).ms).slideX(begin: 0.2);
                },
              ),
            ),
            const SizedBox(height: 24),

            // العروض المميزة
            const Text(
              'عروض مميزة',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: _featuredOffers.length,
              itemBuilder: (context, index) {
                final offer = _featuredOffers[index];
                return _buildOfferCard(offer, index, isDark);
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildOfferCard(Map<String, dynamic> offer, int index, bool isDark) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => AdDetailScreen(ad: offer),
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
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // الصورة
                Expanded(
                  flex: 3,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.network(
                      offer['image'],
                      fit: BoxFit.cover,
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
                          offer['title'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Spacer(),
                        // السعر مع الخصم
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${offer['price']} ر.ي',
                                    style: const TextStyle(
                                      color: AppTheme.goldColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    '${offer['oldPrice']} ر.ي',
                                    style: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: 10,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                offer['discount'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.location_on, size: 10, color: Colors.grey[500]),
                            const SizedBox(width: 2),
                            Expanded(
                              child: Text(
                                offer['location'],
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 8,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 10),
                            const SizedBox(width: 2),
                            Text(
                              offer['rating'],
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 8,
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
          ],
        ),
      ),
    ).animate().fadeIn(delay: (index * 50).ms);
  }
}
