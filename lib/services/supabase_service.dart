import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseClient client = Supabase.instance.client;

  // المستخدم الحالي
  static User? get currentUser => client.auth.currentUser;

  // التحقق من حالة تسجيل الدخول
  static bool get isAuthenticated => currentUser != null;

  // تسجيل الدخول
  static Future<AuthResponse> signIn(String email, String password) async {
    return await client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  // إنشاء حساب
  static Future<AuthResponse> signUp(
    String email,
    String password, {
    Map<String, dynamic>? data,
  }) async {
    return await client.auth.signUp(
      email: email,
      password: password,
      data: data,
    );
  }

  // تسجيل الخروج
  static Future<void> signOut() async {
    await client.auth.signOut();
  }

  // إعادة تعيين كلمة المرور
  static Future<void> resetPassword(String email) async {
    await client.auth.resetPasswordForEmail(email);
  }

  // تحديث كلمة المرور
  static Future<void> updatePassword(String newPassword) async {
    await client.auth.updateUser(
      UserAttributes(password: newPassword),
    );
  }

  // جلب الإعلانات
  static Future<List<Map<String, dynamic>>> getAds({
    String? category,
    String? city,
    String? search,
    int limit = 20,
    int offset = 0,
  }) async {
    var query = client.from('ads').select('*, profiles:user_id(*)');

    if (category != null && category != 'الكل') {
      query = query.eq('category', category);
    }

    if (city != null && city != 'الكل') {
      query = query.eq('city', city);
    }

    if (search != null && search.isNotEmpty) {
      query = query.ilike('title', '%$search%');
    }

    final response = await query
        .order('created_at', ascending: false)
        .range(offset, offset + limit - 1);

    return List<Map<String, dynamic>>.from(response);
  }

  // جلب إعلان واحد
  static Future<Map<String, dynamic>?> getAd(String id) async {
    final response = await client
        .from('ads')
        .select('*, profiles:user_id(*)')
        .eq('id', id)
        .single();

    return response;
  }

  // إضافة إعلان
  static Future<void> addAd(Map<String, dynamic> adData) async {
    await client.from('ads').insert({
      ...adData,
      'user_id': currentUser!.id,
    });
  }

  // تحديث إعلان
  static Future<void> updateAd(String id, Map<String, dynamic> adData) async {
    await client.from('ads').update(adData).eq('id', id);
  }

  // حذف إعلان
  static Future<void> deleteAd(String id) async {
    await client.from('ads').delete().eq('id', id);
  }

  // جلب إعلانات المستخدم
  static Future<List<Map<String, dynamic>>> getUserAds() async {
    final response = await client
        .from('ads')
        .select('*')
        .eq('user_id', currentUser!.id)
        .order('created_at', ascending: false);

    return List<Map<String, dynamic>>.from(response);
  }

  // رفع صورة
  static Future<String> uploadImage(String path, List<int> file) async {
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    final fullPath = '$path/$fileName';

    await client.storage.from('images').uploadBinary(
          fullPath,
          file,
          fileOptions: const FileOptions(contentType: 'image/jpeg'),
        );

    return client.storage.from('images').getPublicUrl(fullPath);
  }

  // المحادثات
  static Future<List<Map<String, dynamic>>> getChats() async {
    final response = await client
        .from('chats')
        .select('*, other_user:profiles!other_user_id(*)')
        .eq('user_id', currentUser!.id)
        .order('last_message_time', ascending: false);

    return List<Map<String, dynamic>>.from(response);
  }

  // إنشاء محادثة
  static Future<void> createChat(String otherUserId) async {
    await client.from('chats').insert({
      'user_id': currentUser!.id,
      'other_user_id': otherUserId,
    });
  }

  // جلب الرسائل
  static Future<List<Map<String, dynamic>>> getMessages(String chatId) async {
    final response = await client
        .from('messages')
        .select('*')
        .eq('chat_id', chatId)
        .order('created_at', ascending: true);

    return List<Map<String, dynamic>>.from(response);
  }

  // إرسال رسالة
  static Future<void> sendMessage(String chatId, String content) async {
    await client.from('messages').insert({
      'chat_id': chatId,
      'sender_id': currentUser!.id,
      'content': content,
    });

    await client.from('chats').update({
      'last_message': content,
      'last_message_time': DateTime.now().toIso8601String(),
    }).eq('id', chatId);
  }

  // الاستماع للرسائل الجديدة
  static Stream<List<Map<String, dynamic>>> messagesStream(String chatId) {
    return client
        .from('messages')
        .stream(primaryKey: ['id'])
        .eq('chat_id', chatId)
        .order('created_at')
        .map((data) => List<Map<String, dynamic>>.from(data));
  }

  // المحفظة
  static Future<Map<String, dynamic>?> getWallet() async {
    final response = await client
        .from('wallets')
        .select('*')
        .eq('user_id', currentUser!.id)
        .single();

    return response;
  }

  // إنشاء محفظة
  static Future<void> createWallet() async {
    await client.from('wallets').insert({
      'user_id': currentUser!.id,
      'yer_balance': 0.0,
      'sar_balance': 0.0,
      'usd_balance': 0.0,
    });
  }

  // تحديث الرصيد
  static Future<void> updateBalance({
    required String currency,
    required double amount,
  }) async {
    final column = '${currency.toLowerCase()}_balance';
    await client.from('wallets').update({
      column: amount,
    }).eq('user_id', currentUser!.id);
  }

  // العمليات
  static Future<List<Map<String, dynamic>>> getTransactions({
    int limit = 20,
    int offset = 0,
  }) async {
    final response = await client
        .from('transactions')
        .select('*')
        .eq('user_id', currentUser!.id)
        .order('created_at', ascending: false)
        .range(offset, offset + limit - 1);

    return List<Map<String, dynamic>>.from(response);
  }

  // إنشاء عملية
  static Future<void> createTransaction({
    required String type,
    required double amount,
    required String currency,
    String? description,
    String? recipientId,
  }) async {
    await client.from('transactions').insert({
      'user_id': currentUser!.id,
      'type': type,
      'amount': amount,
      'currency': currency,
      'description': description,
      'recipient_id': recipientId,
    });
  }

  // المفضلة
  static Future<List<Map<String, dynamic>>> getFavorites() async {
    final response = await client
        .from('favorites')
        .select('*, ads(*)')
        .eq('user_id', currentUser!.id)
        .order('created_at', ascending: false);

    return List<Map<String, dynamic>>.from(response);
  }

  // إضافة للمفضلة
  static Future<void> addToFavorites(String adId) async {
    await client.from('favorites').insert({
      'user_id': currentUser!.id,
      'ad_id': adId,
    });
  }

  // إزالة من المفضلة
  static Future<void> removeFromFavorites(String adId) async {
    await client
        .from('favorites')
        .delete()
        .eq('user_id', currentUser!.id)
        .eq('ad_id', adId);
  }

  // التحقق من المفضلة
  static Future<bool> isFavorite(String adId) async {
    final response = await client
        .from('favorites')
        .select()
        .eq('user_id', currentUser!.id)
        .eq('ad_id', adId)
        .single();

    return response != null;
  }

  // الإشعارات
  static Future<List<Map<String, dynamic>>> getNotifications({
    int limit = 20,
    int offset = 0,
  }) async {
    final response = await client
        .from('notifications')
        .select('*')
        .eq('user_id', currentUser!.id)
        .order('created_at', ascending: false)
        .range(offset, offset + limit - 1);

    return List<Map<String, dynamic>>.from(response);
  }

  // تحديث حالة الإشعار
  static Future<void> markNotificationAsRead(String id) async {
    await client.from('notifications').update({
      'is_read': true,
    }).eq('id', id);
  }

  // تحديث الملف الشخصي
  static Future<void> updateProfile(Map<String, dynamic> data) async {
    await client.from('profiles').update(data).eq('id', currentUser!.id);
  }

  // جلب الملف الشخصي
  static Future<Map<String, dynamic>?> getProfile() async {
    final response = await client
        .from('profiles')
        .select('*')
        .eq('id', currentUser!.id)
        .single();

    return response;
  }
}
