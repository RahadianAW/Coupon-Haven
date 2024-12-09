// lib/widgets/coupon_card.dart
import 'package:flutter/material.dart';
import 'package:marvel_movies/models/coupon.dart';
import '../utils/constants.dart';

class CouponCard extends StatefulWidget {
  final Coupon coupon;
  final VoidCallback onRedeem;

  const CouponCard({
    Key? key,
    required this.coupon,
    required this.onRedeem,
  }) : super(key: key);

  @override
  State<CouponCard> createState() => _CouponCardState();
}

class _CouponCardState extends State<CouponCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: AppAnimations.fast,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1, end: 1.03).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => isHovered = true);
        _controller.forward();
      },
      onExit: (_) {
        setState(() => isHovered = false);
        _controller.reverse();
      },
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          decoration: AppTheme.cardDecoration,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.coupon.discount}% OFF',
                  style: AppTheme.heading2,
                ),
                const SizedBox(height: 8),
                Text(
                  widget.coupon.category,
                  style: AppTheme.subtitle1,
                ),
                const Spacer(),
                Text(
                  'Code: ${widget.coupon.code}',
                  style: AppTheme.body1.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Valid until: ${widget.coupon.validUntil}',
                  style: AppTheme.body1.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: widget.onRedeem,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: isHovered ? 4 : 2,
                    ),
                    child: const Text('Redeem Now'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}