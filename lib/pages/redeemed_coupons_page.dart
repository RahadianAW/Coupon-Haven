import 'package:flutter/material.dart';
import '../models/coupon.dart';

class RedeemedCouponsPage extends StatelessWidget {
  final List<Coupon> redeemedCoupons;

  const RedeemedCouponsPage({super.key, required this.redeemedCoupons});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Redeemed Coupons'),
      ),
      body: redeemedCoupons.isEmpty
          ? const Center(
              child: Text('No redeemed coupons yet.'),
            )
          : ListView.builder(
              itemCount: redeemedCoupons.length,
              itemBuilder: (context, index) {
                final coupon = redeemedCoupons[index];
                return ListTile(
                  title: Text(coupon.code),
                  subtitle:
                      Text('${coupon.discount}% off in ${coupon.category}'),
                  trailing: Text('Valid until: ${coupon.validUntil}'),
                );
              },
            ),
    );
  }
}
