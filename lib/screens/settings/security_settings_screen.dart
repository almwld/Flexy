import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class SecuritySettingsScreen extends StatefulWidget {
  const SecuritySettingsScreen({super.key});

  @override
  State<SecuritySettingsScreen> createState() => _SecuritySettingsScreenState();
}

class _SecuritySettingsScreenState extends State<SecuritySettingsScreen> {
  bool _biometricEnabled = true;
  bool _twoFactorEnabled = false;
  bool _loginNotifications = true;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('الأمان والخصوصية'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('كلمة المرور'),
            const SizedBox(height: 8),
            _buildCard(
              child: ListTile(
                leading: const Icon(Icons.lock, color: AppTheme.goldColor),
                title: const Text('تغيير كلمة المرور'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // show dialog
                },
              ),
            ),
            const SizedBox(height: 16),

            _buildSectionTitle('المصادقة'),
            const SizedBox(height: 8),
            _buildCard(
              child: Column(
                children: [
                  SwitchListTile(
                    title: const Text('البصمة / Face ID'),
                    subtitle: const Text('تسجيل الدخول باستخدام البصمة'),
                    value: _biometricEnabled,
                    onChanged: (value) => setState(() => _biometricEnabled = value),
                    secondary: const Icon(Icons.fingerprint, color: AppTheme.goldColor),
                  ),
                  const Divider(),
                  SwitchListTile(
                    title: const Text('التحقق بخطوتين'),
                    subtitle: const Text('إرسال رمز عبر SMS عند تسجيل الدخول'),
                    value: _twoFactorEnabled,
                    onChanged: (value) => setState(() => _twoFactorEnabled = value),
                    secondary: const Icon(Icons.security, color: AppTheme.goldColor),
                  ),
                  const Divider(),
                  SwitchListTile(
                    title: const Text('إشعارات تسجيل الدخول'),
                    subtitle: const Text('إعلامي عند الدخول من جهاز جديد'),
                    value: _loginNotifications,
                    onChanged: (value) => setState(() => _loginNotifications = value),
                    secondary: const Icon(Icons.notifications, color: AppTheme.goldColor),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            _buildSectionTitle('الخصوصية'),
            const SizedBox(height: 8),
            _buildCard(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.visibility_off, color: AppTheme.goldColor),
                    title: const Text('إخفاء رقم الهاتف'),
                    subtitle: const Text('عند عرض إعلاناتك'),
                    trailing: Switch(
                      value: true,
                      onChanged: (value) {},
                      activeColor: AppTheme.goldColor,
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.location_off, color: AppTheme.goldColor),
                    title: const Text('إخفاء الموقع الدقيق'),
                    subtitle: const Text('عرض المدينة فقط'),
                    trailing: Switch(
                      value: false,
                      onChanged: (value) {},
                      activeColor: AppTheme.goldColor,
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
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppTheme.goldColor,
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }
}
