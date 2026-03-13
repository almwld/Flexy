class WalletModel {
  final String id;
  final String userId;
  final double yerBalance;
  final double sarBalance;
  final double usdBalance;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  WalletModel({
    required this.id,
    required this.userId,
    this.yerBalance = 0.0,
    this.sarBalance = 0.0,
    this.usdBalance = 0.0,
    this.createdAt,
    this.updatedAt,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      id: json['id'],
      userId: json['user_id'],
      yerBalance: (json['yer_balance'] as num?)?.toDouble() ?? 0.0,
      sarBalance: (json['sar_balance'] as num?)?.toDouble() ?? 0.0,
      usdBalance: (json['usd_balance'] as num?)?.toDouble() ?? 0.0,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'yer_balance': yerBalance,
      'sar_balance': sarBalance,
      'usd_balance': usdBalance,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  double getTotalBalance(String currency) {
    switch (currency.toUpperCase()) {
      case 'YER':
        return yerBalance;
      case 'SAR':
        return sarBalance;
      case 'USD':
        return usdBalance;
      default:
        return 0.0;
    }
  }

  String getCurrencySymbol(String currency) {
    switch (currency.toUpperCase()) {
      case 'YER':
        return 'ر.ي';
      case 'SAR':
        return 'ر.س';
      case 'USD':
        return '\$';
      default:
        return '';
    }
  }

  WalletModel copyWith({
    String? id,
    String? userId,
    double? yerBalance,
    double? sarBalance,
    double? usdBalance,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return WalletModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      yerBalance: yerBalance ?? this.yerBalance,
      sarBalance: sarBalance ?? this.sarBalance,
      usdBalance: usdBalance ?? this.usdBalance,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class TransactionModel {
  final String id;
  final String userId;
  final String type;
  final double amount;
  final String currency;
  final String? description;
  final String? recipientId;
  final DateTime createdAt;
  final Map<String, dynamic>? recipient;

  TransactionModel({
    required this.id,
    required this.userId,
    required this.type,
    required this.amount,
    required this.currency,
    this.description,
    this.recipientId,
    required this.createdAt,
    this.recipient,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      userId: json['user_id'],
      type: json['type'],
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'],
      description: json['description'],
      recipientId: json['recipient_id'],
      createdAt: DateTime.parse(json['created_at']),
      recipient: json['recipient'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'type': type,
      'amount': amount,
      'currency': currency,
      'description': description,
      'recipient_id': recipientId,
      'created_at': createdAt.toIso8601String(),
    };
  }

  String get typeText {
    switch (type) {
      case 'deposit':
        return 'إيداع';
      case 'withdraw':
        return 'سحب';
      case 'transfer':
        return 'تحويل';
      case 'payment':
        return 'دفع';
      case 'receive':
        return 'استلام';
      default:
        return type;
    }
  }

  bool get isPositive {
    return type == 'deposit' || type == 'receive';
  }

  String get formattedAmount {
    final symbol = _getCurrencySymbol(currency);
    return '${isPositive ? '+' : '-'} ${amount.toStringAsFixed(2)} $symbol';
  }

  String _getCurrencySymbol(String currency) {
    switch (currency.toUpperCase()) {
      case 'YER':
        return 'ر.ي';
      case 'SAR':
        return 'ر.س';
      case 'USD':
        return '\$';
      default:
        return currency;
    }
  }

  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inDays > 365) {
      return 'منذ ${difference.inDays ~/ 365} سنة';
    } else if (difference.inDays > 30) {
      return 'منذ ${difference.inDays ~/ 30} شهر';
    } else if (difference.inDays > 0) {
      return 'منذ ${difference.inDays} يوم';
    } else if (difference.inHours > 0) {
      return 'منذ ${difference.inHours} ساعة';
    } else if (difference.inMinutes > 0) {
      return 'منذ ${difference.inMinutes} دقيقة';
    } else {
      return 'الآن';
    }
  }
}
