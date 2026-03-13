import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';

class LiveSupportScreen extends StatefulWidget {
  const LiveSupportScreen({super.key});

  @override
  State<LiveSupportScreen> createState() => _LiveSupportScreenState();
}

class _LiveSupportScreenState extends State<LiveSupportScreen> {
  final TextEditingController _messageController = TextEditingController();

  final List<Map<String, dynamic>> _supportOptions = [
    {'name': 'واتساب', 'icon': Icons.chat, 'color': Colors.green, 'link': 'https://wa.me/967777123456'},
    {'name': 'اتصال', 'icon': Icons.phone, 'color': Colors.blue, 'link': 'tel:+967777123456'},
    {'name': 'بريد إلكتروني', 'icon': Icons.email, 'color': Colors.orange, 'link': 'mailto:support@flexyemen.com'},
    {'name': 'تليجرام', 'icon': Icons.telegram, 'color': Colors.lightBlue, 'link': 'https://t.me/flexyemen'},
  ];

  final List<Map<String, String>> _faqs = [
    {'q': 'كيف يمكنني إنشاء حساب؟', 'a': 'يمكنك إنشاء حساب من شاشة تسجيل الدخول بالضغط على "إنشاء حساب جديد".'},
    {'q': 'ماذا أفعل إذا نسيت كلمة المرور؟', 'a': 'استخدم خيار "نسيت كلمة المرور" في شاشة تسجيل الدخول لإعادة تعيينها.'},
    {'q': 'كيف أضيف إعلاناً؟', 'a': 'من الشريط السفلي اضغط على أيقونة + واتبع الخطوات.'},
    {'q': 'كيف أتواصل مع البائع؟', 'a': 'يمكنك مراسلة البائع من خلال صفحة الإعلان بالضغط على "محادثة".'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('الدعم الفني'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // قنوات التواصل السريعة
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'تواصل معنا مباشرة',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: _supportOptions.map((opt) {
                      return GestureDetector(
                        onTap: () {
                          // فتح الرابط (يمكن تنفيذه لاحقاً)
                        },
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: (opt['color'] as Color).withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(opt['icon'], color: opt['color'], size: 30),
                            ),
                            const SizedBox(height: 8),
                            Text(opt['name'], style: const TextStyle(fontSize: 12)),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ).animate().fadeIn().slideY(begin: 0.2, end: 0),

            const SizedBox(height: 16),

            // نموذج إرسال رسالة
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'أرسل رسالة',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _messageController,
                    textAlign: TextAlign.right,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'اكتب استفسارك هنا...',
                      filled: true,
                      fillColor: isDark ? AppTheme.darkSurface : AppTheme.lightSurface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.grey,
                            side: const BorderSide(color: Colors.grey),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('إرفاق صورة'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('تم إرسال رسالتك'),
                                backgroundColor: AppTheme.success,
                              ),
                            );
                            _messageController.clear();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.goldColor,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('إرسال'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.2, end: 0),

            const SizedBox(height: 16),

            // الأسئلة الشائعة
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'الأسئلة الشائعة',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ..._faqs.map((faq) {
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      color: isDark ? AppTheme.darkSurface : AppTheme.lightSurface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ExpansionTile(
                        title: Text(
                          faq['q']!,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              faq['a']!,
                              style: TextStyle(color: Colors.grey[500]),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2, end: 0),

            const SizedBox(height: 24),

            // زر المحادثة المباشرة (واتساب)
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: () {
                  // فتح رابط واتساب
                },
                icon: const Icon(Icons.chat, color: Colors.white),
                label: const Text(
                  'محادثة مباشرة عبر واتساب',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ).animate().fadeIn(delay: 300.ms).scale(begin: const Offset(0.9, 0.9)),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}
