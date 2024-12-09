// lib/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:marvel_movies/services/coupon_service.dart';
import '../widgets/navbar/custom_navbar.dart';
import '../widgets/footer/custom_footer.dart';
import '../models/coupon.dart';
import '../widgets/coupon_card.dart';
import '../utils/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Coupon> filteredCoupons = [];
  final TextEditingController searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCoupons();
  }

Future<void> _fetchCoupons() async {
  setState(() => isLoading = true);
  try {
    final coupons = await CouponService().fetchCoupons();
    setState(() {
      filteredCoupons = coupons;
      isLoading = false;
    });
  } catch (e) {
    setState(() => isLoading = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Failed to load coupons: $e'),
        backgroundColor: Colors.red,
      ),
    );
  }
}

  void filterCoupons(String query) {
    if (query.isEmpty) {
      _fetchCoupons();
    } else {
      setState(() {
        filteredCoupons = filteredCoupons.where((coupon) {
          return coupon.code.toLowerCase().contains(query.toLowerCase()) ||
              coupon.category.toLowerCase().contains(query.toLowerCase());
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // Hero Section
                _buildHeroSection(),
                // Featured Coupons
                _buildFeaturedCoupons(),
                // Why Choose Us
                _buildWhyChooseUs(),
                // Footer
                const CustomFooter(),
              ],
            ),
          ),
          // Navbar at top
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CustomNavbar(
              searchController: searchController,
              onSearch: filterCoupons,
            ),
          ),
          // Loading indicator
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
      floatingActionButton: _buildScrollToTopButton(),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      height: 500,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('/hero_background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.6),
              Colors.black.withOpacity(0.4),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Save More with Coupon Haven',
              style: AppTheme.heading1.copyWith(
                color: Colors.white,
                fontSize: 56,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Discover the best deals and save on your favorite brands',
              style: AppTheme.subtitle1.copyWith(
                color: Colors.white,
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => _scrollToFeaturedCoupons(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Browse Coupons',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedCoupons() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Featured Coupons',
              style: AppTheme.heading2.copyWith(fontSize: 32),
            ),
          ),
          const SizedBox(height: 48),
          filteredCoupons.isEmpty && !isLoading
              ? Center(
                  child: Text(
                    'No coupons found',
                    style: AppTheme.subtitle1,
                  ),
                )
              : GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: _getGridCrossAxisCount(context),
                    childAspectRatio: 4 / 3,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                  ),
                  itemCount: filteredCoupons.length,
                  itemBuilder: (context, index) {
                    final coupon = filteredCoupons[index];
                    return CouponCard(
                      coupon: coupon,
                      onRedeem: () => _redeemCoupon(coupon),
                    );
                  },
                ),
        ],
      ),
    );
  }

  Widget _buildWhyChooseUs() {
    final features = [
      {
        'icon': Icons.verified,
        'title': 'Verified Coupons',
        'description': 'All our coupons are verified daily to ensure they work',
      },
      {
        'icon': Icons.savings,
        'title': 'Best Savings',
        'description': 'Get the best deals and discounts on your favorite brands',
      },
      {
        'icon': Icons.update,
        'title': 'Regular Updates',
        'description': 'New coupons and offers added daily',
      },
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 24),
      color: Colors.grey[50],
      child: Column(
        children: [
          Text(
            'Why Choose Us',
            style: AppTheme.heading2.copyWith(fontSize: 32),
          ),
          const SizedBox(height: 48),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: features.map((feature) => SizedBox(
              width: 300,
              child: Column(
                children: [
                  Icon(
                    feature['icon'] as IconData,
                    size: 48,
                    color: AppColors.primary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    feature['title'] as String,
                    style: AppTheme.heading2.copyWith(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    feature['description'] as String,
                    style: AppTheme.body1.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildScrollToTopButton() {
    return AnimatedOpacity(
      opacity: _scrollController.hasClients && _scrollController.offset > 100 ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 200),
      child: FloatingActionButton(
        onPressed: () {
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.arrow_upward),
      ),
    );
  }

  void _redeemCoupon(Coupon coupon) {
    // Implement coupon redemption logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Coupon ${coupon.code} redeemed successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _scrollToFeaturedCoupons() {
    final screenHeight = MediaQuery.of(context).size.height;
    _scrollController.animateTo(
      screenHeight - 100, // Adjust this value as needed
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  int _getGridCrossAxisCount(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width > 1200) return 4;
    if (width > 900) return 3;
    if (width > 600) return 2;
    return 1;
  }

  @override
  void dispose() {
    searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}