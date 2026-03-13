import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import 'about_screen.dart';
import 'help_support_screen.dart';
import 'security_settings_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _soundEnabled = true;
  bool _vibrationEnabled = true;
  String _selectedLanguage = 'العربية';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('الإعدادات'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Appearance Section
            _buildSectionTitle('المظهر')
              .animate()
              .fadeIn(duration: 400.ms)
              .slideX(begin: -0.2, end: 0),
            const SizedBox(height: 12),
            _buildAppearanceCard(isDark)
              .animate()
              .fadeIn(delay: 100.ms, duration: 400.ms),
            const SizedBox(height: 24),

            // Notifications Section
            _buildSectionTitle('الإشعارات')
              .animate()
              .fadeIn(delay: 200.ms, duration: 400.ms)
              .slideX(begin: -0.2, end: 0),
            const SizedBox(height: 12),
            _buildNotificationsCard(isDark)
              .animate()
              .fadeIn(delay: 300.ms, duration: 400.ms),
            const SizedBox(height: 24),

            // Language Section
            _buildSectionTitle('اللغة')
              .animate()
              .fadeIn(delay: 400.ms, duration: 400.ms)
              .slideX(begin: -0.2, end: 0),
            const SizedBox(height: 12),
            _buildLanguageCard(isDark)
              .animate()
              .fadeIn(delay: 500.ms, duration: 400.ms),
            const SizedBox(height: 24),

            // Security Section
            _buildSectionTitle('الأمان والخصوصية')
              .animate()
              .fadeIn(delay: 600.ms, duration: 400.ms)
              .slideX(begin: -0.2, end: 0),
            const SizedBox(height: 12),
            _buildSecurityCard(isDark)
              .animate()
              .fadeIn(delay: 700.ms, duration: 400.ms),
            const SizedBox(height: 24),

            // Support Section
            _buildSectionTitle('الدعم')
              .animate()
              .fadeIn(delay: 800.ms, duration: 400.ms)
              .slideX(begin: -0.2, end: 0),
            const SizedBox(height: 12),
            _buildSupportCard(isDark)
              .animate()
              .fadeIn(delay: 900.ms, duration: 400.ms),
            const SizedBox(height: 24),

            // About Section
            _buildSectionTitle('حول')
              .animate()
              .fadeIn(delay: 1000.ms, duration: 400.ms)
              .slideX(begin: -0.2, end: 0),
            const SizedBox(height: 12),
            _buildAboutCard(isDark)
              .animate()
              .fadeIn(delay: 1100.ms, duration: 400.ms),
            const SizedBox(height: 30),
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
      ),
    );
  }

  Widget _buildAppearanceCard(bool isDark) {
    return Consumer<ThemeManager>(
      builder: (context, themeManager, child) {
        return Container(
          decoration: BoxDecoration(
            color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              SwitchListTile(
                title: const Text('الوضع الليلي'),
                subtitle: const Text('تفعيل المظهر الداكن'),
                value: themeManager.isDarkMode,
                onChanged: (value) {
                  themeManager.setDarkMode(value);
                },
                secondary: const Icon(Icons.dark_mode, color: AppTheme.goldColor),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNotificationsCard(bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          SwitchListTile(
            title: const Text('الإشعارات'),
            subtitle: const Text('تفعيل جميع الإشعارات'),
            value: _notificationsEnabled,
            onChanged: (value) {
              setState(() => _notificationsEnabled = value);
            },
            secondary: const Icon(Icons.notifications, color: AppTheme.goldColor),
          ),
          const Divider(height: 1),
          SwitchListTile(
            title: const Text('الصوت'),
            subtitle: const Text('تشغيل صوت الإشعارات'),
            value: _soundEnabled,
            onChanged: _notificationsEnabled
                ? (value) {
                    setState(() => _soundEnabled = value);
                  }
                : null,
            secondary: const Icon(Icons.volume_up, color: AppTheme.goldColor),
          ),
          const Divider(height: 1),
          SwitchListTile(
            title: const Text('الاهتزاز'),
            subtitle: const Text('اهتزاز عند وصول إشعار'),
            value: _vibrationEnabled,
            onChanged: _notificationsEnabled
                ? (value) {
                    setState(() => _vibrationEnabled = value);
                  }
                : null,
            secondary: const Icon(Icons.vibration, color: AppTheme.goldColor),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageCard(bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: const Icon(Icons.language, color: AppTheme.goldColor),
        title: const Text('اللغة'),
        subtitle: Text(_selectedLanguage),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          _showLanguageDialog();
        },
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.darkCard,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text(
          'اختر اللغة',
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: 'Changa'),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildLanguageOption('العربية'),
            _buildLanguageOption('English'),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(String language) {
    return ListTile(
      title: Text(language),
      trailing: _selectedLanguage == language
          ? const Icon(Icons.check, color: AppTheme.goldColor)
          : null,
      onTap: () {
        setState(() => _selectedLanguage = language);
        Navigator.of(context).pop();
      },
    );
  }

  Widget _buildSecurityCard(bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.security, color: AppTheme.goldColor),
            title: const Text('الأمان'),
            subtitle: const Text('كلمة المرور والمصادقة'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const SecuritySettingsScreen(),
                ),
              );
            },
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.privacy_tip, color: AppTheme.goldColor),
            title: const Text('الخصوصية'),
            subtitle: const Text('إعدادات الخصوصية'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.block, color: AppTheme.goldColor),
            title: const Text('الحظر'),
            subtitle: const Text('إدارة قائمة الحظر'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSupportCard(bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.help_outline, color: AppTheme.goldColor),
            title: const Text('المساعدة والدعم'),
            subtitle: const Text('الأسئلة الشائعة والتواصل'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const HelpSupportScreen(),
                ),
              );
            },
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.bug_report, color: AppTheme.goldColor),
            title: const Text('الإبلاغ عن مشكلة'),
            subtitle: const Text('أبلغنا عن أي خطأ'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.star_outline, color: AppTheme.goldColor),
            title: const Text('تقييم التطبيق'),
            subtitle: const Text('قيّم تجربتك'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildAboutCard(bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.info_outline, color: AppTheme.goldColor),
            title: const Text('عن التطبيق'),
            subtitle: const Text('معلومات عن فلكس اليمن'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const AboutScreen(),
                ),
              );
            },
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.description, color: AppTheme.goldColor),
            title: const Text('شروط الاستخدام'),
            subtitle: const Text('الشروط والأحكام'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.policy, color: AppTheme.goldColor),
            title: const Text('سياسة الخصوصية'),
            subtitle: const Text('كيف نحمي بياناتك'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.update, color: AppTheme.goldColor),
            title: const Text('التحقق من التحديثات'),
            subtitle: const Text('الإصدار 1.0.0'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('لديك أحدث إصدار'),
                  backgroundColor: AppTheme.success,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
