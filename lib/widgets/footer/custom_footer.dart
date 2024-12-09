// lib/widgets/footer/custom_footer.dart
import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class CustomFooter extends StatelessWidget {
  const CustomFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.footerBackground,
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Brand Column
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('assets/logo_white.png', height: 40),
                    const SizedBox(height: 16),
                    Text(
                      'Your One Place to Find Exceptional Coupons',
                      style: AppTheme.subtitle1.copyWith(color: Colors.white70),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 64),
              // Quick Links
              Expanded(
                child: _FooterLinkSection(
                  title: 'Quick Links',
                  links: {
                    'About Us': () {},
                    'Contact': () {},
                    'Terms of Service': () {},
                    'Privacy Policy': () {},
                  },
                ),
              ),
              const SizedBox(width: 32),
              // Help Section
              Expanded(
                child: _FooterLinkSection(
                  title: 'Help',
                  links: {
                    'FAQ': () {},
                    'Support': () {},
                    'Return Policy': () {},
                    'Shipping Info': () {},
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 48),
          const Divider(color: Colors.white24),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '© ${DateTime.now().year} Coupon Haven. All rights reserved.',
                style: const TextStyle(color: Colors.white60),
              ),
              Row(
                children: [
                  _SocialButton(icon: Icons.facebook, onPressed: () {})
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FooterLinkSection extends StatelessWidget {
  final String title;
  final Map<String, VoidCallback> links;

  const _FooterLinkSection({
    required this.title,
    required this.links,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTheme.heading2.copyWith(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 24),
        ...links.entries.map((entry) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _FooterLink(
            text: entry.key,
            onTap: entry.value,
          ),
        )),
      ],
    );
  }
}

class _FooterLink extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  const _FooterLink({
    required this.text,
    required this.onTap,
  });

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<_FooterLink> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Text(
          widget.text,
          style: TextStyle(
            color: isHovered ? Colors.white : Colors.white70,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _SocialButton({
    required this.icon,
    required this.onPressed,
  });

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: IconButton(
        icon: Icon(
          widget.icon,
          color: isHovered ? Colors.white : Colors.white70,
        ),
        onPressed: widget.onPressed,
      ),
    );
  }
}