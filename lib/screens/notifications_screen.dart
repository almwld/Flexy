import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<Map<String, dynamic>> _notifications = [
    {
      'title': 'إعلان جديد في المفضلة',
      'message': 'تم إضافة إعلان جديد في فئة السيارات',
      'time': 'منذ 5 دقائق',
      'icon': Icons.favorite,
      'color': Colors.red,
      'isRead': false,
    },
    {
      'title': 'رسالة جديدة',
      'message': 'أحمد محمد أرسل لك رسالة',
      'time': 'منذ 15 دقيقة',
      'icon': Icons.message,
      'color': Colors.blue,
      'isRead': false,
    },
    {
      'title': 'تم الموافقة على إعلانك',
      'message': 'إعلان "سيارة تويوتا" تمت الموافقة عليه',
      'time': 'منذ ساعة',
      'icon': Icons.check_circle,
      'color': Colors.green,
      'isRead': true,
    },
    {
      'title': 'عرض جديد',
      'message': 'هناك عرض جديد على إعلانك',
      'time': 'منذ 3 ساعات',
      'icon': Icons.local_offer,
      'color': Colors.orange,
      'isRead': true,
    },
    {
      'title': 'تنبيه أمان',
      'message': 'تم تسجيل الدخول من جهاز جديد',
      'time': 'أمس',
      'icon': Icons.security,
      'color': Colors.purple,
      'isRead': true,
    },
    {
      'title': 'تحديث التطبيق',
      'message': 'إصدار جديد متاح للتحميل',
      'time': 'أمس',
      'icon': Icons.update,
      'color': Colors.teal,
      'isRead': true,
    },
    {
      'title': 'تذكير',
      'message': 'مزادك ينتهي خلال ساعة',
      'time': 'منذ يومين',
      'icon': Icons.timer,
      'color': Colors.amber,
      'isRead': true,
    },
  ];

  void _markAllAsRead() {
    setState(() {
      for (var notification in _notifications) {
        notification['isRead'] = true;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('تم تحديد جميع الإشعارات كمقروءة'),
        backgroundColor: AppTheme.success,
      ),
    );
  }

  void _deleteNotification(int index) {
    setState(() {
      _notifications.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final unreadCount = _notifications.where((n) => !n['isRead']).length;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            const Text('الإشعارات'),
            if (unreadCount > 0)
              Text(
                '$unreadCount غير مقروء',
                style: TextStyle(
                  fontSize: 12,
                  color: AppTheme.goldColor,
                ),
              ),
          ],
        ),
        actions: [
          if (unreadCount > 0)
            TextButton(
              onPressed: _markAllAsRead,
              child: const Text('تحديد الكل'),
            ),
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'clear',
                child: Row(
                  children: [
                    Icon(Icons.delete_outline, color: Colors.red),
                    SizedBox(width: 8),
                    Text('مسح الكل'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'settings',
                child: Row(
                  children: [
                    Icon(Icons.settings, color: Colors.grey),
                    SizedBox(width: 8),
                    Text('إعدادات الإشعارات'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: _notifications.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _notifications.length,
              itemBuilder: (context, index) {
                final notification = _notifications[index];
                return _buildNotificationItem(notification, index, isDark);
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_off_outlined,
            size: 80,
            color: Colors.grey[600],
          ),
          const SizedBox(height: 16),
          Text(
            'لا توجد إشعارات',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'سنخبرك عندما يكون هناك شيء جديد',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(
    Map<String, dynamic> notification,
    int index,
    bool isDark,
  ) {
    final color = notification['color'] as Color;
    final isRead = notification['isRead'] as bool;

    return Dismissible(
      key: Key('notification_$index'),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) => _deleteNotification(index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: isDark ? AppTheme.darkCard : AppTheme.lightCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isRead
                ? (isDark ? Colors.grey[800]! : Colors.grey[300]!)
                : AppTheme.goldColor.withValues(alpha: 0.5),
          ),
        ),
        child: ListTile(
          onTap: () {
            setState(() {
              notification['isRead'] = true;
            });
          },
          leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              notification['icon'] as IconData,
              color: color,
              size: 24,
            ),
          ),
          title: Row(
            children: [
              Expanded(
                child: Text(
                  notification['title'] as String,
                  style: TextStyle(
                    fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
                  ),
                ),
              ),
              if (!isRead)
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppTheme.goldColor,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                notification['message'] as String,
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                notification['time'] as String,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 11,
                ),
              ),
            ],
          ),
          isThreeLine: true,
        ),
      ),
    )
      .animate()
      .fadeIn(delay: (index * 50).ms, duration: 400.ms)
      .slideX(begin: 0.2, end: 0);
  }
}
