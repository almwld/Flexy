import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import 'ad_detail_screen.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  // بيانات وهمية للعروض
  final List<Map<String, dynamic>> _offers = const [
    {
      'id': 'offer1',
      'title': 'خصم 50% على أول إعلان',
      'description': 'للتجار الجدد، انشر إعلانك الأول بنصف السعر',
      'discount': '50%',
      'validUntil': 'ينتهي 30 مارس',
      'code': 'WELCOME50',
      'image': 'https://images.unsplash.com/photo-1534723452862-4c874018d66d?w=400',
      'backgroundColor': Colors.purple,
    },
    {
      'id': 'offer2',
      'title': 'شحن مجاني للمحفظة',
      'description': 'عند شحن 10,000 ريال أو أكثر',
      'discount': 'مجاني',
      'validUntil': 'عرض محدود',
      'code': 'FREECHARGE',
      'image': 'https://images.unsplash.com/photo-1563013544-824ae1b704d3?w=400',
      'backgroundColor': Colors.blue,
    },
    {
      'id': 'offer3',
      'title': 'بطاقة أمازون بقيمة 10$',
      'description': 'عند شرائك 5 إعلانات مميزة',
      'discount': '10$',
      'validUntil': 'أيام محدودة',
      'code': 'AMAZON10',
      'image': 'https://images.unsplash.com/photo-1523474253046-8cd2748b5fd2?w=400',
      'backgroundColor': Colors.orange,
    },
    {
      'id': 'offer4',
      'title': 'خصم 30% على باقات الترويج',
      'description': 'لأصحاب المتاجر، عزز مبيعاتك',
      'discount': '30%',
      'validUntil': 'حتى نفاد الكمية',
      'code': 'PROMO30',
      'image': 'https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=400',
      'backgroundColor': Colors.green,
    },
    {
      'id': 'offer5',
      'title': 'هدية اشتراك VIP',
      'description': 'اشترك لمدة شهر واحصل على شهر مجاني',
      'discount': 'شهر مجاني',
      'validUntil': 'عرض خاص',
      'code': 'VIPFREE',
      'image': 'https://images.unsplash.com/photo-1533750349088-cd871a92f312?w=400',
      'backgroundColor': Colors.red,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('العروض'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _offers.length,
        itemBuilder: (context, index) {
          final offer = _offers[index];
          return _buildOfferCard(offer, index, isDark);
        },
      ),
    );
  }

  Widget _buildOfferCard(Map<String, dynamic> offer, int index, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      height: 140,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            offer['backgroundColor'],
            offer['backgroundColor'].withOpacity(0.7),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: offer['backgroundColor'].withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // صورة خلفية زخرفية
          Positioned(
            right: -20,
            bottom: -20,
            child: Icon(
              Icons.local_offer,
              size: 120,
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          // المحتوى
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // نص العرض
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        offer['title'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        offer['description'],
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 12,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.access_time, size: 12, color: Colors.white),
                            const SizedBox(width: 4),
                            Text(
                              offer['validUntil'],
                              style: const TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // كود الخصم وزر النسخ
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          offer['code'],
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          // نسخ الكود
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('تم نسخ الكود ${offer['code']}'),
                              backgroundColor: AppTheme.success,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          minimumSize: const Size(80, 30),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('نسخ'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: (index * 100).ms).slideX(begin: 0.2, end: 0);
  }
}
