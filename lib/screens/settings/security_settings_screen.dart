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
  bool _deviceManagement = true;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('الأمان'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Password Section
            _buildSectionTitle('كلمة المرور'),
            const SizedBox(height: 12),
            _buildPasswordCard(isDark),
            const SizedBox(height: 24),

            // Authentication Section
            _buildSectionTitle('المصادقة'),
            const SizedBox(height: 12),
            _buildAuthCard(isDark),
            const SizedBox(height: 24),

            // Active Sessions
            _buildSectionTitle('الجلسات النشطة'),
            const SizedBox(height: 12),
            _buildSessionsCard(isDark),
            const SizedBox(height: 24),

            // Security Log
            _buildSectionTitle('سجل الأمان'),
            const SizedBox(height: 12),
            _buildSecurityLogCard(isDark),
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

  Widget _buildPasswordCard(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _buildPasswordField('كلمة المرور الحالية', true),
          const SizedBox(height: 12),
          _buildPasswordField('كلمة المرور الجديدة', true),
          const SizedBox(height: 12),
          _buildPasswordField('تأكيد كلمة المرور', true),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('تم تغيير كلمة المرور بنجاح'),
                    backgroundColor: AppTheme.success,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.goldColor,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('تغيير كلمة المرور'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField(String hint, bool obscure) {
    return TextField(
      obscureText: obscure,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Theme.of(context).brightness == Brightness.dark
            ? AppTheme.darkSurface
            : AppTheme.lightSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        suffixIcon: const Icon(Icons.lock, color: Colors.grey),
      ),
    );
  }

  Widget _buildAuthCard(bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          SwitchListTile(
            title: const Text('البصمة / Face ID'),
            subtitle: const Text('تسجيل الدخول باستخدام البصمة'),
            value: _biometricEnabled,
            onChanged: (value) {
              setState(() => _biometricEnabled = value);
            },
            secondary: const Icon(Icons.fingerprint, color: AppTheme.goldColor),
          ),
          const Divider(height: 1),
          SwitchListTile(
            title: const Text('التحقق بخطوتين'),
            subtitle: const Text('إضافة طبقة أمان إضافية'),
            value: _twoFactorEnabled,
            onChanged: (value) {
              setState(() => _twoFactorEnabled = value);
            },
            secondary: const Icon(Icons.security, color: AppTheme.goldColor),
          ),
          const Divider(height: 1),
          SwitchListTile(
            title: const Text('إشعارات تسجيل الدخول'),
            subtitle: const Text('إعلامي عند تسجيل الدخول من جهاز جديد'),
            value: _loginNotifications,
            onChanged: (value) {
              setState(() => _loginNotifications = value);
            },
            secondary: const Icon(Icons.notifications, color: AppTheme.goldColor),
          ),
          const Divider(height: 1),
          SwitchListTile(
            title: const Text('إدارة الأجهزة'),
            subtitle: const Text('مراقبة الأجهزة المتصلة'),
            value: _deviceManagement,
            onChanged: (value) {
              setState(() => _deviceManagement = value);
            },
            secondary: const Icon(Icons.devices, color: AppTheme.goldColor),
          ),
        ],
      ),
    );
  }

  Widget _buildSessionsCard(bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _buildSessionItem(
            'هذا الجهاز',
            'iPhone 14 Pro',
            'صنعاء، اليمن',
            'نشط الآن',
            true,
          ),
          const Divider(height: 1),
          _buildSessionItem(
            'Chrome على Windows',
            'Chrome Browser',
            'صنعاء، اليمن',
            'منذ 2 ساعة',
            false,
          ),
          const Divider(height: 1),
          _buildSessionItem(
            'تطبيق Android',
            'Samsung Galaxy S23',
            'عدن، اليمن',
            'منذ يوم',
            false,
          ),
        ],
      ),
    );
  }

  Widget _buildSessionItem(
    String name,
    String device,
    String location,
    String time,
    bool isCurrent,
  ) {
    return ListTile(
      leading: Icon(
        Icons.phone_android,
        color: isCurrent ? AppTheme.goldColor : Colors.grey,
      ),
      title: Row(
        children: [
          Text(name),
          if (isCurrent)
            Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppTheme.goldColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'الحالي',
                style: TextStyle(
                  color: AppTheme.goldColor,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
      subtitle: Text('$device • $location • $time'),
      trailing: !isCurrent
          ? TextButton(
              onPressed: () {},
              child: const Text(
                'إنهاء',
                style: TextStyle(color: AppTheme.error),
              ),
            )
          : null,
    );
  }

  Widget _buildSecurityLogCard(bool isDark) {
    final logs = [
      {
        'action': 'تسجيل الدخول',
        'device': 'iPhone 14 Pro',
        'time': 'اليوم، 10:30 ص',
        'status': 'نجاح',
      },
      {
        'action': 'تغيير كلمة المرور',
        'device': 'Chrome Browser',
        'time': 'أمس، 08:15 م',
        'status': 'نجاح',
      },
      {
        'action': 'تسجيل الدخول',
        'device': 'Chrome Browser',
        'time': 'أمس، 08:10 م',
        'status': 'نجاح',
      },
      {
        'action': 'محاولة تسجيل دخول',
        'device': 'Unknown Device',
        'time': '22/03، 03:45 ص',
        'status': 'فشل',
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: logs.map((log) {
          final isSuccess = log['status'] == 'نجاح';
          return ListTile(
            leading: Icon(
              isSuccess ? Icons.check_circle : Icons.error,
              color: isSuccess ? AppTheme.success : AppTheme.error,
            ),
            title: Text(log['action']!),
            subtitle: Text('${log['device']} • ${log['time']}'),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: isSuccess
                    ? AppTheme.success.withValues(alpha: 0.2)
                    : AppTheme.error.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                log['status']!,
                style: TextStyle(
                  color: isSuccess ? AppTheme.success : AppTheme.error,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
