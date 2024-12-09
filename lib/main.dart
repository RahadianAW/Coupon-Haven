import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const CouponApp());
}

class CouponApp extends StatelessWidget {
  const CouponApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coupon Haven',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
