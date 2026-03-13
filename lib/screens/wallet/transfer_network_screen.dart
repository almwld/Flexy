import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../theme/app_theme.dart';

class TransferNetworkScreen extends StatefulWidget {
  const TransferNetworkScreen({super.key});

  @override
  State<TransferNetworkScreen> createState() => _TransferNetworkScreenState();
}

class _TransferNetworkScreenState extends State<TransferNetworkScreen> {
  final List<Map<String, dynamic>> _networkOptions = [
    {'title': 'إرسال حوالة', 'icon': Icons.send, 'color': Colors.green},
    {'title': 'استلام حوالة', 'icon': Icons.download, 'color': Colors.blue},
    {'title': 'حالة حوالة', 'icon': Icons.info_outline, 'color': Colors.orange},
    {'title': 'إلغاء حوالة', 'icon': Icons.cancel, 'color': Colors.red},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('شبكة تحويل'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // البطاقة الرئيسية
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppTheme.goldPrimary, AppTheme.goldPrimary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.goldPrimary.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'الرصيد المتاح',
                    style: TextStyle(color: Colors.black54, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '125,000 ر.ي',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn().scale(),

            const SizedBox(height: 24),

            // خيارات الشبكة
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: _networkOptions.length,
              itemBuilder: (context, index) {
                final option = _networkOptions[index];
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: (option['color'] as Color).withOpacity(0.3),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: (option['color'] as Color).withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            option['icon'],
                            color: option['color'],
                            size: 32,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          option['title'],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ).animate().fadeIn(delay: (index * 50).ms);
              },
            ),

            const SizedBox(height: 24),

            // سجل الحوالات الأخيرة
            const Text(
              'آخر الحوالات',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.green.withOpacity(0.2),
                    child: const Icon(Icons.check, color: Colors.green, size: 20),
                  ),
                  title: Text('حوالة إلى أحمد محمد'),
                  subtitle: Text('10,000 ر.ي • تمت بنجاح'),
                  trailing: Text('10:30 ص'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
