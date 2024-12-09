// lib/models/coupon.dart
class Coupon {
  final String code;
  final double discount;
  final String category;
  final String validUntil;

  Coupon({
    required this.code,
    required this.discount,
    required this.category,
    required this.validUntil,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) {
    return Coupon(
      code: json['code'] as String,
      discount: (json['discount'] as num).toDouble(),
      category: json['category'] as String,
      validUntil: json['validUntil'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'discount': discount,
      'category': category,
      'validUntil': validUntil,
    };
  }
}