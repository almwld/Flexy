import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _faqs = [
    {'q': 'كيف يمكنني إنشاء حساب جديد؟', 'a': 'يمكنك إنشاء حساب جديد من خلال شاشة تسجيل الدخول ثم الضغط على "إنشاء حساب جديد".'},
    {'q': 'كيف أضيف إعلاناً؟', 'a': 'من الشريط السفلي اضغط على أيقونة + واتبع الخطوات.'},
    {'q': 'كيف أتواصل مع البائع؟', 'a': 'يمكنك مراسلة البائع من خلال صفحة الإعلان بالضغط على "مراسلة".'},
    {'q': 'هل يوجد ضمان على المنتجات؟', 'a': 'الضمان يعتمد على البائع. ننصح بالتحقق من التفاصيل قبل الشراء.'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('المساعدة والدعم'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('طرق التواصل'),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildContactCard(
                    icon: Icons.chat,
                    label: 'دردشة مباشرة',
                    color: Colors.green,
                    onTap: () {},
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildContactCard(
                    icon: Icons.phone,
                    label: 'اتصال',
                    color: Colors.blue,
                    onTap: () {},
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildContactCard(
                    icon: Icons.email,
                    label: 'بريد',
                    color: Colors.orange,
                    onTap: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            _buildSectionTitle('الأسئلة الشائعة'),
            const SizedBox(height: 12),
            ..._faqs.map((faq) => _buildFaqItem(faq['q']!, faq['a']!, isDark)),

            const SizedBox(height: 24),
            _buildSectionTitle('أرسل رسالة'),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  TextField(
                    controller: _messageController,
                    maxLines: 5,
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      hintText: 'اكتب رسالتك هنا...',
                      filled: true,
                      fillColor: isDark ? AppTheme.darkSurface : AppTheme.lightSurface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
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
                      ),
                      child: const Text('إرسال'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppTheme.goldColor,
      ),
    );
  }

  Widget _buildContactCard({required IconData icon, required String label, required Color color, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildFaqItem(String question, String answer, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        title: Text(question, style: const TextStyle(fontWeight: FontWeight.bold)),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(answer, style: TextStyle(color: Colors.grey[500])),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}
