import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../theme/app_theme.dart';

class AdDetailScreen extends StatefulWidget {
  final Map<String, dynamic> ad; // سيتم تمرير بيانات الإعلان
  const AdDetailScreen({super.key, required this.ad});

  @override
  State<AdDetailScreen> createState() => _AdDetailScreenState();
}

class _AdDetailScreenState extends State<AdDetailScreen> {
  int _currentImageIndex = 0;
  bool _isFavorite = false;

  // بيانات وهمية للإعلان (في حالة عدم تمرير بيانات كافية)
  final List<String> _sampleImages = [
    'https://images.unsplash.com/photo-1621007947382-bb3c3968e3bb?w=400',
    'https://images.unsplash.com/photo-1552519507-da3b142c6e3d?w=400',
    'https://images.unsplash.com/photo-1580273916550-e323be2ae537?w=400',
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final ad = widget.ad;
    final images = ad['images'] ?? _sampleImages;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar مع صورة الخلفية
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            stretch: true,
            backgroundColor: isDark ? AppTheme.darkSurface : AppTheme.lightSurface,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // كاروسيل الصور
                  CarouselSlider.builder(
                    itemCount: images.length,
                    options: CarouselOptions(
                      height: 300,
                      viewportFraction: 1.0,
                      enableInfiniteScroll: images.length > 1,
                      onPageChanged: (index, _) => setState(() => _currentImageIndex = index),
                    ),
                    itemBuilder: (context, index, _) {
                      return Image.network(
                        images[index],
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                  // التدرج الشفاف
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                        ),
                      ),
                    ),
                  ),
                  // أزرار التنقل بين الصور
                  Positioned(
                    bottom: 16,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(images.length, (i) {
                        return Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentImageIndex == i
                                ? AppTheme.goldColor
                                : Colors.white.withOpacity(0.5),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(_isFavorite ? Icons.favorite : Icons.favorite_border),
                onPressed: () => setState(() => _isFavorite = !_isFavorite),
                color: _isFavorite ? Colors.red : Colors.white,
              ),
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {},
                color: Colors.white,
              ),
            ],
          ),

          // محتوى الإعلان
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // العنوان والسعر
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          ad['title'] ?? 'عنوان الإعلان',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppTheme.goldColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '${ad['price'] ?? '0'} ر.ي',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.goldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // الموقع والوقت
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 16, color: Colors.grey[500]),
                      const SizedBox(width: 4),
                      Text(
                        ad['location'] ?? 'صنعاء، اليمن',
                        style: TextStyle(color: Colors.grey[500], fontSize: 14),
                      ),
                      const SizedBox(width: 16),
                      Icon(Icons.access_time, size: 16, color: Colors.grey[500]),
                      const SizedBox(width: 4),
                      Text(
                        ad['timeAgo'] ?? 'منذ ساعة',
                        style: TextStyle(color: Colors.grey[500], fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // معلومات البائع
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: AppTheme.goldColor.withOpacity(0.2),
                          backgroundImage: ad['sellerAvatar'] != null
                              ? NetworkImage(ad['sellerAvatar'])
                              : null,
                          child: ad['sellerAvatar'] == null
                              ? Text(
                                  ad['sellerName']?[0] ?? 'أ',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    color: AppTheme.goldColor,
                                  ),
                                )
                              : null,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ad['sellerName'] ?? 'أحمد محمد',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.star, color: Colors.amber, size: 16),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${ad['sellerRating'] ?? '4.8'} (${ad['sellerReviews'] ?? '120'} تقييم)',
                                    style: TextStyle(color: Colors.grey[500], fontSize: 14),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(
                                    child: OutlinedButton.icon(
                                      onPressed: () {},
                                      icon: const Icon(Icons.chat, size: 18),
                                      label: const Text('محادثة'),
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: AppTheme.goldColor,
                                        side: const BorderSide(color: AppTheme.goldColor),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: ElevatedButton.icon(
                                      onPressed: () {},
                                      icon: const Icon(Icons.phone, size: 18),
                                      label: const Text('اتصال'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppTheme.goldColor,
                                        foregroundColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // الوصف
                  const Text(
                    'الوصف',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    ad['description'] ??
                        'وصف الإعلان التفصيلي هنا. يمكن أن يكون نصاً طويلاً يشرح كل شيء عن المنتج أو الخدمة المعروضة.',
                    style: const TextStyle(fontSize: 14, height: 1.5),
                  ),
                  const SizedBox(height: 24),

                  // التقييمات
                  const Text(
                    'التقييمات',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (context, i) {
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey[300],
                          child: const Icon(Icons.person, size: 20),
                        ),
                        title: Row(
                          children: [
                            Text('مستخدم $i'),
                            const Spacer(),
                            Row(
                              children: List.generate(5, (j) {
                                return Icon(
                                  j < 4 ? Icons.star : Icons.star_border,
                                  color: Colors.amber,
                                  size: 16,
                                );
                              }),
                            ),
                          ],
                        ),
                        subtitle: Text(
                          'تقييم رائع! المنتج ممتاز والتواصل سلس.',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: TextButton(
                      onPressed: () {},
                      child: const Text('عرض جميع التقييمات'),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // زر الإبلاغ
                  Center(
                    child: TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.flag, color: Colors.red),
                      label: const Text(
                        'الإبلاغ عن الإعلان',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
