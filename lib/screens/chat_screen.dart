import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'chat_detail_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _searchController = TextEditingController();

  final List<Map<String, dynamic>> _chats = [
    {
      'name': 'أحمد محمد',
      'message': 'مرحباً، هل لا يزال المنتج متوفراً؟',
      'time': '10:30',
      'unread': 2,
      'avatar': 'أ',
      'online': true,
    },
    {
      'name': 'خالد علي',
      'message': 'شكراً لك، سأقوم بالتحويل الآن',
      'time': '09:15',
      'unread': 0,
      'avatar': 'خ',
      'online': false,
    },
    {
      'name': 'فاطمة أحمد',
      'message': 'هل يمكن خفض السعر قليلاً؟',
      'time': 'أمس',
      'unread': 1,
      'avatar': 'ف',
      'online': true,
    },
    {
      'name': 'محمد سالم',
      'message': 'تم استلام المنتج، شكراً جزيلاً',
      'time': 'أمس',
      'unread': 0,
      'avatar': 'م',
      'online': false,
    },
    {
      'name': 'عبدالله حسن',
      'message': 'أين يمكننا التقابل؟',
      'time': '22/03',
      'unread': 0,
      'avatar': 'ع',
      'online': true,
    },
    {
      'name': 'سارة محمود',
      'message': 'هل يوجد ضمان على المنتج؟',
      'time': '21/03',
      'unread': 3,
      'avatar': 'س',
      'online': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('المحادثات'),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // شريط البحث
          Container(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                hintText: 'البحث في المحادثات...',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: isDark ? AppTheme.darkCard : AppTheme.lightCard,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          // قائمة المحادثات
          Expanded(
            child: ListView.builder(
              itemCount: _chats.length,
              itemBuilder: (context, index) {
                final chat = _chats[index];
                return _buildChatItem(chat);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // بدء محادثة جديدة
        },
        backgroundColor: AppTheme.goldColor,
        child: const Icon(Icons.chat, color: Colors.black),
      ),
    );
  }

  Widget _buildChatItem(Map<String, dynamic> chat) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hasUnread = chat['unread'] > 0;

    return ListTile(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ChatDetailScreen(
              name: chat['name'],
              avatar: chat['avatar'],
            ),
          ),
        );
      },
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: AppTheme.goldColor.withOpacity( 0.2),
            child: Text(
              chat['avatar'],
              style: const TextStyle(
                color: AppTheme.goldColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (chat['online'])
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
                    width: 2,
                  ),
                ),
              ),
            ),
        ],
      ),
      title: Text(
        chat['name'],
        style: TextStyle(
          fontWeight: hasUnread ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      subtitle: Text(
        chat['message'],
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: hasUnread
              ? (isDark ? Colors.white : Colors.black87)
              : (isDark ? Colors.grey[400] : Colors.grey[600]),
        ),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            chat['time'],
            style: TextStyle(
              fontSize: 12,
              color: isDark ? Colors.grey[400] : Colors.grey[600],
            ),
          ),
          const SizedBox(height: 4),
          if (hasUnread)
            Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: AppTheme.goldColor,
                shape: BoxShape.circle,
              ),
              child: Text(
                chat['unread'].toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
