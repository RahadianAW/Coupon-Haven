// lib/widgets/navbar/custom_navbar.dart
import 'package:flutter/material.dart';
import 'package:marvel_movies/pages/login_page.dart';
import 'package:marvel_movies/pages/profile_page.dart';
import '../../utils/constants.dart';

class CustomNavbar extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController searchController;
  final Function(String) onSearch;

  const CustomNavbar({
    super.key,
    required this.searchController,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Row(
            children: [
              // Logo
              Image.asset(
                'assets/logo.png',
                height: 32,
              ),
              const SizedBox(width: 40),
              // Search
              Expanded(
                child: TextField(
                  controller: searchController,
                  onChanged: onSearch,
                  decoration: InputDecoration(
                    hintText: 'Search for coupons...',
                    hintStyle: TextStyle(color: AppColors.textSecondary),
                    prefixIcon: Icon(Icons.search, color: AppColors.textSecondary),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 24),
              // Auth Buttons
              _NavbarButton(
                icon: Icons.login,
                label: 'Login',
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()),
              )),
              const SizedBox(width: 12),
              _NavbarButton(
                icon: Icons.person_outline,
                label: 'Profile',
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage()),
              ),
          )],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(72);
}

class _NavbarButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _NavbarButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  State<_NavbarButton> createState() => _NavbarButtonState();
}

class _NavbarButtonState extends State<_NavbarButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: TextButton.icon(
        onPressed: widget.onPressed,
        icon: Icon(
          widget.icon,
          color: isHovered ? AppColors.primary : AppColors.textPrimary,
        ),
        label: Text(
          widget.label,
          style: TextStyle(
            color: isHovered ? AppColors.primary : AppColors.textPrimary,
          ),
        ),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
      ),
    );
  }
}