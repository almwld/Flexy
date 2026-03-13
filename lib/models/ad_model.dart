class AdModel {
  final String id;
  final String title;
  final String description;
  final double price;
  final String location;
  final List<String> images;
  final String sellerName;
  final String sellerAvatar;
  final double sellerRating;
  final int sellerReviews;
  final DateTime createdAt;

  AdModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.location,
    required this.images,
    required this.sellerName,
    required this.sellerAvatar,
    required this.sellerRating,
    required this.sellerReviews,
    required this.createdAt,
  });

  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(createdAt);
    if (difference.inDays > 0) return 'منذ ${difference.inDays} يوم';
    if (difference.inHours > 0) return 'منذ ${difference.inHours} ساعة';
    if (difference.inMinutes > 0) return 'منذ ${difference.inMinutes} دقيقة';
    return 'الآن';
  }
}
