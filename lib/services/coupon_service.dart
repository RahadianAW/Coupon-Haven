// lib/services/coupon_service.dart
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/coupon.dart';

class CouponService {
  Future<List<Coupon>> fetchCoupons() async {
    try {
      // Baca file json dari assets
      final String jsonString = await rootBundle.loadString('db.json');
      final Map<String, dynamic> jsonResponse = json.decode(jsonString);
      
      // Pastikan kita mengakses array coupons dari JSON
      final List<dynamic> jsonData = jsonResponse['coupons'] ?? [];
      
      // Convert ke List<Coupon>
      return jsonData.map((json) => Coupon.fromJson(json)).toList();
    } catch (e) {
      print('Error loading coupons: $e'); // Untuk debugging
      throw Exception('Failed to load coupons: $e');
    }
  }
}